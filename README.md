# Introduction
This is the project work for the course of Getting And Cleaning Data Project. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set by coding a R program. The program will prepare tidy data, process data analysis, and export the result to a text file.

About the data source, it is applied and download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
That is the data sets collected from accelerometers and gyroscope from the Samsung Galaxy S smartphone for develop the most advanced algorithms of wearable computing products.

These data sets contains 10299 observation (2947 + 7352 = 10299) from test and train data set, with 561 features, 6 activates, 30 volunteers / subjects, and 128 element vectors.

Being this project mainly focus on the data tidy skill, therefore the output just pick 15 variables for the analysis, although all data was read and tidy.


# Input - data sets and variables
* Features - the type of measurement for collect signal, total 561 features
* Activity - six of human activities (Walking, Walking_Upstairs, Waking_Downstairs, Sitting, Standing, Laying)
* Subject - the identify of who (30 volunteers) performed the activities
* X - the measurement result data set of the activities
* y - the identify of activities for the measurement result
* Inertial signals - the 3-dimensional signal related to gravity / acceleration of different vectors. (This part of data was ignored as the project required is related to the measurement value, not the raw signal)
 

# Working
* Merges the training and the test sets to create one data set "mergedDataSet"
* Extracts only the measurements on the mean and standard deviation for each measurement, and store the selection to vector "selCol"
* tidy "mergedDataSet", remove those column which excluded from "selCol"
* Rename the data set column name for easy reading / indentifying
* Select 15 variables from the tidy data set and store in a new independent tidy data set 'variableSet' for the analysis. Calculate the average of each variable for each activity and each subject. Finally, export the result to a text file.

# Selected measurements / variables for the analysis
* activityName - the activity name
* subjectID - the identify of who performed the activities
* tBodyAcc_Mean_X - the mean of the X-axial acceleration signal that was separated into body 
* tBodyAcc_Mean_Y - the mean of the Y-axial acceleration signal that was separated into body 
* tBodyAcc_Mean_Z - the mean of the Z-axial acceleration signal that was separated into body 
* tBodyAcc_std_X - the standard deviation of the X-axial acceleration signal that was separated into body 
* tBodyAcc_std_Y - the standard deviation of the X-axial acceleration signal that was separated into body 
* tBodyAcc_std_Z - the standard deviation of the X-axial acceleration signal that was separated into body 
* tGravityAcc_mean_X - the mean of the X-axial acceleration signal that was separated into gravity
* tGravityAcc_mean_Y - the mean of the Y-axial acceleration signal that was separated into gravity
* tGravityAcc_mean_Z - the mean of the Z-axial acceleration signal that was separated into gravity
* tGravityAcc_std_X - the standard deviation of the X-axial acceleration signal that was separated into gravity 
* tGravityAcc_std_Y - the standard deviation of the Y-axial acceleration signal that was separated into gravity
* tGravityAcc_std_Z - the standard deviation of the Z-axial acceleration signal that was separated into gravity 

# Ouput - variables and export the result to a text file
[Ouput variables]
* activityName - the activity name
* subjectID - the identify of who performed the activities
* avg_tBodyAcc_Mean_X - the average of the mean of the X-axial acceleration signal that was separated into body 
* avg_tBodyAcc_Mean_Y - the average of the mean of the Y-axial acceleration signal that was separated into body 
* avg_tBodyAcc_Mean_Z - the average of the mean of the Z-axial acceleration signal that was separated into body 
* avg_tBodyAcc_std_X - the average of the standard deviation of the X-axial acceleration signal that was separated into body 
* avg_tBodyAcc_std_Y - the average of the standard deviation of the X-axial acceleration signal that was separated into body 
* avg_tBodyAcc_std_Z - the average of the standard deviation of the X-axial acceleration signal that was separated into body 
* avg_tGravityAcc_mean_X - the average of the mean of the X-axial acceleration signal that was separated into gravity
* avg_tGravityAcc_mean_Y - the average of the mean of the Y-axial acceleration signal that was separated into gravity
* avg_tGravityAcc_mean_Z - the average of the mean of the Z-axial acceleration signal that was separated into gravity
* avg_tGravityAcc_std_X - the average of the standard deviation of the X-axial acceleration signal that was separated into gravity 
* avg_tGravityAcc_std_Y - the average of the standard deviation of the Y-axial acceleration signal that was separated into gravity
* avg_tGravityAcc_std_Z - the average of the standard deviation of the Z-axial acceleration signal that was separated into gravity 

[Text file]
* File name: run_analysis_result.txt
* File location: ~/UCI HAR Dataset
* This txt file is created with write.table() using row.name=FALSE  
