setwd("~/classes/cleaningdata/getdata-005Proj/")
fileName <- "getdata-projectfiles-UCI HAR Dataset.zip"
if (!file.exists(fileName)) {
  print("Fetching data from source...")
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, fileName, "curl", T)
}

if (!file.exists("UCI HAR Dataset"))
{
  print("unzipping downloaded archive...")
  unzip(fileName)
}

fileTrain <- 'train/X_train.txt'
fileTest <- 'test/X_test.txt'