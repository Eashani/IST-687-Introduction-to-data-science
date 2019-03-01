##################################################################
# IST 687 - Introduction to Data Science
# Homework 1
# Due Date - 05 September 2018
# Submitted by Eashani Deorukhkar on 30 August 2018

#################################################################

# Step A- creating a vector

# create the vectors grades and courseName and the variable betterThanB


grades <- c(4.0,3.3,3.7)
print(grades)
courseName <- c("Bio","Math","History")
print(courseName)
betterThanB <- 3
print(betterThanB)

# Step B- Calculate statistics using R

average1 <- mean(grades)    # average calculated with mean()
print(average1)
total.length <- length(grades) # length of grades vector
print(total.length)
total <- sum(grades)
print(total)
average2 <- total/total.length  # average calculated with total.length and total

print(average2)

# Step C- Using the max/min functions in R
# calculate max and min grades
maxG <- max(grades)
minG <- min(grades)
print("max grade")
maxG
print("min grade")
minG

# Step D- Vector Math

betterGrades <- grades+0.3  # add 0.3 to grades
average3 <- mean(betterGrades)
print("average with grades+0.3")
average3

#Step E- Using Conditional if statements

  #test if maxG is greater than 3.5 and print yes or no
if(maxG > 3.5){  
  print("Yes")
} else {
  print("No")
}

  #test if minG is greater than betterThanB and print yes or no
if(minG > betterThanB){
  print("Yes")
} else{
  print("No")
}

#Step F- Accessing an element in a vector
print(courseName[2]) #prints Math