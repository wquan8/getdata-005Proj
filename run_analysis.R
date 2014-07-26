setwd("~/classes/cleaningdata/getdata-005Proj")

##load column names
colNameFile <- "UCI HAR Dataset/features.txt"
#read as factor by default, as.is to T to read as raw string, 
rawColNames = read.table(colNameFile, as.is=T)
#load activities 
facAct <- read.table("UCI HAR Dataset/activity_labels.txt", as.is=T)

## load test data
xTestFile <- "UCI HAR Dataset/test/X_test.txt"
yTestFile <- "UCI HAR Dataset/test/y_test.txt"
subTestFile <- "UCI HAR Dataset/test/subject_test.txt"

dataX <- read.table(xTestFile)
dataY <- read.table(yTestFile)
dataSub <- read.table(subTestFile)

names(dataSub) <- c("subject")
names(dataY) <- c("activity")
#2nd column is for table names
names(dataX) = rawColNames[,2]

## load train data
xTrainFile <- "UCI HAR Dataset/train/X_train.txt"
yTrainFile <- "UCI HAR Dataset/train/y_train.txt"
subTrainFile <- "UCI HAR Dataset/train/subject_train.txt"

dataXT <- read.table(xTrainFile)
dataYT <- read.table(yTrainFile)
dataSubT <- read.table(subTrainFile)

names(dataSubT) <- c("subject")
names(dataYT) <- c("activity")
#2nd column is for table names
names(dataXT) = rawColNames[,2]

#cbind to bind columns and rbind to bind rows
datX <- rbind(dataX,dataXT)
datY <- rbind(dataY,dataYT)
datSub <- rbind(dataSub, dataSubT)

allData <- cbind(datX,datY,datSub)

#set factor on activities
# To do it for all names
#fac_col_names <- c("activity")
# do do it for some names in a vector named 'col_names'
#allData[,fac_col_names] <- lapply(allData[,fac_col_names] , factor)

##subset columns
meanColNames <- grep("mean(", names(allData), value=TRUE, fixed=TRUE)
stdColNames <- grep("std(", names(allData), value=TRUE, fixed=TRUE)
selectedColNames <- c(meanColNames, stdColNames, "activity", "subject")
trimData <- allData[selectedColNames]

##rename columns, remove () and "-"
vname <- names(trimData)
vname <- gsub("mean\\(\\)", "Mean", vname, perl=TRUE)
vname <- gsub("std\\(\\)", "Std", vname, perl=TRUE)
vname <- gsub("-", ".", vname, perl=TRUE)
names(trimData) <- vname

#set facotr, turn activity column to vectors
trimData$activity <- factor(trimData$activity, levels=facAct$V1, labels=facAct$V2)

#write data into file
write.table(trimData, "tidydata.txt", sep="\t")

library(plyr)
#load plyr to calc average
#ddply(trimData,.(activity,subject),summarise,mean=mean(tBodyAcc.Mean.X),sd=sd(tBodyAcc.Mean.X))
dataAvgByActivityAndSub <- ddply(trimData,.(activity,subject),numcolwise(mean, na.rm = TRUE))

#write result to 2nd file
write.table(dataAvgByActivityAndSub, "tidydataAvgByActivityAndSub.txt", sep="\t")

