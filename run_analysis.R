library(dplyr)

# Create data directory if needed
if(!file.exists('data')) {
  dir.create('data')
}

# Download data and record date
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'data/har_data.zip', mode = 'wb')

downloadDate <- date()

# Create a list of files to unzip
root <- 'UCI HAR Dataset'
files <- c("train/subject_train.txt", "train/X_train.txt", "train/y_train.txt", "test/subject_test.txt", "test/X_test.txt", "test/y_test.txt", "features.txt", "activity_labels.txt")
files <- paste(root, files, sep = "/")

# Unzip all needed files
unzip('data/har_data.zip', junkpaths = TRUE, files = files, exdir = 'data')

# Load feature names and select names that include mean() or std()
feature_names <- read.table('data/features.txt')
filtered_features <- c(grep('mean()', feature_names$V2, fixed = TRUE), grep('std()', feature_names$V2, fixed = TRUE))

# Load and combine X_test and X_train.  Add feature names and save only filtered features
features <- rbind(read.table('data/X_test.txt'), read.table('data/X_train.txt'))
colnames(features) <- feature_names$V2
features <- features[,filtered_features]

# Load subjects
subjects <- rbind(read.table('data/subject_test.txt'), read.table('data/subject_train.txt'))
colnames(subjects) <- 'subject'

# Load activity labels
activity_labels <- read.table('data/activity_labels.txt')
colnames(activity_labels) <- c('activity_id', 'activity')

# Load and combine y_test and y_train and join the activity ids with the activity labels
activities <- rbind(read.table('data/y_test.txt'), read.table('data/y_train.txt'))
colnames(activities) <- 'activity_id'
activities <- inner_join(activities,activity_labels, by='activity_id')

# Combine the activies, subjects, and features
rawdata <- cbind(activity = activities$activity, subjects, features)

# For each feature, calculate the mean for each subject and activity
output <- aggregate(. ~ activity + subject, data = rawdata, FUN = mean)

# Write out the table of summarized features
write.csv(output, file = 'tidy_data.txt')
