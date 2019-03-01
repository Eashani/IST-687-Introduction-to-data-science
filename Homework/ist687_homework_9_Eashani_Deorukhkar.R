
##################################################################
# IST 687 - Introduction to Data Science
# Homework 9
# Due Date -  07 November 2018
# Submitted by Eashani Deorukhkar on  07 November 2018

##################################################################

# set working directory to the one with the data
setwd("C:/Users/Eashani/Desktop/intro to DS/homework")

# load packages
library("dplyr")
library("rjson")
library("arules")
library("arulesViz")

#################################################################
# Part A: Explore Data Set
# 1)	Load the dataset: hotelSurveyBarriot.json (similar to HW8, but a different dataset)
# 2)	Name the dataframe hotelSurvey

#################################################################
# load data
jsonfile <- fromJSON(file.choose())

#convert to dataframe, remove freeText column
hotelSurvey <- as.data.frame(jsonfile)
hotelSurvey <- hotelSurvey[,-11]
buckets <- hotelSurvey
#################################################################
# Part B: Explore Data Set
# 1)	Ensure hotelSurvey is a dataframe, delete , and look at the structure via the str() command
# 2)	Map each numeric attribute to a category  
#################################################################

str(hotelSurvey)

# map numeric attributes to a category
# the numeric attributes are overallCustSat, hotelSize, checkInSat, hotelClean, hotelFriendly, guestAge
# lengthOfStay, whenBookedTrip

# converting each to a category (for values ranging from 0 to 10)
createBucket1 <- function(x){
  vBuckets <- replicate(length(x), "Average")
  vBuckets[x>round(mean(x))] <- "High"
  vBuckets[x<round(mean(x))] <- "low"
  return(vBuckets)
}

# converting to category (for other numeric values)
createBucket2 <- function(v)
{
  q <- quantile(v, c(0.4, 0.6))
  vBuckets <- replicate(length(v), "Average")
  vBuckets[v <= q[1] ]<- "Low"
  vBuckets[v > q[2]] <- "High"
  return(vBuckets)
  
}
# overallCustSat  

 
 hotelSurvey$overallCustSat <- as.factor(createBucket1(hotelSurvey$overallCustSat))

 
# hotelSize
 
 
 hotelSurvey$hotelSize <- as.factor(createBucket2(hotelSurvey$hotelSize))

 
# checkInSat
 
 hotelSurvey$checkInSat <- as.factor(createBucket1(hotelSurvey$checkInSat))
 
# hotelClean
 
 hotelSurvey$hotelClean<- as.factor(createBucket1(hotelSurvey$hotelClean))
 
# hotelFriendly
 
 hotelSurvey$hotelFriendly <- as.factor(createBucket1(hotelSurvey$hotelFriendly))
 
# guestAge
 
 hotelSurvey$guestAge <- as.factor(createBucket2(hotelSurvey$guestAge))
 
# lengthOfStay
 
 hotelSurvey$lengthOfStay <- as.factor(createBucket2(hotelSurvey$lengthOfStay))
 
# whenBookedTrip 

 hotelSurvey$whenBookedTrip  <- as.factor(createBucket2(hotelSurvey$whenBookedTrip))
 
# Count the people in each category of for the age and friendliness attributes
 agefriend <- table(hotelSurvey$guestAge,hotelSurvey$hotelFriendly)
 #           Average High  low
 # Average    1122  557   29
 # High        650 2749    3
 # Low        2901  199 1790
 
# Express the results above as percentages by sending the results of the table( ) 
# command into the prop.table( ) command
 
 prop.table(agefriend)
 
 #         Average   High    low
 # Average  0.1122 0.0557 0.0029
 # High     0.0650 0.2749 0.0003
 # Low      0.2901 0.0199 0.1790
 
 
# Show a "contingency table" of percentages for the age and the overall satisfaction variables together. 
# Write a block comment about what you see. 
 
 ageoverall <- table(hotelSurvey$guestAge,hotelSurvey$overallCustSat)
 ageoverall
 #         Average High  low
 # Average     703  917   88
 # High        747 2602   53
 # Low        2548 1232 1110
 prop.table(ageoverall)
 #         Average   High    low
 # Average  0.0703 0.0917 0.0088
 # High     0.0747 0.2602 0.0053
 # Low      0.2548 0.1232 0.1110
 
 # it is seen that people in the 40-60th age percentile("average" on the X axis) tend to  give more
 # lower ratings(25%). People in the 60 and above age percentile tend to give higher ratings(26%)
 # 12% of this group  tends to give lower ratings. Approximately 15% of the people in the 40th 
 # and below percentile age group tend to give lower ratings
 
# Coerce the hotelSurvey data frame into a sparse transactions matrix
 
 
 hotelSurveyX <- as(hotelSurvey,"transactions")
 
# Use the inspect( ), itemFrequency( ), and itemFrequencyPlot( ) commands 
# to explore the contents of hotelSurveyX.
  inspect(hotelSurveyX)
  itemFrequency(hotelSurveyX)
  itemFrequencyPlot(hotelSurveyX) 

# Run the apriori command to try and predict happy customers
# as defined by their overall satisfaction being high - above 7
 
 ruleset <- apriori(hotelSurveyX,
                    parameter = list(support = 0.1 , confidence = 0.5),
                    appearance = list(default = "lhs", rhs = ("overallCustSat=High")))
 
# Check Ruleset
 
 summary(ruleset)
 inspect(ruleset)

# The two most important rules based on the confidence interval and based on factors that can be controlled
# by the hotel manager are

# (1)
#  lhs                        rhs                   support confidence     lift count
#  {checkInSat=High}       => {overallCustSat=High}  0.2496  0.8038647 1.691991  2496
 
# 80% of the time, a high check in satisfaction leads to a high customer satisfaction

# (2) 
# lhs                        rhs                   support confidence     lift count
# {hotelFriendly=High}    => {overallCustSat=High}  0.2949  0.8413695 1.770931  2949
 
# 84% of the time, friendliness of the hotel staff leads to a better customer satisfaction rating 