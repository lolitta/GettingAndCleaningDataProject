## This R file is to prepare tidy data for the sumsung data analysis.
## The default directory of this R script is the sumsung data folder path 
## on your working directory. (Assumption: The program executor download and 
## extract the data file in the R studio's working directory.)
## i.e. ~/UCI HAR Dataset
## Data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


## Change working directory
setwd("~/UCI HAR Dataset")

## load the necessary library
library(dplyr)
library(tidyr)


#### Merges the training and the test sets to create one data set "mergedDataSet"

#[a] Read FEATURE (Type) names info, assign new variable name for the data frame
features = read.table("features.txt")
names(features) <- c("featureID", "featureName")

#[b] Read ACTIVITY TYPE info, assign new variable name for the data frame
activity <- read.table("activity_labels.txt")
names(activity) <- c("activityID", "activityName")

#[c] Read SUBJECT / VOLUNTEER's signal info and put them to tempoary data frames
# , assign a variable name 
# , add signal ID column
# , and merge SUBJECT's signal info into a data frame
# (Note: the signal ID is same as the row number)
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")
names(subject_test) <- "subjectID"
names(subject_train) <- "subjectID"
subject_test$signalID <- 1:nrow(subject_test)
subject_train$signalID <- (nrow(subject_test)+1) : (nrow(subject_test)+nrow(subject_train))
subject <- merge(subject_test, subject_train, all = TRUE, sort=FALSE)
rm("subject_test")
rm("subject_train")


#[d] Read ACTIVITY's signal info and put them to temporary data frames
# , assign a variable name 
# , add signal ID column
# , add activityName column by [b]
# , and merge ACTIVITY's signal info into a data frame
# (Note: the signal ID is same as the row number)
y_test <- read.table("test/y_test.txt")
y_train <- read.table("train/y_train.txt")
names(y_test) <- "activityID"
names(y_train) <- "activityID"
y_test$signalID <- 1:nrow(y_test)
y_train$signalID <- (nrow(y_test)+1) : (nrow(y_test)+nrow(y_train))
y <- merge(y_test[c(2,1)], y_train[c(2,1)], all=TRUE, sort=FALSE)
y <- merge(activity, y, by="activityID")
rm("y_test")
rm("y_train")


#[e] Read FEATURE's signal info and put them to temporary data frames
# , assign a variable name (set the feature name as the column name)
# , add signal ID column (Note: the signal ID is same as the row number)
# , add dataSource column (the value is either test or train, the sub-folder name of the original data source)
# ,and merge FEATURE's signal info into a new data frame
X_test <- read.table("test/X_test.txt")
X_train <- read.table("train/X_train.txt")
names(X_test) <- features[,2]
names(X_train) <- features[,2]
X_test$signalID <- 1:nrow(X_test)
X_train$signalID <- (nrow(X_test)+1) : (nrow(X_test)+nrow(X_train))
X_test$dataSource <- "test"
X_train$dataSource <- "train"
X <- merge(X_test[c(562, 1:561, 563)], X_train[c(562, 1:561, 563)], all=TRUE, sort=FALSE)
rm("X_test")
rm("X_train")

#[f] Select those necessary columns from [e] by matching the key words of the column name
# that included the data key signalID and those column related to 
# measurements on the mean and standard deviation. 
selCol  <- grep("signalID|dataSource|mean()|std()", colnames(X), ignore.case=FALSE)

#[g] Create new data set "mergedDataSet"
mergedDataSet <- select(X, selCol) 

#[h] Add acitivtyName to data set "mergedDataSet" 
mergedDataSet <- merge(mergedDataSet, y[2:3], by="signalID")

#[i] Add subject to data set "mergedDataSet"
mergedDataSet <- merge(mergedDataSet, subject, by="signalID")

#[j] Reorder the data set column for easy reading
#  (Note: before re-ordering, 
#   column 1 is signalID,
#   column 2 - 80 are the feature/measurement results 
#   Column 81 - 83 (the last 3 columns) are dataSource, activityName, subjectID
#  After re-ordering, the sequence of column will change to
#  signalID, dataSource, activityName, subjectID, and then following with feature results)
numOfMeasurement <- (ncol(mergedDataSet) - 3 + 1)
mergedDataSet <- select(mergedDataSet
                        , 1
                        , numOfMeasurement: ncol(mergedDataSet)
                        , 2:numOfMeasurement)




#### Select 15 varibles from tidy data set [j] for analysis with assign meaningable names.
#### The target result will show the average of each variable for each activity and each subject.
#### Besides, it will export the result to text file "run_analysis_result.txt" in the working directory

#[k] Select 15 varaibles to separate data set
variableSet<- select(mergedDataSet, 3:16)

#[l] Rename the varibles for easy to programming
names(variableSet) <- c("activityName","subjectID"
               ,"tBodyAcc_Mean_X", "tBodyAcc_Mean_Y", "tBodyAcc_Mean_Z" 
               ,"tBodyAcc_std_X", "tBodyAcc_std_Y", "tBodyAcc_std_Z"
               ,"tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z"
               ,"tGravityAcc_std_X", "tGravityAcc_std_Y", "tGravityAcc_std_Z")

#[m] Calculate the average value of each selected varaible
analysis_result <- variableSet %>%
    select(activityName
           , subjectID
           , tBodyAcc_Mean_X, tBodyAcc_Mean_Y, tBodyAcc_Mean_Z
           , tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z
           , tGravityAcc_mean_X, tGravityAcc_mean_Y, tGravityAcc_mean_Z
           , tGravityAcc_std_X, tGravityAcc_std_Y, tGravityAcc_std_Z
    ) %>%
    group_by(activityName, subjectID) %>%
    summarise(
        count=n()            
        , avg_tBodyAcc_Mean_X = sum(tBodyAcc_Mean_X)/n()
        , avg_tBodyAcc_Mean_Y = sum(tBodyAcc_Mean_Y)/n()
        , avg_tBodyAcc_Mean_Z = sum(tBodyAcc_Mean_Z)/n()
        , avg_tBodyAcc_std_X = sum(tBodyAcc_std_X)/n()
        , avg_tBodyAcc_std_Y = sum(tBodyAcc_std_Y)/n()
        , avg_tBodyAcc_std_Z = sum(tBodyAcc_std_Z)/n()
        , avg_tGravityAcc_mean_X = sum(tGravityAcc_mean_X)/n()
        , avg_tGravityAcc_mean_Y = sum(tGravityAcc_mean_Y)/n()
        , avg_tGravityAcc_mean_Z = sum(tGravityAcc_mean_Z)/n()
        , avg_tGravityAcc_std_X = sum(tGravityAcc_std_X)/n()
        , avg_tGravityAcc_std_Y = sum(tGravityAcc_std_Y)/n()
        , avg_tGravityAcc_std_Z = sum(tGravityAcc_std_Z)/n()              
    )

#[n] Write the result to run_analysis_result.txt and store in the working directory.
write.table(analysis_result, file="run_analysis_result.txt", row.names=FALSE)


