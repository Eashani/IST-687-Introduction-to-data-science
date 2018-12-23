
library(ggplot2)
library(dplyr)



#convert the target variable to numeric
#to perfrom various EDA operations





#as plotting the whole date has no meaning,
#plot it with day off the week_days

#day of the month is already present as a variable
#the spread is more for southeast Airlines
#also few values fall near Satisfaction 3 and below

fD1<-ggplot(data)+geom_bar(mapping=aes(x=week_days,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
fD1
#more people seem to be not satisfied on thursdays
#the Satisfaction for southeast is more on tuesdays
#the remaining are almost same for all days



#the Satisfaction for different airlines is seen
#almost all of them have an average Satisfaction of 3.5

fD2<-ggplot(data)+geom_bar(mapping=aes(x=Airline.Name,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
fD2


#few of them lead to Satisfaction 3
fD3<-ggplot(data)+geom_bar(mapping=aes(x=Scheduled.Departure.Hour,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
fD3
#people are more not satisfied for scheduled departure hours 3,6 and 7

fD4<-ggplot(data)+geom_bar(mapping=aes(x=Departure.Delay.in.Minutes,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
fD4
#the more the delay depature, the less the people are satisfied
