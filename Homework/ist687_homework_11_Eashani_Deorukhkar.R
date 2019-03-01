
##################################################################
# IST 687 - Introduction to Data Science
# Homework 11
# Due Date -  28 November 2018
# Submitted by Eashani Deorukhkar on  28 November 2018

##################################################################

# set working directory to the one with the data
setwd("C:/Users/Eashani/Desktop/intro to DS/homework")

# load packages
library("dplyr")
library("jsonlite")
library("kernlab")
library("caTools")
library("tidytext")
library("tm")
library("wordcloud")
library("RColorBrewer")
#################################################################



#################################################################

# Part A: Load and condition the text file that contains the speech  
# 1)	The data is available on blackboard, as a JSON file 
# 2)	The key column to focus on is the 'freeText' column.

#################################################################


# load data
jsonfile <- jsonlite::fromJSON(file.choose())

#convert to dataframe, remove freeText column
hotelSurvey <- as.data.frame(jsonfile)

#remove all columns exceptt freeText 
hotelSurvey <- na.omit(hotelSurvey[,11])

# read 
ptext <- read.delim("positive-words.txt")
ptext <- ptext[-1:-34,]
ntext <- read.delim("negative-words.txt")
ntext <- ntext[-1:-34,]

####################################################################

# Part B: Create a list of word counts from the speech
# 1)	Starting with the code at the bottom of page 180 in the text book
#     use a similar approach to transform the free text into a term document matrix, 
#     and then determine positive and negative word matches.
# 2)	Calculate the percent positive words and negative words.
# 3)	Write a block comment that summarizes what you learned from ratioPos and ratioNeg.

####################################################################

# create a corpus of documents from the dataframe
words.corpus = Corpus(VectorSource(hotelSurvey))

# clean the corpus to remove numbers, punctuation, stopwords and convert to lower case
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
words.corpus <- tm_map(words.corpus, removePunctuation)
words.corpus <- tm_map(words.corpus, removeNumbers)
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))

# convert to a term document matrix
x <- TermDocumentMatrix(words.corpus)


# calculate positive and negative percent of words
mat <- as.matrix(x)
counts <- rowSums(mat)
counts <- sort(counts,decreasing=TRUE)
names1 <- names(counts)

# positive
matchpos <- match(names1,ptext)
matchposwords <- counts[which(matchpos!=0)]
poscount <- sum(matchposwords)
pospercent <- poscount/sum(counts)
pospercent

#negative
matchneg <- match(names1,ntext)
matchnegwords <- counts[which(matchneg!=0)]
negcount <- sum(matchnegwords)
negpercent <- negcount/sum(counts)
negpercent

# there are more positive words than negative words as the percentage of positive words is greater(17%) than
# negative words (4%) thus the data has more positive sentiments

##################################################################

# Part D: Visualize the results
# 1) Create a word cloud
#	2) Create a barplot of the positive and negative words that matched (at least twice)
# 3) Write a block comment on what you observe from these two barplots and the wordcloud. 
#	4) Does these results make sense to you in terms of the kinds of emotions you see?
#    Which do you think is more informative - barplot or the wordcloud?
##################################################################
 
# create word cloud 

wordclouddata <- data.frame(word=names(counts),freq=counts)
wordcloud(words=wordclouddata$word,freq=wordclouddata$freq,colors=brewer.pal(8, "Dark2"))

# create a bar plot for the same data
barplotcountspos <- counts[counts>=2]
names1 <- names(barplotcountspos)

matchwordspos <- match(names1,ptext)
matchwordspos <- barplotcounts[which(matchwordspos!=0)]

barplotcountsneg <- counts[counts>=2]
names1 <- names(barplotcountsneg)
matchneg <- match(names1,ntext)
matchnegwords <- barplotcountsneg[which(matchneg!=0)]

# appending counts of negative and positive matched words
wordstotal <- append(matchwordspos,matchnegwords)
barplot(wordstotal)

# the barplot echoes the same results as the wordcloud as the counts of positive words
# like friendly and nice is high
# the wordcloud is more informative as it is easier to visually understand the results especially for 
# people who may have trouble understanding graphs

####################################################################
# Part E: Evaluate Happy and not Happy customer responses
#	1) Create two subset of the text vectors: one for happy customers and one for not happy customers (based on overall customer satisfaction).
#	2) Redo Steps B, C & D, for these two subsets of the text strings.
# 3) Compare the positive and negative ratios for these two different group of customers 

