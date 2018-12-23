
library(ggplot2)
library(dplyr)
df<-data

satisfactionArrivalDelay<-ggplot(df)+geom_bar(mapping=aes(x=Arrival.Delay.in.Minutes,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
#The percentage of satisfied and not satisfied customers is pretty much the same considering the Arrival Delay.
#Even when it is High, Average or Low.

satisfactionCancelled<-ggplot(df)+geom_bar(mapping=aes(x=Flight.cancelled,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
#It can be seen that there are more non satisfied people where flights are cancelled. 
#This is explainable as cancelled flights could result in a negative review.

satisfactionFlightTime<-ggplot(df)+geom_bar(mapping=aes(x=Flight.time.in.minutes,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
#Considering the flight time, there are almost equal number of satisfied and not satisfied customers.

satisfactionDistance<-ggplot(df)+geom_bar(mapping=aes(x=Flight.Distance,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
#Same as flight time, the flight distance also has almost equal percentage of satisfied and non satisfied customers.

satisfactionArrivalGreater<-ggplot(df)+geom_bar(mapping=aes(x=Arrival.Delay.greater.5.Mins,fill=Satisfaction),position="fill",width=0.4)+scale_fill_grey() + theme_classic()
#In this plot, it is shown that there are more non satisfied customers where the arrival delay is greater than
#5 minutes.
#This indicates that although there may not be a difference in just a regular arrival delay, if the delay is 
#greater than 5 minutes, then the satisfaction gets affected.
