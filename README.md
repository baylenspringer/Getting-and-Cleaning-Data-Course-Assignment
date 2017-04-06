# Getting-and-Cleaning-Data-Course-Assignment

File:  run_analysis.R


Description:  code that designed to utilize the Samsung data "Huuman Activity Recognition Using Smartphones Dataset".  The does the following tasks
  1) merges the training and test data sets into one data set 
  2) extracts only the measurements on the mean and standard deviation for each measurement
  3) joins descriptive activity names to the variables
  4) creates a independent tidy data set with average of each variable for each activity and each subject
 
 Output:  
 1) meanAndStdData DataFrame:  result of steps 1 - 3 above
 2) AverageMeasurementData DataFrame: result of logic from step 4, the code the then exports this dataframe to a file named "AverageMeasurementData.txt" to the working directly
 
 Notes:  The AverageMeasurementData DataFrame is a tidy data set, and meets the following criteria;
 1) Each measurement variable is in one column
 2) Each different observation is in it's own row
 3) Variable names are descriptive
 
 
 Requirements:  this code will execute as long as the Samsung data is in the working directory
 
 File:  CodeBook.md
 Description:  code book and data dictionary describing the variables, the data, and transformations performed on the Samsung data
 

