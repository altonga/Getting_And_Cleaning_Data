# Course project for Getting and Cleaning Data
# Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# This script does:

# 1. Merge the training and the test sets to create one data set.

trainX <- read.table("train/X_train.txt")
testX <- read.table("test/X_test.txt")
X <- rbind(trainX, testX)

trainsubject <- read.table("train/subject_train.txt")
testsubject <- read.table("test/subject_test.txt")
subject <- rbind(trainsubject, testsubject)

trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")
y <- rbind(trainy, testy)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("features.txt")
required_features_indices <- grep("-mean\\(\\)|-std\\(\\)", features[,2])
print(required_features_indices)
X <- X[,required_features_indices]
names(X) <- features[required_features_indices, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))
print(names(X))

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
y[,1] = activities[y[,1], 2]
names(y) <- "activity"


# 4. Appropriately labels the data set with descriptive variable names. 
names(subject) <- "subject"
cleaned <- cbind(subject, y, X)
write.table(cleaned, "merged_clean_data.txt") #, row.name=FALSE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
unique_subjects <- unique(subject)[,1]
print(uniqueSubjects)
num_of_subjects <- length(unique(subject)[,1])
num_of_activities <- length(activities[,1])
num_of_cols <- dim(cleaned)[2]
result <- cleaned[1:(num_of_subjects * num_of_activities), ]

row_num  = 1
for (s in 1:num_of_subjects) {
    for (a in 1:num_of_activities) {
        
        result[row_num, 1] = unique_subjects[s]
        result[row_num, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject == s & cleaned$activity == activities[a, 2], ]
        result[row_num, 3:num_of_cols] <- colMeans(tmp[ , 3:num_of_cols])
        row_num <- row_num + 1
        
    }
}

write.table(result, "data_with_averages_per_subject_activity.txt", row.name=FALSE)
