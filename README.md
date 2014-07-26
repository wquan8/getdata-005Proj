getdata-005Proj
===============

course project for getdata-005

There are two R files. 

dlRawData.R
Download raw data if it does not exist and unzip the raw data
Data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R does the following. 

The implementation does not follow the exact order in the list, reference to R file for details, The content is listed below as order of requirements

1. Merges the training and the test sets to create one data set.
  * merge X, y, subect files each by rbind first to merge test with train datasets
  * merge X, y, subject with cbind
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  * grep is extract selected columns, search columns with mean() or std() in the name
  * also include subject and activilty columns
  * there are 66 columns extracted with query criteria above, plus subject and activity, 68 columns in total (downsized from original 563 columns)
  * there are 10299 rows in total, 2947 from test and 7352 from train.
3. Uses descriptive activity names to name the activities in the data set
  * activity names are loaded from activity_labels.txt and the activlity column is converted to factor
  * other column names except subject are loaded from features.txt. names are selected and set by names function
4. Appropriately labels the data set with descriptive variable names. 
  * tidy data set names are also modified to more readable. For example, mean() is converted to Mean
  * - is replaced with .
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  * this is implemented with ddply function from plyr library, 6 activity times 30 subject, total 180 rows. so the final dimension is 68 columns * 180 rows. numcolwise is the key to apply mean on all measurement columns.
