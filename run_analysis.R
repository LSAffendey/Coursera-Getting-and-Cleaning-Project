library(reshape2)
filename <- "project_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Read the activity labels and features files, select only column 2
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[, 2] <- as.character(activityLabels[, 2])
features <- read.table("UCI HAR Dataset/features.txt")
features[, 2] <- as.character(features[, 2])

# Extract only the measurements on the mean and standard deviation, replace with new labels
# selected.features <- grep(".*mean.*|.*std.*", features[, 2])
selected.features <- grep("-(mean|std)\\(\\)", features[, 2])
selected.features.names <- features[selected.features, 2]
selected.features.names = gsub('-mean', 'Mean', selected.features.names)
selected.features.names = gsub('-std', 'Std', selected.features.names)
selected.features.names <- gsub('[-()]', '', selected.features.names)

# Load the the training and test datasets. Column bind the subjects, activities with selected features from each dataset

trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")[selected.features]
train <- cbind(trainSubjects, trainActivities, train)
colnames(train) <- c("subject", "activity", selected.features.names)

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")[selected.features]
test <- cbind(testSubjects, testActivities, test)
colnames(test) <- c("subject", "activity", selected.features.names)

# merge the training and test datasets and add labels
mergeData <- rbind(train, test)

# convert activities & subjects into factors
mergeData$activity <- factor(mergeData$activity, levels = activityLabels[, 1], labels = activityLabels[, 2])
mergeData$subject <- as.factor(mergeData$subject)

# melt and then dcast the mergeData
mergeData.melted <- melt(mergeData, id = c("subject", "activity"))
mergeData.mean <- dcast(mergeData.melted, subject + activity ~ variable, mean)

# write the mean of mergeData into a txt file
write.table(mergeData.mean, "tidydata.txt", row.names = FALSE, quote = FALSE, sep="\t")
