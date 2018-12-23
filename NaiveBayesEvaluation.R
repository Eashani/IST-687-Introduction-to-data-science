
model1<-'model1'

library(e1071)

clean_data <- na.omit(clean_data)

happyCust <- 1
med <- median(clean_data$Satisfaction)
happyCust[clean_data$Satisfaction>=med] <- 3
happyCust[clean_data$Satisfaction<med] <- 2

happyCust <- as.factor(happyCust)
clean_data1 <- cbind(clean_data,happyCust)
clean_data1 <- clean_data1[,-c(1)]

nb <- naiveBayes(happyCust ~ Airline.Status + Age + Gender +
           Price.Sensitivity + Year.of.First.Flight + No.of.Flights.p.a. +
              Type.of.Travel +
              Shopping.Amount.at.Airport +
              Class + Scheduled.Departure.Hour +Departure.Delay.in.Minutes +
             Arrival.Delay.greater.5.Mins, data = clean_data1)
             

summary(nb)

#Output for Summary of model

#        Length Class  Mode     
#apriori  2     table  numeric  
#tables  12     -none- list     
#levels   2     -none- character
#call     4     -none- call     

nb

#Output for Naive Bayes 

#Naive Bayes Classifier for Discrete Predictors

#Call:
#naiveBayes.default(x = X, y = Y, laplace = laplace)

#A-priori probabilities:
#Y
#       2        3 
#0.485563 0.514437 

#Conditional probabilities:
#   Airline.Status
#Y         Blue       Gold   Platinum     Silver
#  2 0.81628756 0.05895719 0.02475283 0.10000242
#  3 0.55883091 0.10604851 0.03979101 0.29532958

#   Age
#Y       [,1]     [,2]
#  2 49.78390 20.30972
#  3 42.73826 12.87123

#   Gender
#Y      Female      Male
#  2 0.6276197 0.3723803
#  3 0.5064911 0.4935089

#   Price.Sensitivity
#Y       [,1]      [,2]
#  2 1.326138 0.5700696
#  3 1.230259 0.5180028

#   Year.of.First.Flight
#Y       [,1]     [,2]
#  2 2007.199 2.996252
#  3 2007.207 2.959490

#   No.of.Flights.p.a.
#Y       [,1]     [,2]
#  2 23.41321 15.27507
#  3 16.77218 12.57571

#   Type.of.Travel
#Y   Business travel Mileage tickets Personal Travel
#  2      0.36524934      0.06715173      0.56759893
#  3      0.85489060      0.08528600      0.05982340

#   Shopping.Amount.at.Airport
#Y       [,1]     [,2]
#  2 25.68725 52.67634
#  3 27.49250 53.46744

#   Class
#Y     Business        Eco   Eco Plus
#  2 0.06884382 0.82063864 0.11051754
#  3 0.09480025 0.80681740 0.09838235

#   Scheduled.Departure.Hour
#Y       [,1]     [,2]
#  2 12.92260 4.634437
#  3 13.02437 4.580868

#   Departure.Delay.in.Minutes
#Y       [,1]     [,2]
#  2 17.73618 42.04413
#  3 12.31951 34.72743

#   Arrival.Delay.greater.5.Mins
#Y          no       yes
#  2 0.5776064 0.4223936
#  3 0.7161697 0.2838303


#Evaluation of the model is done as follows:

predP <- predict(nb, newdata = clean_data1, type = "class")
matrixSat <- table(predP,clean_data1$happyCust)
sumMatrix <- matrixSat[1,1] + matrixSat[2,2]

percSat <- sumMatrix/sum(matrixSat)
percSat <- percSat*100 
percSat


#[1] 76.9396

#Using the predict command, the happy customers were matched and a confusion matrix was created
#called matrixSat.

#Then the percentage calculation was done to find how accurate the model was.
#The division shows 0.7693 and was multiplied with hundred to show the percentage.
