Coursera Getting and Cleaning Data Project
===========

## Contents

In this GitHub repository you'll find :

* This "README.md" file describing the contents of the "run_analysis.R" script and the code book "CodeBook.md".
* A commented R script file named "run_analysis.R" that actually performs the analysis.
* A code book file named "CodeBook.md" describing the variables and the data.

## R analysis script

The "run_analysis.R" script when run performs the required analysis (provided the "UCI HAR Dataset" directory is in the working directory). It needs the "stats" package to be loaded to work fine. This script will return a csv file named "dataset-tidy.txt" which is the independant tidy data set required for the project.

This script performs the analysis in four steps :

1. It begins by reading the three test files ("test/X_test.txt", "test/subject_test.txt" and "test/y_test.txt"). It then performs a column bind of these three data frames which results in a new data frame ("test.data.bind") with 2947 rows ans 564 columns which are subject id, activity id (two times) and the other columns provided by the "X_test.txt" file.

2. Same as step 1 applied on the three train files ("train/X_train.txt", "train/subject_train.txt" and "train/y_train.txt"). The result is a data frame named "train.data.bind" with 7352 rows and 564 columns which are subject id, activity id (two times) and the other columns provided in the "X_train.txt" file.

3. It then merges the two data sets by using the rbind() function into one big data frame called "merged.data". Then it reads the names of the variables in the file "features.txt" and names the last columns of "merged.data" accordingly (the first three columns are labelled "Subject", "Activity_Id" and "Activity"). It then reads the file "activity_labels.txt" to label the "Activity" column with descriptive activity names (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING and LAYING). Next, the script coerces the columns "Subject", "Activity_Id" and "Activity" into factors with respectively 30 and 6 levels two times. Finally, the script extracts the measurements on the mean and standard deviation for each measurement, for the purposes of this analysis mean and standard deviation were construed as the variables ending by "mean()" and "std()"; this is done by using the grep() function with the regular expression "mean\\\(\\\)|std\\\(\\\)". The result of this procedure is a data frame named "clean.data" with 10299 rows and 69 columns ("Subject", "Activity_Id", "Activity", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()") the first three columns are factors and the others are numeric.

4. The scripts now proceeds to create an independant data set with the average of each variable for each activity and each subject by using the aggregate() function on "clean.data" and sorts it by subject and activity. It then proceeds to tidy up the names of the variables by removing the "()" and replacing the double "Body" by a single one when relevant. The result is a data frame called "tidy.data" with 180 rows and 68 columns, the columns are the same as "clean.data" minus "Activity_Id" which is not necessary as "Activity" is clearer, the rows contains the average value of each variable for each subject and each activity. Finally, the script writes "tidy.data" to a csv file named "dataset-tidy.txt".

## Code book file

The file "CodeBook.md" describes the format of the data originally provided for this project and the tidy data obtained after performing the "run_analysis.R" script on this data (type of the variables and the possible values for them).
