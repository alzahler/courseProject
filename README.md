Course Project for "Getting and Cleaning Data"
====================================================

First, I set up the working directory and loaded the required libraries:

```
setwd("~")
library(reshape2)
```

The first task was:

1. Merge the training and the test sets to create one data set
------------------------------------------

For this, I loaded the relevant files, for the Test set first:
```
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep ="", header = FALSE) 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep ="", header = FALSE) 
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", sep ="", header = FALSE) 
```

... and then for the Train set.

```
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep ="", header = FALSE) 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep ="", header = FALSE) 
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", sep ="", header = FALSE) 
```

It is important to note that subject_train contains information od the ID of the volunteer in the experiment, `Y_train` corresponds to the Activity the person was doing and `X_Train` correspond to the data of the measurements, in different units and domains.

```
#Merging Training Set First
tr <- cbind(subject_train, Y_train, X_train)

# Merging Test Set
t <- cbind(subject_test, Y_test, X_test)

#Merging Both
total <- rbind(tr,t)
```

The merged data set, `total`, has the train data at the top and the test data at the bottom. Also, the 1st column corresponds to the subject variables, the second to the activity, and the following columns show the other variables of the data.
The dimensions of `total` is a data frame of 10299 x 563.




2. Extract only the measurements on the mean and standard deviation for each measurement. 
------------------------------------------

For this task, I used the features.txt file that has the names of all the 561 variables. 

```
features <- read.table("./UCI HAR Dataset/features.txt", sep ="", stringsAsFactors = FALSE, header = FALSE) 
features <- features[,2]
```

The 1 dimensional vector `features` has the names of all the quantitative variables. 
Then, I constructed a regular expression that could match the text "mean()" and "std()". I chose these two expressions because they indicate the correct statistic - mean and standard deviation - for each variable, as explained in the features_info.txt file.


```
#which columns - indexes - correspond mean or standard deviation
regex <- grep("[Mm]ean\\(\\)|std\\(\\)", features, value = FALSE)
ids <- 2 + regex
```
`regex` returns the index where the expression matched the text. Then, I had to add the constant 2 in order to shift the index since the quantitative data starts at index 3 in the `total` data frame.

Finally, I created a subset of the data with these.

```
#Creating the new dataset, only with mean() & std()
mydata <- cbind(total[,1:2], total[,ids], deparse.level = 0)
```

There were 66 variables that corresponded to mean or standard deviation measures.


3. Use descriptive activity names to name the activities in the data set
------------------------------------------

First, I gave names to the first two variables: the subject and the activity,

```
#Giving names to Subject and Activity columns
names(mydata)[1:2] <- c("subject","activity")
```

Then, I used the same regex built before to get the variable's names , and then I transformed them by deleting the brackets, the hyphens and the dots. Also, I used the lower case function. I found that the names of the variables were self explanatory and didn't need any further changes.

```
#Assigning and cleaning measurement's names
#delete "()" , "." and "-"
feat.mydata <- features[regex]
feat.mydata <-tolower(gsub("\\(\\)|-", "", feat.mydata))
```

Finally, I assigned these cleaned names to the variables names.
```
names(mydata)[3:dim(mydata)[2]] <- feat.mydata
```


4. Appropriately labels the data set with descriptive activity names. 
---------

First, I loaded the activities' labels to `a.labels`, and then using the function factor() gave the names to the corresponding values
```
#Activities
a.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep ="", header = FALSE) 

mydata$activity <- factor(mydata$activity, a.labels[,1], a.labels[,2])
```

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
---------

For the final task, I first built a constituency table to check basic summary stats.
```
freq.by.pairs <- table(mydata$subject,mydata$activity); freq.by.pairs
```
Then, I used the melt function from the reshape2 library to first melt the data using the variables `subject` and `activity` as pivots.
```
melt.mydata = melt(mydata, id = c("subject", "activity"))
```

Finally, I reconstructed the data frame into a new one, using the dcast() function, with the mean as function argument, as asked.
```
tidy.data <- dcast(melt.mydata, formula = subject + activity ~ variable,mean)
```
The result is a data frame that combines subject and activity, and the corresponding average value for the 66 variables.

The last instruction in R was to export the tidy data into a .CSV file in the working directory.
```
write.csv(tidy.data, "./tidyData.csv") 
```
