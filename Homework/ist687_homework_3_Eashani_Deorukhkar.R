##################################################################
# IST 687 - Introduction to Data Science
# Homework 1
# Due Date - 20 September 2018
# Submitted by Eashani Deorukhkar on 10 September 2018

#################################################################

# Step A: 

# Use read.csv( ) and url( ) to read a CSV file from the web into a data frame

# the url sometimes keeps throwing errors hence using a downloaded version on the data

# the line below was the original code

# dfStates <- read.csv(url("https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/state/asrh/scprc-est2017-18+pop-res.csv"))

dfStates <- read.csv("hw3_dataset.csv")

# Step B: 

# Clean the dataframe

View(dfStates)  # opens a data viewer (similar to a spreadsheet)
head(dfStates)  # displays the first few rows of the dataset
tail(dfStates)  # displays the last few rows of the dataset

# removes the first row and the last row, with state = USA and state = Puerto rico commonwealth
dfStates <- dfStates[,c(-1,-2,-3,-4)]
dfStates <- dfStates[c(-1,-53),] 
head(dfStates)
tail(dfStates)

# renaming the columns

colnames(dfStates)[c(1,2,3,4)] <- c("stateName", "population", "popOver18", "percentOver18")
names(dfStates)

#STEP C:

# function with no arguments but returns the cleaned dataframe


func1 <- function(){
  return(dfStates)
}
func1()

# STEP D:

# Explore the dataframe

# average population of the states

mean_pop <- mean(dfStates$population)  #6386651
print(mean_pop)

# State with highest population

#which.max displays the location of the max value

dfStates[which.max(dfStates$population),c(1,2)]  #California

# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(dfStates$population)

# the histogram is right skewed with a majority of the states having a relatively 
# low population of less than 10 million and very few states with higher populations

# Sort the dataframe by population (using order)
# default is ascending

dfStates_sorted <- dfStates[order(dfStates$population),]

#10 states with the lowest population

dfStates[1:10,]

#	Use barplot( ) to create a plot of each of the population from the sorted dataframe.
# What do you observe?

# opens plot in new window
windows()

barplot(dfStates_sorted$population, col=rainbow(51))
legend("topleft",legend=dfStates_sorted$stateName,cex=0.4, fill=rainbow(51))

# it is observed that there is a very gradual increase in population overall  in every but the population 
# increases very sharply for a few states like texas, california and new york