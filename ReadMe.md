#Overview
The included file run_analysis.R creates a tidy dataset from the Human Activity Recognition Using Smartphones Dataset available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The original dataset included and mean and standard deviation of the sensor signals (accelerometer and gyroscope). The new dataset provides a summary of this data by creating a dataset of the mean of each of these values for each subject and activity. 

#Process
The run_analysis.R downloads the original data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extracts the relevant files. 

The features are created by combining the rows from the X_test.txt and X_train.txt files, which the variable names from features.txt. Only the features that end in "mean()" and "std()" are retained.

The subject for each observation are created by combining the rows from the subject_test.txt and subject_train.txt files.

Finally the activities are created by combining the rows from the y_test.txt and y_train.txt files. The activity ID number is replaced by the activity label based on the information in activity_labels.txt.

The final dataset is created by combining the activities, subjects, and features and taking the mean of each features for each activity and each subject.

#Code Book
Each row of the dataset represents the mean of each feature for a single activity and subject.

##activity
One of the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

##subject
The subject who performed the activity with a range from 1 to 30. 

##remaining columns
Mean of each feature as defined in the original dataset.  Only the mean() and std() of the signals were included.

