
##################################################################
# IST 687 - Introduction to Data Science
# Homework 8
# Due Date - 24 October 2018
# Submitted by Eashani Deorukhkar on  23 October 2018

##################################################################

# load libraries needed for JSON files
library(ggplot2)
library(jsonlite)
library(maps)
library(dplyr)

##################################################################
# Part A: Load and condition the data  
##################################################################

# load the data and use the str command to view it
df <- fromJSON(file.choose())
df<-data.frame(df)
str(df)

#################################################################
#Part B: Explore the data  
#################################################################
# create bivariate plots for each of the variables
windows()

# As customer satisfaction is the dependent variable, it will be plotted on the Y axis
# the jitter command is used to add noise to the data

# plot of hotel size versus customer satisfaction
plot1 <- ggplot(df,aes(jitter(hotelSize),overallCustSat)) + geom_point()
plot1

# plot of checkin satisfaction versus customer satisfaction
plot2 <- ggplot(df,aes(jitter(checkInSat),overallCustSat)) + geom_point() 
plot2



# plot of hotel state versus customer satisfaction
# I calculated the average satisfaction per state using dplyr and then plotted it using a bar plot

#dplyr
statecount <- df %>%
  group_by(hotelState) %>%
  summarize(mean1 = mean(overallCustSat))

#convert to dataframe
statecount <- as.data.frame(statecount)

#plot of states versus average customer satisfaction
plot3 <- ggplot(statecount,aes(hotelState,mean1)) + geom_bar(stat="identity") + theme(axis.text.x = element_text(angle = 90, hjust = 1))
plot3

# plot of cleanliness rating vs customer satisfaction
plot4 <- ggplot(df,aes(jitter(hotelClean),overallCustSat)) + geom_point() 
plot4

# plot of staff friendliness versus customer satisfaction
plot5 <- ggplot(df,aes(jitter(hotelFriendly),overallCustSat)) + geom_point() 
plot5

# plot of gender versus customer satisfaction
# I calculated the average satisfaction per gender using dplyr and then plotted the mean using geom_point()

gendercount <- df %>% group_by(gender) %>% summarize(mean1 = mean(overallCustSat))
gendercount <- as.data.frame(gendercount)

plot6 <- ggplot(gendercount,aes(gender,mean1)) + geom_point()
plot6

# plot of guest age versus customer satisfaction
plot7 <-  ggplot(df,aes(jitter(guestAge),overallCustSat)) + geom_point() 
plot7

# plot of length of stay versus customer satisfaction
plot8 <-  ggplot(df,aes(jitter(lengthOfStay),overallCustSat)) + geom_point()
plot8

# plot of  booking time versus customer satisfaction
plot9 <- ggplot(df,aes(jitter(whenBookedTrip),overallCustSat)) + geom_point() 
plot9

# plot1 - most of the observations lie in the 5-10 range but there are a few outliers 
# plot2 -  most of the observations again lie in the 5-10 range with a few outliers 
# plot3 - the states on an average have similar average values but California, Pennsylvania and West 
# Virginia have slightly higher averages

# plot4 - there are more outliers here in the hotel clean variable and it is more spread out
# plot5 - the customer satisfaction is seen increasing as the friendliness score increases
# plot6 - males on an average have a marginally higher satisfaction rating than women
# plot7 - most guests lie in the 40-60 age group with a few outliers
# plot8 - the average length of stay is 1-4 nights 
# plot9 - there is no specific pattern to the data suggesting that it is not an accurate predictor

##################################################################
#Part C: Generate a linear model  
##################################################################

#linear model
model1  <- lm(overallCustSat~hotelSize+checkInSat+hotelState+hotelClean+hotelFriendly+gender+guestAge+lengthOfStay+whenBookedTrip,data=df)
model1
summary(model1)
# r squared: 0.6702
# adjusted r squared: 0.6682

# the statistically significant variables can be determined based on the p-values

# the statistically significant variables are the intercept,checkInSat, hotelClean, hotelFriendly,
#guestAge,lengthOfStay, whenBookedTrip

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
#(Intercept)                     8.321e+00  1.024e-01  81.276  < 2e-16 ***
#checkInSat                     -2.381e-01  5.544e-03 -42.940  < 2e-16 ***
#hotelClean                      4.042e-02  6.941e-03   5.824 5.93e-09 ***
#hotelFriendly                   1.122e+00  8.863e-03 126.557  < 2e-16 ***
#guestAge                       -1.205e-01  1.815e-03 -66.400  < 2e-16 ***
#lengthOfStay                   -3.284e-01  1.677e-02 -19.575  < 2e-16 ***
#whenBookedTrip                  6.421e-03  1.005e-03   6.387 1.77e-10 ***

# this model predicts the customer satisfaction based on the various independent variables
# the dependent variable is customer satisfaction
# the independent variables are (for explanation) checkinSat, guestAge, 
# the equation is
# custSat <- intercept + (checkInSatcoeff * checkInSatValue) + (guestAgeCoeff*guestAgeValue) + (genderCoeff*genderValue)
# putting in values
# custSat <-  8.321e+00 + (-2.381e-01 * checkInSatValue) + (-1.205e-01 * guestAgeValue) + (1.218e-02 * genderValue)
# gender is a dummy variable that can take only 2 values 1 or 0




####################################################################
#Part C: Generate a different linear model  
####################################################################

# simple regression with one variable
# customer satisfaction is the dependent variable and hotelClean is the independent variable

model1 <- lm(overallCustSat~hotelClean,data=df)
summary(model1)

#Coefficients:
#Estimate Std. Error t value Pr(>|t|)    
 #(Intercept) 4.242005   0.076529   55.43   <2e-16 ***
 #hotelClean  0.372821   0.009863   37.80   <2e-16 ***
# Multiple R-squared:  0.125,	Adjusted R-squared:  0.1249 

# it is seen that the R squared value reduces significantly and using a multiple regression model is 
# a more accurate method of predicting the customer satisfaction
