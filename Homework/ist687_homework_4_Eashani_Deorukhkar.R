##################################################################
# IST 687 - Introduction to Data Science
# Homework 1
# Due Date - 26 September 2018
# Submitted by Eashani Deorukhkar on 1 October 2018

#################################################################

# Part A: Write a function to reveal the distribution of a vector of numeric values

printVecInfo <- function(vec1){
# Calculate and Print mean, median, min & max, standard deviation and 0.05 and 0.95 quantiles and
# label them with the appropriate names
  
  #mean
  mean1 <- mean(vec1)
  print(paste0("mean: ",mean1))
  
  #median
  median1 <- median(vec1)
  print(paste0("median :",median1))
  
  #minimum
  min1 <- min(vec1)
  print(paste0("min: ",min1))
  
  #maximum
  max1 <- max(vec1)
  print(paste0("max: ",max1))
  
  #std deviation
  sd1 <- sd(vec1)
  print(paste0("std dev: ",sd1))
  
  #5th quantile
  qt1 <- quantile(vec1,0.05)
  print(paste0("quantile 0.05: ",qt1))
  
  #95th quantile
  qt2 <- quantile(vec1,0.95)
  print(paste0("quantile 0.95: ",qt2))
  
# I was not sure if label meant just naming them using print or by using the names function
  vec2 <- list()
  #mean
  mean1 <- mean(vec1)
  vec2 <- c(vec2,mean1)
  
  #median
  median1 <- median(vec1)
  vec2 <- c(vec2,median1)
  
  #minimum
  min1 <- min(vec1)
  vec2 <- c(vec2,min1)
  
  #maximum
  max1 <- max(vec1)
  vec2 <- c(vec2,max1)
  
  #std deviation
  sd1 <- sd(vec1)
  vec2 <- c(vec2,sd1)
  
  #5th quantile
  qt1 <- quantile(vec1,0.05)
  vec2 <- c(vec2,qt1)
  
  #95th quantile
  qt2 <- quantile(vec1,0.95)
  vec2 <- c(vec2,qt2)
  
  #naming the vector elements
  names1 <- list("mean", "median", "min", "max", "standard deviation" ,"0.05 quantile","0.95 quantile")
  names(vec2) <- names1
  return(vec2)
}

#testing the function for accuracy
testVector <- 1:10
printVecInfo(testVector) # prints the mean, median, min & max, standard deviation and 0.05 and 0.95 quantiles 

###########################################################################################33

# Part B: Read the census dataset

# Use read.csv( ) and url( ) to read a CSV file from the web into a data frame

# the url sometimes keeps throwing errors hence using a downloaded version on the data

# the line below was the original code

# dfStates <- read.csv(url("https://www2.census.gov/programs-surveys/popest/datasets/2010-2017/state/asrh/scprc-est2017-18+pop-res.csv"))
func1 <- function(){

  # reads the csv file with raw data
  dfStates <- read.csv("hw3_dataset.csv")

  # removes the first row and the last row, with state = USA and state = Puerto rico commonwealth 
  # and the first four columns SUMLEV	REGION	DIVISION	STATE

  dfStates <- dfStates[,c(-1,-2,-3,-4)]
  dfStates <- dfStates[c(-1,-53),] 

  # renaming the remaining columns
  # the colnames function is used to rename columns and the rownames function is used for rows

  colnames(dfStates)[c(1,2,3,4)] <- c("stateName", "population", "popOver18", "percentOver18")

  #returns the clean dataframe
  return(dfStates)
}

# save cleaned dataframe in dfStates
dfStates <- func1() 
######################################################################################################

# Part C: Sample from the state population data frame

# sample 20 observations from the population and use the printVecInfo function to display the results

popsample <- sample(dfStates$population,20)
printVecInfo(popsample)


# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(popsample)

# repeat it twice

popsample <- sample(dfStates$population,20)
printVecInfo(popsample)


# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(popsample)

popsample <- sample(mean(dfStates$population),20)
printVecInfo(popsample)


# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(popsample)


# the values are different all 3 times because the sample() function selects a sample of 20 random rows
# from the dataset each time it is run

########################################################################################################

# Part D

# use the replicate function)
repdata <- replicate(2000,mean(sample(dfStates$population,20)))

printVecInfo(repdata)
# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(repdata)
# use the replicate function
repdata <- replicate(20000,mean(sample(dfStates$population,20)))

printVecInfo(repdata)
# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(repdata)

# use the replicate function
repdata <- replicate(20000,mean(sample(dfStates$population,20)))

printVecInfo(repdata)
# Histogram of state populations

# changes scientific notation on plot axis to numeric
options(scipen=5)

# creates the plots in new windows
windows()


# creates a histogram
hist(repdata)


#the new histogram is more bell shaped than the earlier one because it uses more data and 
# according to the central limit theorem a a distribution tends to have a normal 
# curve as the sample size gets larger