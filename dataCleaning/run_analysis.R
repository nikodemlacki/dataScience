# This script reuqires dplyr package to be installed and loaded
library(dplyr)

# Download and unzip the test and training data sets
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "ActivityRecognition.zip")
unzip("ActivityRecognition.zip")

# Change working directory to the extracted folder
setwd("UCI HAR Dataset")

# Read help files
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity_label")
feature_labels <- read.table("features.txt")
# Read training data set files
X_train <- read.table(file = "train/X_train.txt")
# Set feature column names
colnames(X_train) <- feature_labels$V2
y_train <-read.table("train/y_train.txt")
subject_train <-read.table("train/subject_train.txt")
# Add label column to the train data set
X_train$label<-y_train$V1
X_train <- merge(X_train, activity_labels, by.x = "label", by.y = "activity_id", all = TRUE)
# Add subject column to the train data set
X_train$subject<-subject_train$V1

# Read test data set files
X_test <- read.table("test/X_test.txt")
# Set feature column names
colnames(X_test) <- feature_labels$V2
y_test <- read.table("test/y_test.txt")
subject_test <-read.table("test/subject_test.txt")
# Add label column to the test data set
X_test$label<-y_test$V1
X_test <- merge(X_test, activity_labels, by.x = "label", by.y = "activity_id", all = TRUE)
# Add subject column to the test data set
X_test$subject<-subject_test$V1

# Combine test and train data into one set
train_and_test <- rbind(X_train, X_test)
# Extract data set containing only the measures of mean and standard deviation
filtered_train_and_test <- train_and_test[, grepl("mean|std|subject|activity_label", colnames(train_and_test))]

# Generate summary with means for each of the variables per activity and subject
summary <- aggregate(filtered_train_and_test, c(list(filtered_train_and_test$activity_label), list(filtered_train_and_test$subject)), FUN = mean, simplify = TRUE)
summary <- summary[, !(names(summary) %in% c("activity_label", "subject"))]
summary<-rename(summary, activity_label=Group.1, subject=Group.2)

# Write the file as per instructions
write.table(summary, "nl_summary.txt", row.names = FALSE)

