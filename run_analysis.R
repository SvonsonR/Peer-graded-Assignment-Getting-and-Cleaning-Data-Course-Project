## Pre-Step: Create directory and download data

## Create "data" directory if it hasnt been already created
if(!file.exists("./data"))
{dir.create("./data")}

## save URL
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Download the data in the working directory and change the name
download.file(fileUrl,destfile="./data/dataset.zip")

## Unzip dataset to /data directory
unzip(zipfile="./data/dataset.zip",exdir="./data")

## Download features and activities
features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("i", "activity"))



## 1. Merge the training and the test sets to create one data set ("data")

## 1.1 Training data
## 1.1.1 Read training data
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "i")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

## 1.1.2 Merge training data
train <- cbind(subject_train, y_train, x_train)

## 1.2 Test data
## 1.2.1 Read test data
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "i")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)

## 1.2.2 Merge test data
test <- cbind(subject_test, y_test, x_test)

## 1.3 Merge training and test data.frames
data <- rbind(train, test)

## dim(data)
## [1] 10299   563



## 2. Extract only the measurements on the mean and standard deviation for each measurement

## get dyplr to use pipe 
library(dplyr)
data_meanstd <- data %>% 
                select(subject, i, contains("mean"), contains("std"))

## dim(data_meanstd)
## [1] 10299    88


## 3. Use descriptive activity names to name the activities in the data set
data_meanstd$i <- activities[data_meanstd$i, 2]

## head(data_meanstd$i)
## [1] STANDING STANDING STANDING STANDING STANDING STANDING



## 4 Appropriately label the data set with descriptive variable names
colnames(data_meanstd)[2] <- "activity"
colnames(data_meanstd) <- gsub(pattern = "Acc", replacement = "Accelerometer", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "angle", replacement = "Angle", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "BodyBody", replacement = "Body", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "gravity", replacement = "Gravity", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "Gyro", replacement = "Gyroscope", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "Mag", replacement = "Magnitude", x = colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "tBody", replacement = "TimeBody", x = colnames(data_meanstd))
## '^' Only the beginning of the string
colnames(data_meanstd) <- gsub(pattern = "^t", "Time", colnames(data_meanstd))
colnames(data_meanstd) <- gsub(pattern = "^f", "Frequency", colnames(data_meanstd))
## ignore.case	if FALSE, the pattern matching is case sensitive and if TRUE, case is ignored during matching
colnames(data_meanstd) <- gsub(pattern = "-mean()", replacement = "Mean", x = colnames(data_meanstd), ignore.case = TRUE)
colnames(data_meanstd) <- gsub(pattern = "-std()", replacement = "STD", x = colnames(data_meanstd), ignore.case = TRUE)
colnames(data_meanstd) <- gsub(pattern = "-freq()", replacement = "Frequency", x = colnames(data_meanstd), ignore.case = TRUE)

## colnames(data_meanstd)



## 5. From the data set in step 4, create a second, independent "tidy_data" set with the average 
## of each variable for each activity and each subject.
tidy_data <- data_meanstd %>%
group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
