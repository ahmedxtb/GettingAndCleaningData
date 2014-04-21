## Necessary packages

library(stats)

## Functions definitions

clean_data <- function(test, train) {
    ## Reads the test and train data sets
    ## Merges the two data sets into one named merged.data
    ## Uses descriptive activity names to name the activities in merged.data
    ## Labels merged.data with descriptive activity names
    ## Extracts the measurements on the mean and standard deviation for each measurement, the result is extracted.data
    
    ## Returns a data frame which is the result of the previous steps
    
    merged.data <- rbind(test, train)
    features <- read.table("UCI HAR Dataset/features.txt")
    features.name <- c("Subject", "Activity_Id", "Activity", as.character(features$V2))
    names(merged.data) <- features.name
    activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
    merged.data$Subject <- factor(merged.data$Subject)
    merged.data$Activity_Id <- factor(merged.data$Activity_Id)
    merged.data$Activity <- factor(merged.data$Activity)
    levels(merged.data$Activity) <- sub("_", " ", activity.labels$V2)
    extracted.data <- subset(merged.data, select = c("Subject", "Activity_Id", "Activity", grep("mean\\(\\)|std\\(\\)", names(merged.data)[4:length(names(merged.data))], value = TRUE)))
    extracted.data
}

tidy_data <- function(clean) {
    ## Reads the raw data set obtained in the previous step
    ## Aggregates the raw data set to compute the averages of each variable for each activity and each subject
    
    ## Returns a data frame which contains the averages of each variable for each activity and each subject
    
    agreg.data <- aggregate(clean[, 4:ncol(clean)], by = list(clean[, 1], clean[, 3]), FUN = mean)
    names(agreg.data)[1:2] <- c("Subject", "Activity")
    agreg.data <- agreg.data[order(agreg.data$Subject), ]
    row.names(agreg.data) <- NULL
    agreg.data
}

## First step : column binding of the data contained in X_test.txt, subject_test.txt and y_test.txt to create test.data.bind

test.data <- read.table("UCI HAR Dataset/test/X_test.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test.activity.id <- read.table("UCI HAR Dataset/test/y_test.txt")
test.data.bind <- cbind(test.subject, test.activity.id, test.activity.id, test.data)

## Second step : column binding of the data contained in X_train.txt, subject_train.txt and y_train.txt to create train.data.bind

train.data <- read.table("UCI HAR Dataset/train/X_train.txt")
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train.activity.id <- read.table("UCI HAR Dataset/train/y_train.txt")
train.data.bind <- cbind(train.subject, train.activity.id, train.activity.id, train.data)

## Third step : application of the clean_data() function to test.data.bind and train.data.bind to obtain clean.data

clean.data <- clean_data(test.data.bind, train.data.bind)

## Fourth step : application of the tidy_data() function to clean.data to obtain the tidy data set and writes the
## resulting data frame in a file dataset-tidy.csv

tidy.data <- tidy_data(clean.data)
write.csv(tidy.data, file = "dataset-tidy.csv", row.names = FALSE)

