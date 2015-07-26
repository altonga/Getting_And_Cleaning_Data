
# Code Book for Course Project

The original source for data is: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original description of the data is at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The run_analysis.R script performs the following actions to clean up the data:

* Merges the training and test data sets to create one data set. train/X\_train.txt and test/X\_test.txt are merged to form X which has 10299 rows and 561 columns. train/subject\_train.txt and test/subject\_test.txt are merged to form subject which has 10299 rows and 1 column. train/y\_train.txt and test/y\_test.txt are merged to form y which has 10299 rows and 1 column.

* Extracts all features from features.txt into features. required\_features\_indices stores the indices of features that have mean() or std() in their name. X stores only the features at required\_features\_indices. Names of columns are cleaned up to remove brackets  and converted to all lower case. There are 66 such features.

* Descriptive names are applied using 2nd column in applied_labels.txt. All activity names are converted to lowercase and underscores are removed to get following activities:
    + walking
    + walkingupstairs
    + walkingdownstairs
    + sitting
    + standing
    + laying

* Cleaned data is created using subject, y, and X and stored in cleaned

* The script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as data_with_averages_per_subject_activity.txt. This has subject in 1st column, activity in 2nd column, and average of 66 features in columns 3 to 68. There are 30 subjects and 6 activities. So it has 180 rows corresponding to every activity for every subject.