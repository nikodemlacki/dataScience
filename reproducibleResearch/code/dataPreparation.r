# Clean envrionment
rm(list = ls())

# Set base working directory
# (you have to update the varaible if you check out the repository into a difeerent folder
# or are working on Mac or Linux)
setwd("G:/Work/Coursera/dataScienceRepo/reproducibleResearch")
if(!exists("calculateSumSteps", mode="function")) source("code/auciliaryFunctions.r")

# Load raw data for clean up and further processing
activityRaw <- read.csv("data/activity.csv", header = TRUE)
# Run some basic checks on the data
# Identified 2304 NAs in the column "steps" - about 13% of the data - significant
head(activityRaw)
tail(activityRaw)
str(activityRaw$date)
str(activityRaw$interval)
summary(activityRaw)
# 13% ratio of NA values
2304/17568*100

#--------------------------------
# First challenge
# Transform date column from default factor to a Date format
activityRaw$date <- as.Date(as.character(activityRaw$date), format = "%Y-%m-%d")

noOfStepsPerDay <- calculateSumSteps(activityRaw)
hist(noOfStepsPerDay, breaks = length(noOfStepsPerDay), xlab = "No. of steps per day")

mean(noOfStepsPerDay)
median(noOfStepsPerDay)
summary(noOfStepsPerDay)

#--------------------------------
# Second challenge
activityRaw$interval <- factor(activityRaw$interval)
meanNoOfStepsPerInterval <- tapply(activityRaw$steps, activityRaw$interval, mean, na.rm = TRUE)
tstDF <- data.frame(meanNoOfStepsPerInterval)
tstDF[,"interval"] <- row.names(tstDF)

plot(tstDF$interval, tstDF$meanNoOfStepsPerInterval,
     type = "l",
     xlab = "Interval",
     ylab = "No of Steps")
title("Average steps in each 5 min interval")

summary(meanNoOfStepsPerInterval)
meanNoOfStepsPerInterval[meanNoOfStepsPerInterval==max(meanNoOfStepsPerInterval)]

#--------------------------------
# Third challenge
activityFull <- activityRaw
summary(activityRaw$steps)
# Populate NA values with mean of steps for other days within the same interval
activityFull[, "meanPerInterval"] <- round(meanNoOfStepsPerInterval, digits = 0)

activityFull$steps = ifelse(is.na(activityFull$steps), activityFull$meanPerInterval, activityFull$steps)
noOfStepsPerDay <- calculateSumSteps(activityFull)
hist(noOfStepsPerDay, breaks = length(noOfStepsPerDay), xlab = "No. of steps per day")

mean(noOfStepsPerDay)
median(noOfStepsPerDay)
summary(noOfStepsPerDay)

#--------------------------------
# Fourth challenge
activityFull[, "weekdayIndicator"] <-
  ifelse(weekdays(activityFull$date) %in% c("Saturday", "Sunday"), "Weekend", "Weekday")
activityFull$weekdayIndicator <- factor(activityFull$weekdayIndicator)
activityFull[, "meanPerWeekdayIndicator"] <-
  ifelse(activityFull$weekdayIndicator == "Weekday",
         tapply(activityFull[activityFull$weekdayIndicator == "Weekday", ]$steps, activityFull[activityFull$weekdayIndicator == "Weekday", ]$interval, mean),
         tapply(activityFull[activityFull$weekdayIndicator == "Weekend", ]$steps, activityFull[activityFull$weekdayIndicator == "Weekend", ]$interval, mean))

library(lattice)
xyplot( meanPerWeekdayIndicator ~ interval | weekdayIndicator, data = activityFull,
        layout = c(1, 2), type = "l",
        xlab = "Interval", ylab = "Number of Steps")

