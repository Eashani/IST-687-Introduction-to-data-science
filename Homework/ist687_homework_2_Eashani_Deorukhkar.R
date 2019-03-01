##################################################################
# IST 687 - Introduction to Data Science
# Homework 1
# Due Date - 12 September 2018
# Submitted by Eashani Deorukhkar on 7 September 2018

#################################################################


### STEP A ###
#Initialize the arrests database

arrests <- USArrests

### STEP B ###
# a lower assault rate is technically the best when not
# considered in conjunction with other variables
# looked up syntax on https://stackoverflow.com/questions/24831580/return-row-of-data-frame-based-on-value-in-a-column-r

arrests[which(arrests$Assault==min(arrests$Assault)),]

### STEP C ###

# which state has the highest murder rate
# the "which" function is used to select data based on certain conditions

arrests[which(arrests$Murder==max(arrests$Murder)),]

# sorted dataframe based on murder rate(descending)
# the order function is used to sort data, default is ascending but a 
# -ve sign is used to change the order


sortedarrests <- arrests[order(-arrests$Murder),] 

# 10 states with the highest murder rate

#prints the first 10 entries

sortedarrests[1:10,]

# value of 20th row 3rd column of the sorted dataset

sortedarrests[20,3]

### STEP D ###

# If murder is assumed to be twice as serious as assault and rape 
# then weights can be assigned to these crime rates.
# (1,0.5,0.5 for murder,assault and rape respectively)
# If it is assumed that a higher urban population leads to a higher crime rate
# it can be factored into the equation too.


safety1 <- (arrests$Murder+(0.5*arrests$Rape)+(0.5*arrests$Assault))*arrests$UrbanPop

safetydata <- cbind(arrests,safety1)

# florida is the least safe by this metric


safetydata[order(-safety1),]

