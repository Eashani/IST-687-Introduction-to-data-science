

##################################################################
# IST 687 - Introduction to Data Science
# Homework 1
# Due Date - 03 October 2018
# Submitted by Eashani Deorukhkar on 02  October 2018

##################################################################

# install the package rjson to be able to work with JSON in R
# library loads the rjson package into the environment

library("RJSONIO")
library("rjson")
library("RCurl")
library("dplyr")
library("jsonlite")
##################################################################

# Step A: Load the data

#getURL downloads data from the internet 
data1 <- getURL("http://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD")

# fromJSON: saves a JSON file as an R object
accdb <- fromJSON(data1)

# This code was found on kaggle 
# https://www.kaggle.com/robertoruiz/how-convert-json-files-into-data-frames-in-r
accdb <- as.data.frame(do.call("cbind", accdb))

##################################################################

# Step B: Clean the data

# remove first 8 columns (also removes the metadata)
accdb <- accdb[,10:27]

# rename remaining columns
namesOfColumns <- c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD","INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION","CITY_NAME","COUNTY_CODE","COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")
names(accdb) <- namesOfColumns
accdb <- na.omit(accdb)
##################################################################

# Step C: Explore the data - using the dataframe you created

#	What was the total number of accidents with injuries?

# nrow counts the number of rows
nrow(accdb[accdb$INJURY=="YES",])

#	How many accidents happened on Sunday?

# grep is used for pattern matching
# useful when the data may not be very well input
length(grep("SUNDAY",accdb$DAY_OF_WEEK))

# How many injuries occurred each day of the week?

# tapply is used to apply a function to a variable and group the results based on another variable
# syntax: tapply(variable to be worked on,grouping variable,function)
# the columns are unlisted because tapply works with atomic vectors
accdb1 <- accdb[accdb$INJURY=="YES",]
tapply(unlist(accdb1$INJURY),unlist(accdb1$DAY_OF_WEEK),length)

###################################################3##############

#Step D: Explore the data - using dplyr

# The example code 
# I kept getting errors while running this code because INJURY is a character vector and
# thus cannot be summed up  
# I think this code intends to calculate how many injuries occurred each day of the week?
# Hint: Use and explain the following lines of code (document each line)
# df.GroupBydays <- group_by(df, DAY_OF_WEEK)
# accidents <- summarize(df.GroupBydays, count = n(), injury = sum(INJURY))

# these are the 2 methods that worked
# note: unlist is used because lists cannot be used as grouping variables

# 1
# this method uses count which counts the number of occurrences
# the code below counts the occurrences based on 2 variables, injury and day of week
# so the 2 types of counts are 
# "how many accidents occurred on a given day that had injuries associated with them"
# "How many accidents occurred on a given day that had no injuries associated with them"
 na.omit(as.data.frame(count(accdb,injury=unlist(INJURY),day=unlist(DAY_OF_WEEK))))

# 2
# the code below first groups the data based on the 2 variables
# the summarize function can be used to manipulate data and find summaries eg. mean, std deviation etc
# n() is used to find the counts of the variables, it has to be used in conjunction with one of the
# dplyr functions
df.GroupBydays <- group_by(accdb, day=unlist(DAY_OF_WEEK),injury=unlist(INJURY))
accidents <- na.omit(data.frame(summarise(df.GroupBydays, count = n())))
accidents

# henceforth the summarize and group_by functions are combined and written in a single line
# the results of the data manipulation are stored in a data frame for easy subsetting


#	What was the total number of accidents with injuries?
# 6433
# the data is only grouped by the injury variable and the counts are saved
# the resulting data frame is filtered to show only the counts of records where injuries occurred
accWithInj1 <- as.data.frame(na.omit(summarize(group_by(accdb, injury=unlist(INJURY)),count = n())))
filter(accWithInj1,accWithInj1$injury=="YES")

# How many accidents happened on Sunday?
# 2373  

# The data is grouped with the DAY_OF_WEEK variable where the number of accidents per day are calculated
# the resulting data frame is filtered to show only the counts of records for SUNDAY
accOnSun <- as.data.frame(na.omit(summarize(group_by(accdb, day=unlist(DAY_OF_WEEK)),count = n())))
accOnSun$day <- trimws(accOnSun$day)
filter(accOnSun,accOnSun$day=="SUNDAY")

# How many injuries occurred each day of the week?
# the data is grouped based on 2 variables, the injury variable and the DAY_OF_WEEK variable
# the data frame is filtered to show how many accidents with injuries occurred everyday
injPerDay <- na.omit(data.frame(summarise(group_by(accdb, day=unlist(DAY_OF_WEEK),injury=unlist(INJURY)),count = n())))
filter(injPerDay,injPerDay$injury=="YES")


# In a block comment, explain if you find doing the analysis with the dataframe directly, 
# or using dplyr easier

# I find analysis using dplyr easier because it it has a lot more functionalities than dataframes
# eg- the question: How many injuries occurred each day of the week?
# was a lot more difficult to solve with simple dataframes as compared to with dplyr


##################################################################################################

# Step D: Explore the distribution of the number of vehicles in accidents

# What is the distribution of the number of vehicles in accidents on Friday?(use a histogram and quantile)

# trim whitespaces
accdb$DAY_OF_WEEK=trimws(accdb$DAY_OF_WEEK)

#filter for entries for friday
histinj1 <- filter(accdb,accdb$DAY_OF_WEEK=="FRIDAY",!is.na(VEHICLE_COUNT))

#plots in new window
windows()

# distribution of the number of vehicles in accidents on Friday
histinj1$VEHICLE_COUNT=as.numeric(histinj1$VEHICLE_COUNT)

# histogram
hist(histinj1$VEHICLE_COUNT,main="accidents on friday")

# quantile
quantile(histinj1$VEHICLE_COUNT,na.rm=T)

#filter for entries for sunday
histinj2 <- filter(accdb,accdb$DAY_OF_WEEK=="SUNDAY",!is.na(VEHICLE_COUNT))

# plots in new window
windows()

# distribution of the number of vehicles in accidents on sunday

#change values to numeric
histinj2$VEHICLE_COUNT=as.numeric(histinj2$VEHICLE_COUNT)

#histogram
hist(histinj2$VEHICLE_COUNT,main="accidents on sunday")

# quantile
quantile(histinj2$VEHICLE_COUNT,na.rm=T)

# Comparing the 2 distributions

# there are more accidents on friday than on sunday
# the median of the friday distribution is higher than the sunday distribution.
# However friday has had a maximum of 7 accidents in a day as compared to 8 on sunday
