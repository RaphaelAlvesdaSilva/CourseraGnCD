## Importing Libraries
library(dplyr)
library(reshape2)

#### Step 1. Merges the training and the test sets to create one data set.
## Downloading the files
dataZip <- "UCI_HAR_Dataset.zip"
if (!file.exists(dataZip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, dataZip, method="curl")
}  
if (!file.exists("UCI HAR Dataset.zip")) { 
  unzip(dataZip) 
}
rm(dataZip); rm(fileURL)

## Importing the Data Files
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
sbtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
sbtest <- read.table("UCI HAR Dataset/test/subject_test.txt")

## Importing the features file
featuresFile <- read.table("UCI HAR Dataset/features.txt")

##changing the labels name
colnames(xtrain) <- featuresFile$V2
colnames(xtest) <- featuresFile$V2
rm(featuresFile)

## Merging all trains together
xtrain$activity <- unlist(ytrain)
xtrain$personId <- unlist(sbtrain)
xytrain <- xtrain
rm(xtrain); rm(ytrain); rm(sbtrain)

## Merging all tests together
xtest$activity <- unlist(ytest)
xtest$personId <- unlist(sbtest)
xytest <- xtest
rm(xtest); rm(ytest); rm(sbtest)

## Combining both datasets together by column name
combData <- rbind(xytrain,xytest)
rm(xytest); rm(xytrain)

#### Step 2.Extracts only the measurements on the mean and standard deviation for each measurement.
subCombData <- combData[,grepl("[Mm]ean|[Ss]td()|activity|personId",names(combData))]
rm(combData)

#### Step 3.Uses descriptive activity names to name the activities in the data set
## Create a list for the activities labels
actLabs <- data.frame(Activity = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                "SITTING","STANDING","LAYING"),index=c(1,2,3,4,5,6))

subCombData <- merge(actLabs, subCombData, by.x = 'index', by.y = 'activity')
subCombData <- subset( subCombData, select = -index )
rm(actLabs)

#### Step 4.Appropriately labels the data set with descriptive variable names.
## Already done on the step 2, all was labeled to support the subsetting of the means and standard
# deviations

#### Step 5.From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
averageDataSet <- subCombData
## Factoting the activies, subjects and mode (train or test)
averageDataSet$Activity <- as.factor(averageDataSet$Activity)
averageDataSet$personId <- as.factor(averageDataSet$personId)

## applying the mean in all variables, by activies and subject
averageDataSet <- melt(averageDataSet, id = c("personId", "Activity"))
averageDataSet <- dcast(averageDataSet, personId + Activity ~ variable, mean)

## Saving the file.
write.table(averageDataSet, "tidyData.txt", row.names = FALSE, quote = FALSE)
