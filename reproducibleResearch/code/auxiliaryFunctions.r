# Set of function to summarize number of steps per day and calculate mean and median.
# Functions assume the dataset parameter will have column called "steps" and that this column will be of type
# integer. It also assumes that the dataset data frame has column called "date" that will be used
# to calculate mean number of steps per day.
# The function returns vector of values containing mean number of steps per day
calculateSumSteps <- function(dataset) {
  resultVector <- tapply(X = dataset$steps, INDEX = dataset$date, FUN = sum, na.rm = TRUE)
  resultVector
}
