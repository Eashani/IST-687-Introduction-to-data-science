
##################################################################
# IST 687 - Introduction to Data Science
# Homework 10
# Due Date -  14 November 2018
# Submitted by Eashani Deorukhkar on  14 November 2018

##################################################################

# set working directory to the one with the data
setwd("C:/Users/Eashani/Desktop/intro to DS/homework")

# load packages
library("dplyr")
library("jsonlite")
library("kernlab")
library("caTools")

#################################################################

# Part A: Load and condition the data
# 1)	The data is available on blackboard (hotelSurveyBarriot), as a JSON file.
# 2)	Name the dataframe hotelSurvey

#################################################################
# load data
jsonfile <- fromJSON(file.choose())

#convert to dataframe, remove freeText column
hotelSurvey <- as.data.frame(jsonfile)
hotelSurvey <- hotelSurvey[,-11]
hotelSurvey<-hotelSurvey[complete.cases(hotelSurvey),]

###################################################################

# Part B: Create a happy customer variable 
# 1)	To focus on predicting happy customers, we need to generate 
# a new column (where overallCustSat is 8 or higher).

###################################################################

# create new dummy variable
happyCust <- 0

happyCust[hotelSurvey$overallCustSat>=8] <- "happy"
happyCust[hotelSurvey$overallCustSat<8] <- "unhappy"
happyCust
happyCust <- as.factor(happyCust)
hotelSurvey <- cbind(hotelSurvey,happyCust)

###################################################################

# Part C: Create test and training sets
# 1) The training data should contain about two thirds of the whole data set, 
#    with the remaining one third going to the test data.
#	2) Use the dim( ) function to demonstrate that the resulting training data set 
#    and test data set contain the appropriate number of cases.


###################################################################
# split data using the caTools package
sample = sample.split(hotelSurvey$overallCustSat, SplitRatio = .67)
train = subset(hotelSurvey, sample == TRUE)
test  = subset(hotelSurvey, sample == FALSE)

# use the dim( ) function to demonstrate that the resulting training data set 
# and test data set contain the appropriate number of cases.
str(train)
str(test)


###################################################################

# Part D: Build a Model using ksvm( ) 
# 1) Build a support vector model using the ksvm( ) function using two or three of the variables 
#    to predict a happy customer. Once you have specified the model statement and the name of the 
#    training data set, you can use the same parameters as shown on page 237: kernel= "rbfdot", 
#    kpar = "automatic", C = 5, cross = 3, prob.model = TRUE
# 2) Write a block comment that summarizes what you learned from the book about those parameters. 
#    The two parameters of greatest interest are C=5 and cross=3.
# 3) Store the output of kvsm( ) in a variable and then echo that variable to the console.  

###################################################################

model1 <- ksvm(happyCust~hotelClean+hotelFriendly+checkInSat,data=train,kernel="rbfdot",kpar="automatic",C=5,cross=3,prob.model=TRUE)
model1

# Support Vector Machine object of class "ksvm" 
# 
# SV type: eps-svr  (regression) 
# parameter : epsilon = 0.1  cost C = 5 
# 
# Gaussian Radial Basis kernel function. 
# Hyperparameter : sigma =  0.400889696843689 
# 
# Number of Support Vectors : 2906 
# 
# Objective Function Value : -12460.81 
# Training error : 0.701607 
# Cross validation error : 0.181931 
# Laplace distr. width : 0.462943 


# explanation of function:

# The first argument, " happyCust~hotelClean+hotelFriendly+checkInSat",
# specifies the model we want to test. happyCust is the dependent variable we wish to predict
# the 3 independent variables are hotelClean,hotelFriendly,CheckInSat

# The "data" parameter denotes the data to be used, which is the "train" dataset in this case

# the kernel="rbfdot" refers to radial basis function.
# it takes the set of inputs from each row in a dataset and calculates a
# distance value based on the combination of the many variables in the row. The
# weighting of the different variables in the row is adjusted by the algorithm in order
# to get the maximum separation of distance between the happy and sad customer cases

# The "kpar" argument refers to a variety of parameters that can be used to
# control the operation of the radial basis function kernel. it can either have a specific number or 
# be "automatic"

# The C parameter tells the SVM optimization how much you want to avoid misclassifying each training example.
# For large values of C, the optimization will choose a smaller-margin hyperplane if that hyperplane 
# does a better job of getting all the training points classified correctly. Conversely, a very small value 
# of C will cause the optimizer to look for a larger-margin separating hyperplane, 
# even if that hyperplane misclassifies more points. For very tiny values of C, 
# you should get misclassified examples, often even if your training data is linearly separable.


###################################################################

# Part E: Predict Values in the Test Data and Create a Confusion Matrix
# 1)	Use the predict( ) function to validate the model against test data. 
# 2)	Now the svmPred object contains a list of votes in each of its rows. 
#     The votes are either for "happy" or "notHappy". 
#     Review the contents of svmPred using str( ) and head( ).
# 3)	Create a confusion matrix (a 2 x 2 table) that compares t
#     he second row of svmPred to the contents of testData$happy variable.
# 4)	Calculate an error rate based on what you see in the confusion matrix.

###################################################################

svmPred1 <- predict(model1, test,type="votes")
str(svmPred1)
confusionMatrix1 <- table(svmPred[1,],test$happyCust)
confusionMatrix1
# error rate
rate1 <- (confusionMatrix1[1,1]+confusionMatrix1[2,2])/sum(confusionMatrix)
rate1

# error rate: 0.479697
# the error rate is high and so different variables will be used in the later models

###################################################################

# Part F: Find a good prediction
# 1)	Repeat Parts C and D to try and improve your prediction
# 
# 2)	Explain, in a block comment, why it is valuable to have a "test" dataset 
#     that is separate from a "training" dataset?

###################################################################

model2 <- ksvm(happyCust~hotelClean+whenBookedTrip+checkInSat,data=train,kernel="rbfdot",kpar="automatic",C=5,cross=3,prob.model=TRUE)
model2
svmPred2 <- predict(model2, test,type="votes")
str(svmPred2)
confusionMatrix2 <- table(svmPred2[1,],test$happyCust)
confusionMatrix2
# error rate
rate2 <- (confusionMatrix2[1,1]+confusionMatrix2[2,2])/sum(confusionMatrix2)
rate2

# error rate: 0.1718182


model3 <- ksvm(happyCust~lengthOfStay+hotelFriendly+whenBookedTrip,data=train,kernel="rbfdot",kpar="automatic",C=5,cross=3,prob.model=TRUE)
model3
svmPred3 <- predict(model3, test,type="votes")
str(svmPred3)
confusionMatrix3 <- table(svmPred3[1,],test$happyCust)
confusionMatrix3
# error rate
rate3 <- (confusionMatrix3[1,1]+confusionMatrix3[2,2])/sum(confusionMatrix3)
rate3

# error rate: 0.1354545

# the error rate reduces as you change the variables

# It is better to have 2 separate datasets because it allows you to validate the accuracy of your dataset
# and parameters of your model can be verified based on the result of running the model on your test dataset