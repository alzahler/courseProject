# Course Project

#setwd("/Users/alejandrozahler/Dropbox/Mac-Flock/Zatrack/Cursos/Coursera/Diploma-DataScience/GettingAndCleaningData")
setwd("~")
library(reshape2)


#1 Merges the training and the test sets to create one data set.

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep ="", header = FALSE) 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep ="", header = FALSE) 
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep ="", header = FALSE) 

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep ="", header = FALSE) 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep ="", header = FALSE) 
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep ="", header = FALSE) 

#subject_train contains information od the ID of the volunteer in the experiment
#Y_train corresponds to the Activity the person was doing
#X_Train correspond to the Data of the measurments, in different units and transformations

#Merging Training Set First
tr <- cbind(subject_train, Y_train, X_train)

# Merging Test Set
t <- cbind(subject_test, Y_test, X_test)

#Merging Both
total <- rbind(tr,t)
# 10299 x563



#Step 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 


features <- read.table("./UCI HAR Dataset/features.txt", sep ="", stringsAsFactors = FALSE, header = FALSE) 
features <- features[,2]
#which columns - indexes - correspond mean or standard deviation

regex <- grep("[Mm]ean\\(\\)|std\\(\\)", features, value = FALSE)
ids <- 2 + regex

#Creating the new dataset, only with mean() & std()
mydata <- cbind(total[,1:2], total[,ids], deparse.level = 0)


#3
#Use descriptive activity names to name the activities in the data set

#Giving names to Subject and Activity columns
names(mydata)[1:2] <- c("subject","activity")

#Assigning and cleaning measurement's names
#exlude "()"

feat.mydata <- features[regex]
feat.mydata <-tolower(gsub("\\(\\)|-", "", feat.mydata))

names(mydata)[3:dim(mydata)[2]] <- feat.mydata



#4 Appropriately labels the data set with descriptive activity names. 
#Activities
a.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep ="", stringsAsFactors = FALSE,header = FALSE) 

a.labels[,2] <- tolower(sub("_", "", a.labels[,2]))
mydata$activity <- factor(mydata$activity, a.labels[,1], a.labels[,2])


#5
#Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

mydata$subject <- as.factor(mydata$subject)
freq.by.pairs <- table(mydata$subject,mydata$activity)

melt.mydata = melt(mydata, id = c("subject", "activity"))

tidy.data <- dcast(melt.mydata, formula = subject + activity ~ variable,mean)

write.csv(tidy.data, "./tidyData.csv") 

?write.csv
str(tidy.data)