happyCust <- 0
hotelSurvey <- as.data.frame(jsonfile)
happyCust <- hotelSurvey[hotelSurvey$overallCustSat>=8,]
sadCust <- hotelSurvey[hotelSurvey$overallCustSat<8,]
happyCust <- happyCust[,11]
sadCust <- sadCust[,11]


# happyCust

words.corpus1 = Corpus(VectorSource(happyCust))
words.corpus1 <- tm_map(words.corpus1, content_transformer(tolower))
words.corpus1 <- tm_map(words.corpus1, removePunctuation)
words.corpus1 <- tm_map(words.corpus1, removeNumbers)
words.corpus1 <- tm_map(words.corpus1, removeWords, stopwords("english"))
x1 <- TermDocumentMatrix(words.corpus1)

mat1 <- as.matrix(x)
counts1 <- rowSums(mat1)
counts1 <- sort(counts1,decreasing=TRUE)
names2 <- names(counts1)
matchpos1 <- match(names2,ptext)
matchposwords1 <- counts[which(matchpos1!=0)]
poscount1 <- sum(matchposwords1)
pospercent1 <- poscount1/sum(counts1)
pospercent1

matchneg1 <- match(names2,ntext)
matchnegwords1 <- counts[which(matchneg1!=0)]
negcount1 <- sum(matchnegwords1)
negpercent1 <- negcount1/sum(counts1)
negpercent1

# there are more positive words than negative words as the percentage of positive words is greater(17%) than
# negative words (4%) thus the data has more positive sentiments

##################################################################

# word cloud
wordclouddata1 <- data.frame(word=names(counts1),freq=counts1)
wordcloud(words=wordclouddata1$word,freq=wordclouddata1$freq,colors=brewer.pal(8, "Dark2"))

# barplot for positive and negative words for happy customer data
barplotcountspos1 <- counts1[counts1>=2]
names2 <- names(barplotcountspos1)

matchwordspos1 <- match(names2,ptext)
matchwordspos1 <- barplotcountspos1[which(matchwordspos1!=0)]

barplotcountsneg1 <- counts[counts1>=2]
names2 <- names(barplotcountsneg1)
matchneg1 <- match(names2,ntext)
matchnegwords1 <- barplotcountsneg1[which(matchneg1!=0)]

wordstotal1 <- append(matchwordspos1,matchnegwords1)
barplot(wordstotal1)

# sadCust
words.corpus2 = Corpus(VectorSource(sadCust))
words.corpus2 <- tm_map(words.corpus2, content_transformer(tolower))
words.corpus2 <- tm_map(words.corpus2, removePunctuation)
words.corpus2 <- tm_map(words.corpus2, removeNumbers)
words.corpus2 <- tm_map(words.corpus2, removeWords, stopwords("english"))
x2 <- TermDocumentMatrix(words.corpus2)

mat2 <- as.matrix(x2)
counts2 <- rowSums(mat2)
counts2 <- sort(counts2,decreasing=TRUE)
names3 <- names(counts2)
matchpos2 <- match(names3,ptext)
matchposwords2 <- counts[which(matchpos2!=0)]
poscount2 <- sum(matchposwords2)
pospercent2 <- poscount2/sum(counts2)
pospercent2

matchneg2 <- match(names3,ntext)
matchnegwords2 <- counts[which(matchneg2!=0)]
negcount2 <- sum(matchnegwords2)
negpercent2 <- negcount2/sum(counts2)
negpercent2

# word cloud
wordclouddata2 <- data.frame(word=names(counts2),freq=counts2)
wordcloud(words=wordclouddata2$word,freq=wordclouddata2$freq,colors=brewer.pal(8, "Dark2"))

# barplot for positive and negative words for sad customer data
barplotcountspos2 <- counts2[counts2>=2]
names3 <- names(barplotcountspos2)

matchwordspos2 <- match(names3,ptext)
matchwordspos2 <- barplotcountspos2[which(matchwordspos2!=0)]

barplotcountsneg2 <- counts[counts2>=2]
names3 <- names(barplotcountsneg2)
matchneg2 <- match(names3,ntext)
matchnegwords2 <- barplotcountsneg2[which(matchneg2!=0)]

wordstotal2 <- append(matchwordspos2,matchnegwords2)
barplot(wordstotal2)

# the percent positive ratio for the happy customer data is a higher than the negative ratio for the same data
# the percent negative ratio higher for the sad customer data than the positive ratio

# the happy customer wordcloud also has more positive words in it and the sad customer wordcloud has more
# negative words in it

# the barplots also show the same results. the counts of positive words are higher for the happy customer data
# and the counts of negative words are higher for the sad customer data