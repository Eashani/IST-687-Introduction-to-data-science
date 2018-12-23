
library("ggplot2")
dataframe <- dataset
str(dataframe)


SatisfactionClass <- ggplot(dataframe) +geom_bar(mapping=aes(x=Class, fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
theme_classic()
SatisfactionShopping <- ggplot(dataframe) +geom_bar(mapping=aes(x=Shopping.Amount.at.Airport, fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
theme_classic()
SatisfactionEatingAndDrinking <- ggplot(dataframe) +geom_bar(mapping=aes(x=Eating.and.Drinking.at.Airport, fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
theme_classic()
SatisfactionDayOfMonth <- ggplot(dataframe) +geom_bar(mapping=aes(x=Day.of.Month, fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
theme_classic()
#Class variable
#SatisfactionClass <- ggplot(dataframe, aes(x = Class,y = Satisfaction))+facet_grid(southeast ~ .)+geom_count()+
  #stat_summary(aes(y=Satisfaction),fun.y="mean",size=2,colour='red',geom="point") 

#For airlines other than Southeast, 
#Business class has highest rating (average) at 3.5, followed by Eco and then Eco plus
#The same trend is followed by Southeast airlines

#Day of month


#For airlines other than Southeast, 
#the satisfaction value averages around 3.3 for almost all days of month
#For Southeast airlines, the satisfaction value differs for different days.
#For the 4th, 7th, 10th days, it is 3.5 with values lesser than that for the other days


#Shopping amount at Airport
#SatisfactionShopping <- ggplot(dataframe) +geom_bar(mapping=aes(x=Shopping.Amount.at.Airport, fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
#theme_classic()
#cor(dataframe$Shopping.Amount.at.Airport, dataframe$Satisfaction)
#For airlines other than Southeast, 
#Shopping amount ranges from 0 to 900
#with customers who spend 700-800 units rating the Satisfaction at 4 (max) and 
#customers who spend 800-900 units rating the Satisfaction at 3 (min)
#For Southeast airlines, 
#Shopping amount ranges from 0 to 600
#with customers who spend 500-600 units rating the Satisfaction at 4 (max) and
#customers who spend 400-500 units rating the satisfaction at around 3.2 (min)

#This gives us an insight that customers do not spend more than 600 units on
#Shopping at airport when they are a Southeast customer

#The correlation between the two variables is 1.7% which is not very high

#Eating and drinking at airport
#SatisfactionEatingAndDrinking <- ggplot(dataframe) +geom_bar(x=Eating.and.Drinking.at.Airport,mapping=aes(fill=Satisfaction),position="fill", width=0.4)+scale_fill_grey()+
#theme_classic()
#cor(dataframe$Satisfaction, dataframe$Eating.and.Drinking.at.Airport)
#For airlines other than Southeast, 
#Eating and Drinking amount ranges from 0 to 900
#with customers who spend 700-800 units rating the Satisfaction at 3.8 (max) and 
#customers who spend 500-600 units rating the Satisfaction at 3 (min)
#For Southeast airlines, 
#Eating and Drinking amount ranges from 0 to 800
#with customers who spend 700-800 units rating the Satisfaction at 5 (max) and
#customers who spend 200-300 units rating the satisfaction at around 3.3 (min)

#The 750 value could be an outlier (since we are getting an average rating of 5)

#The correlation between the two variables is 0.01% which is not very high

