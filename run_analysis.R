##-------------------------------------------------------------------------------------
## Getting and Cleaning Data Course Project
##-------------------------------------------------------------------------------------

##setwd("~/Personal/Coursera/Getting and Cleaning Data/Assignment")
library(dplyr)

##-------------------------------------------------------------------------------------
## Import files
##-------------------------------------------------------------------------------------
##main diretory files

    ## Features
    ## List of all features
    ## dimensions: 2 cols, 561 rows
    ## columns: Feature# ,  FeatureName

    features <- read.table("features.txt")
    
    ## set featureNames for x_test and x_train columns
    featureNames <- features[,2]
    
    ## activityLabels
    ## List of activity names
    ## dimensions: 2 cols, 6 rows
    ## columns:  activity#, activityName

    activityLabels <- read.table("activity_labels.txt")
    names(activityLabels)<- c("ID", "activityName")
    
##Test files
    ## xTest
    ## test data
    ## dimensions:  561 cols, 2947 rows
    ## cols: see features table
    ##xTest <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/test/X_test.txt")
    xTest <- read.table("./test/X_test.txt")
    
    ## subjectTest
    ## subject Number who performed the activity fo each window sample, range from 1 - 30
    ## dimensions:  1 col, 2947 rows
    ## columns: subject Number
    ##subjectTest <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/test/subject_test.txt")
    subjectTest <- read.table("./test/subject_test.txt")
    
    ## yTest
    ## Test labels
    ## dimensions: 1 col, 2947 rows
    ## columns:  labelID
    ##yTest <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/test/y_test.txt")
    yTest <- read.table("./test/y_test.txt")
    
    
##Train files
    ## xTrain
    ## training data
    ## dimensions:  561 cols, 7352 rows
    ## cols: see features table
    ##xTrain <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/train/X_train.txt")
    xTrain <- read.table("./train/X_train.txt")
    
    ## subjectTrain
    ## training subjects
    ## dimensions:  1 cols, 7352 rows
    ## cols: subject Ids
    ##subjectTrain <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/train/subject_train.txt")
    subjectTrain <- read.table("./train/subject_train.txt")
    
    ## yTrain
    ## training label ids
    ## dimensions:  1 cols, 7352 rows
    ## cols: activity ids
    ## yTrain <- read.table("C:/Users/bspringer/Documents/Personal/Coursera/Getting and Cleaning Data/Assignment/train/y_train.txt")
    yTrain <- read.table("./train/y_train.txt")


##-------------------------------------------------------------------------------------
## Testing data manipulation
##-------------------------------------------------------------------------------------

    ## combine subjectTest, yTest and xTest dataframes together & name columns
    ## create new variable to signify subjectTypes and define all as "test"
    
    subjectType <- rep("test", nrow(yTest))
    testMerge <- cbind(subjectTest, yTest, subjectType)
    names(testMerge)<- c("subject", "activitylabelID", "subjectType")
    
    names(xTest) <- featureNames
    testMerge <- cbind(testMerge, xTest)
    
    
##-------------------------------------------------------------------------------------
## Training data manipulation
##-------------------------------------------------------------------------------------
   
    
    ## combine subjectTrain, yTrain and xTrain dataframes together & name columns
    ## create new variable to signify subjectTypes and define all as "train"
    subjectType2 <- rep("train", nrow(yTrain))
    trainMerge <- cbind(subjectTrain, yTrain, subjectType2)
    names(trainMerge)<- c("subject", "activitylabelID", "subjectType")
    
    names(xTrain) <- featureNames
    trainMerge <- cbind(trainMerge, xTrain)

    
##-------------------------------------------------------------------------------------
## 
##  Merge Test and Training data into one table
##      combine data sets
##      add activity names
##-------------------------------------------------------------------------------------
    totalData <- rbind(testMerge, trainMerge)
    
    ## add activity names to data set
    totalDataActNames <- merge(totalData, activityLabels, by.x = "activitylabelID", by.y = "ID", all.x =TRUE)
    
    ## define which columns to select
    TDNames <- colnames(totalDataActNames)
    
    selectColNames <- (grepl("subject", TDNames) | 
                       grepl("subjectType" , TDNames) |
                       grepl('activitylabelID',TDNames) |
                       grepl('activityName', TDNames) |      
                       grepl("\\bmean\\b()" , TDNames) | 
                       grepl("\\bstd\\b()" , TDNames) 
                       )
    ## select only subject info and mean/std columns
    meanAndStdData <- totalDataActNames[ , selectColNames == TRUE]
    
##-------------------------------------------------------------------------------------
## create average of each variable for each activty and each subject
##-------------------------------------------------------------------------------------    

## select releveant columns
summData <- select(meanAndStdData, -activitylabelID, -subjectType)   
   
## group and summarize    
AverageMeasurementData <- summData %>%
                          group_by(activityName, subject) %>%
                          summarize_each(funs(mean))
        
write.table(AverageMeasurementData,file = "AverageMeasurementData.txt", row.names = FALSE )
