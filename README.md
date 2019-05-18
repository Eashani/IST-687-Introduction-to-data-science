## Introduction
### Objective

We are working as a consulting company for Southeast Airlines. The focus of our survey analysis project is to provide some notions and directions to Southeast Airlines so that they can improve its profit and consumer satisfaction. Concrete analysis of the airlines' data containing 14 major airline companies in the United States including Southeast Airlines helps us generate some useful insights into customers mindsets.

### Background

The full Dataset contains about 129889 responses (rows) from airline customers survey throughout 3 months, and contains data from 14 airlines. The Dataset has 28 columns, which consist of data obtained from surveys submitted by its airline customers. The columns broadly focus on several categories, including customer’s gender, age, number of flights, shopping amount at the airport, type of travel, etc.
Our goal here is to understand what factors influence a customer’s satisfaction after taking a particular airline’s flight. There can be different relationships between customers and all these 28 variables. Some of them make sense whereas some of them won’t make sense. Also, Various recommendations could be provided to our client Southeast airlines based on these insights we get from data analysis and model creation.
There are many business questions to be answered for improving Southeast airlines’ service. So, they could better satisfy their customers and increase their profits. Also, It’s essential to understand the market in which you are playing your game. So, Understanding your competitor’s strategy gives you actionable insights on where you should stress on to improve your business.  

### Context

The Airlines data is a dataset collected from information about the customers taking various airline flights and giving their satisfaction ratings about the overall experience they had with the flight. Getting actionable insights from this dataset helps them improve the services, win more customers and increase revenues. The dataset that we got was dirty and required much cleaning due to inappropriate values and missing values in multiple columns which needs to be handled thoughtfully.
Southeast Airlines for understanding their customers and their experiences. We think that answering these questions will help Southeast executives know more about the ways to improve Southeast airline Services.
Models were also created to make predictions on customer satisfaction so that we could better understand the critical features and whether or not all the models depict the same findings or not and why.

### Scope

By playing with the features in the dataset doing some feature engineering, we can get insights on how we can improve Southeast services to improve customer satisfaction, attract new customers and encourage existing customers to avail Southeast airline services more frequently.
We have 29 features out of which some were not useful actually. here’s the detailed description of all the features.

- Satisfaction – it is rated from 1 to 5, that how satisfied is the customer? 
5 means higher satisfied, and 1 is lowest level of satisfaction.
- Airline Status – each customer has a different type of airline status or package, which are platinum, gold, silver, and blue. 
- Age – the specific customer’s age. That is starting from 15 to 85 years old.
- Gender – male or female.
- Price Sensitivity – the grade to which the price affects to customers purchasing. The price sensitivity has a range from 0 to 5.
- Year of First Flight – this attributes shows the first flight of each single customer. The range of year of the first flight for each - customer has been started in 2003 until 2012.
- No of Flights p. a. – this could be the number of flights that each customer has taken. The range starting from 0 to 100.
- Percent of Flight with other Airlines – if we were Southeast Airline, we would like to know how many time that customer fly with other - Airlines. 
- Type of Travel – is provide three traveling purpose for each consumer, which are business travel, mileage tickets that based on - loyalty card, and personal travel like to see the family or in vacation  
- No. Of other Loyalty Cards – it is kind of membership card of each customer, that for retail establishment to gain a benefits such as, discounts.  
- Shopping Amount at Airport – showing the costumer’s result of how many products have been purchased. The range of shopping amount is from 0 to 875.
- Eating and Drinking at Airport – it is the quantity eating and drinking per each consumer at the airport. The masseur of how often for eating and drinking, which is 0 to 895.    
- Class – it consisted of three different kinds of service level such as, business, and economy plus, economy. Moreover, customers have optional to choose their seat.
- Day of Month – it means the traveling day of each costumer. In this attribute, shows total of 31 days of the month.
- Flight date – all of these data are abbreviate the passenger’s flight date travel, which were since 2014 and only in January, February, and March.  
- Airline Code – basically, it is unique two or three digits that mean what is the specific type of airline. There are several codes that consumers have been going with. For example, AA, AS, B6, and DL.
- Airline Name – There are several airlines company names such as, West Airways, Southeast Airlines Co, and FlyToSun Airlines Inc. This attribute provide what airline name that passenger have been used.
- Origin City – refers to actual city that customers have departed from. For example, Yuma AZ, Waco TX, and Toledo HO.
- Origin State – same thing as origin city such as, what state that customers have departed from? A good example, Texas, Ohio, Alaska, and Utah.
- Destination City – the place to which passenger travels to. For example, Akron HO, Alpena MI, Austin TX, and Boston MA.
- Destination State – also, it is the same thing as origin city, such as, to what state passenger travel to? Some example of destination states, Alaska, Kentucky, Iowa, and Florida.
- Scheduled Departure Hour – the specific time at which passengers are scheduled to depart. In this data in scheduled departure hour is starting at 1 am until 23 pm.
- Departure Delay in Minutes – which are minutes of departure delayed for each passenger, when compared to schedule. In this data the rage are starting from 0 until 1128 minutes. 
- Arrival Delay in Minutes – how many minutes of arrival delayed of each passenger. Rang of delayed minutes in this data are starting from 0 until 1115 minutes. 
- Flight Cancelled – occurs when the airline dose not operates the flight at all, and that is for a certain reason.
- Flight time in minutes – indicate to period time to the destination.
- Flight Distance – the extent of space between two places. Also, that means how many minutes are passenger traveling between two different places. Rang in this data starting from 31 until 4983 minutes.
- Arrival Delay greater 5 Minutes – It means the delay of arrival airline time, which is more than 5 minutes per each passenger in the data.
