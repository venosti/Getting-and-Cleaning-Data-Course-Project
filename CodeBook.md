CodeBook
===================

Course Project for Gettting and Cleaning Data based on Human Activity Recognition Using Smartphones Dataset  

This CodeBook that describes the variables, the data, and any transformations or work that was performed to clean up  
the source data to create a tidy dataset as per requirements of course project.

---
### Information about Source Data Experment
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.  
Each person performed six activities `(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)` wearing   
a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial   
linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.   
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned   
into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.   


---
### Original Data Source
Human Activity Recognition Using Smartphones Dataset.    
Data for analysis is downloaded from [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)



---
### Structure of Data present in source data folders

- `README.txt`: General description of the project.
- `features_info.txt`: Shows information about the variables used on the feature vector.
- `features.txt`: List of all features.i.e list of all measurement variables
- `activity_labels.txt`: Lists the activity Id with their corresponding activity name.
- `train/X_train.txt`: Training set.
- `train/y_train.txt`: Training activity Id Labels
- `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test activity Id Labels
- `test/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


The following files are available for the train and test data. Their descriptions are equivalent. 

- `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in   standard gravity units `g`. Every row shows a 128 element vector. The same description applies for the   
`total_acc_x_train.txt` and `total_acc_z_train.txt` files for the Y and Z axis. 
- `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from   
the total acceleration. 
- `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window   sample. The units are radians/second.

**Note:** All the files in `train/Inertial Signals` and `test/Inertial Signals` will not be used for in this analysis

---
### Details about Files to be used in analysis from Source Data

**Common Files**

- `features.txt`: 561 rows of 2 varibles (feature Identifier and feature Name)
- `activity_labels.txt`: 6 rows of 2 variables (activity identifier and activity name)

**Test Dataset**

- `X_test.txt`: 2947 rows of 561 measurement variables. These are measurement variables listed in features.txt 
- `y_test.txt`: 2947 rows of 1 variables. This is the activity Identifier
- `subject_test.txt`: 2497 rows of 1 variable (subject Identifier)

**Training Dataset**

- `X_train.txt`: 7352 rows of 561 measurement variables. These are measurement variables listed in features.txt 
- `y_train.txt`: 7352 rows of 1 variables. This is the activity Identifier
- `subject_train.txt`: 7352 rows of 1 variable (subject Identifier)



---
### Requirements & Details of Transformations through `run_analysis.R` script
#### Requirements
`run_analysis.R` script has the following requirements to perform transformation on UCI HAR Dataset.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### Detailed Functions of `run_analysis.R` Script
- Downloads the dataset from the URL mentioned above and unzips it to create UCI HAR Dataset folder
- Imports "test" and "train" datsets and creates data frames from then and then Merges the training and the test sets  
to create one data frame.
- Extracts a subset of data with only the measurements on the mean "mean()" and standard deviation "std()" for each  measurement. Also excludes meanFreq()-X measurements or angle measurements where the term mean exists resulting in  
66 measurement variables.
- Appropriately labels the data set with descriptive activity names in place of activity Ids
- Updates the variable names in dataframe variable names for data fame to improve readibility
- Reshapes dataset to create a data frame with average of each measurement variable for each activity and each subject
- Writes new tidy data frame to a text file to create the required tidy data set file of 180 observations and 68 columns 
(2 columns for activityName and subjectID and 66 columns for measurement variables) 

---
## Transformations performed on the original dataset. 


### Merging the training and the test sets to create one data set.

#### Activities:
- Download the dataset from the [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) mentioned above and unzip it to create UCI HAR Dataset folder.  
- Script imports `test` and `train` datsets and creates data frames from then and then merges the training and the test sets to create one data frame.


All files to be used as listed above are imported to created data frames and column variables names are updated as follows:

data frame | source file 
--- | ---
`dataActivityTrain`    | `"y_train.txt"`          
`dataSubjectTrain`     | `"subject_train.txt"` 
`dataFeaturesTrain`    | `"X_train.txt"`    
`dataActivityTest`     | `"y_test.txt"`                
`dataSubjectTest`      | `"subject_test.txt"`                 
`dataFeaturesTest`     | `"X_test.txt"`    
`dataFeaturesNames`    | `"features.txt"`  


data frame concatenated by rows | resulting data frame
--- | ---
`dataSubjectTrain`, `dataSubjectTest`  | `dataSubject`          
`dataActivityTrain`, `dataActivityTest`| `dataActivity` 
`dataFeaturesTrain`, `dataFeaturesTest`| `dataFeatures`
                 

data frame | variable names 
--- | ---
`dataSubject`  | `"subject"`
`dataActivity` | `"activity"`
`dataFeatures` | `"dataFeaturesNames$V2"` 


#### Merge Activities
`dataFeatures`, `dataSubject`, `dataActivity` have been binded by `cbind`  function to create final aggregated dataset/data frame `Data` with `10299` rows and `563` columns

Below code shows few details of `Data`
```
> head(Data[1:5])
  tBodyAcc-mean()-X tBodyAcc-mean()-Y tBodyAcc-mean()-Z tBodyAcc-std()-X tBodyAcc-std()-Y
1         0.2885845       -0.02029417        -0.1329051       -0.9952786       -0.9831106
2         0.2784188       -0.01641057        -0.1235202       -0.9982453       -0.9753002
3         0.2796531       -0.01946716        -0.1134617       -0.9953796       -0.9671870
4         0.2791739       -0.02620065        -0.1232826       -0.9960915       -0.9834027
5         0.2766288       -0.01656965        -0.1153619       -0.9981386       -0.9808173
6         0.2771988       -0.01009785        -0.1051373       -0.9973350       -0.9904868
> 




> dim(Data)
[1] 10299   563
```

---
### Extraction of only the measurements on the mean and standard deviation for each measurement.

#### Activities:
- Extract a subset of data with only the measurements on the *mean* `mean()` and *standard deviation* `std()` for  
each measurement 

#### Extraction of selected measurement values
- `grep` functions are used to search for occurance of *mean* `mean()` and *standard deviation* `std()` in `Data`   
variable Names using escape characters.  
- Using escape characters to search exactly for `mean()` and `std()` occurance helps to exclude `meanFreq()-X` measurements  
and/or angle measurements where the term `mean` exists  
- In order to extract a subset of only measurements on the *mean* `mean()` and *standard deviation* `std()` `grep` is used  
to create index of matched column numbers. 
- The resulting selection would have only `66` measurement variables.

Below code shows search using `grep` functions in column names of `Data` data frame.
```
> dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
 [1] tBodyAcc-mean()-X           tBodyAcc-mean()-Y           tBodyAcc-mean()-Z          
 [4] tBodyAcc-std()-X            tBodyAcc-std()-Y            tBodyAcc-std()-Z           
 [7] tGravityAcc-mean()-X        tGravityAcc-mean()-Y        tGravityAcc-mean()-Z       
[10] tGravityAcc-std()-X         tGravityAcc-std()-Y         tGravityAcc-std()-Z        
[13] tBodyAccJerk-mean()-X       tBodyAccJerk-mean()-Y       tBodyAccJerk-mean()-Z      
[16] tBodyAccJerk-std()-X        tBodyAccJerk-std()-Y        tBodyAccJerk-std()-Z       
[19] tBodyGyro-mean()-X          tBodyGyro-mean()-Y          tBodyGyro-mean()-Z         
[22] tBodyGyro-std()-X           tBodyGyro-std()-Y           tBodyGyro-std()-Z          
[25] tBodyGyroJerk-mean()-X      tBodyGyroJerk-mean()-Y      tBodyGyroJerk-mean()-Z     
[28] tBodyGyroJerk-std()-X       tBodyGyroJerk-std()-Y       tBodyGyroJerk-std()-Z      
[31] tBodyAccMag-mean()          tBodyAccMag-std()           tGravityAccMag-mean()      
[34] tGravityAccMag-std()        tBodyAccJerkMag-mean()      tBodyAccJerkMag-std()      
[37] tBodyGyroMag-mean()         tBodyGyroMag-std()          tBodyGyroJerkMag-mean()    
[40] tBodyGyroJerkMag-std()      fBodyAcc-mean()-X           fBodyAcc-mean()-Y          
[43] fBodyAcc-mean()-Z           fBodyAcc-std()-X            fBodyAcc-std()-Y           
[46] fBodyAcc-std()-Z            fBodyAccJerk-mean()-X       fBodyAccJerk-mean()-Y      
[49] fBodyAccJerk-mean()-Z       fBodyAccJerk-std()-X        fBodyAccJerk-std()-Y       
[52] fBodyAccJerk-std()-Z        fBodyGyro-mean()-X          fBodyGyro-mean()-Y         
[55] fBodyGyro-mean()-Z          fBodyGyro-std()-X           fBodyGyro-std()-Y          
[58] fBodyGyro-std()-Z           fBodyAccMag-mean()          fBodyAccMag-std()          
[61] fBodyBodyAccJerkMag-mean()  fBodyBodyAccJerkMag-std()   fBodyBodyGyroMag-mean()    
[64] fBodyBodyGyroMag-std()      fBodyBodyGyroJerkMag-mean() fBodyBodyGyroJerkMag-std() 
> 
```

- Based on this selection and adding the columns `subject` and `activity` we obtain the subset of Data, named `mean_std_Data`  

This stage crates a data frame `mean_std_Data` of `10299` observations and `68` variables

---
### Clean up variable names to in the data set

#### Activities:
- Update the variable names in dataframe to improve readibility


#### Variable Transformation activities
- Read the activity labels from activity_labels.txt and replace the numbers with the names
Follows the result for the first 30 activity observations

```
> head(mean_std_Data$activity, 30)
 [1] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
[11] STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING STANDING
[21] STANDING STANDING STANDING STANDING STANDING STANDING STANDING SITTING  SITTING  SITTING 
Levels: LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
> 
```

- by `gsub` function suffixes and abbreaviations are replaced with extended names to make the features better readable

intitial  | replaced by 
--- | ---
`prefix "t"`  | `time`
`prefix "f"`  | `frequency`
`Acc`         | `Accelerometer` 
`Gyro`        | `Gyroscope` 
`Mag`         | `Magnitude` 
`BodyBody`    | `Body` 


Below code shows the changes in variable names after cleaning up variable names.
> names(mean_std_Data)
 [1] "timeBodyAccelerometer-mean()-X"                
 [2] "timeBodyAccelerometer-mean()-Y"                
 [3] "timeBodyAccelerometer-mean()-Z"                
 [4] "timeBodyAccelerometer-std()-X"                 
 [5] "timeBodyAccelerometer-std()-Y"                 
 [6] "timeBodyAccelerometer-std()-Z"                 
 [7] "timeGravityAccelerometer-mean()-X"             
 [8] "timeGravityAccelerometer-mean()-Y"             
 [9] "timeGravityAccelerometer-mean()-Z"             
[10] "timeGravityAccelerometer-std()-X"              
[11] "timeGravityAccelerometer-std()-Y"              
[12] "timeGravityAccelerometer-std()-Z"              
[13] "timeBodyAccelerometerJerk-mean()-X"            
[14] "timeBodyAccelerometerJerk-mean()-Y"            
[15] "timeBodyAccelerometerJerk-mean()-Z"            
[16] "timeBodyAccelerometerJerk-std()-X"             
[17] "timeBodyAccelerometerJerk-std()-Y"             
[18] "timeBodyAccelerometerJerk-std()-Z"             
[19] "timeBodyGyroscope-mean()-X"                    
[20] "timeBodyGyroscope-mean()-Y"                    
[21] "timeBodyGyroscope-mean()-Z"                    
[22] "timeBodyGyroscope-std()-X"                     
[23] "timeBodyGyroscope-std()-Y"                     
[24] "timeBodyGyroscope-std()-Z"                     
[25] "timeBodyGyroscopeJerk-mean()-X"                
[26] "timeBodyGyroscopeJerk-mean()-Y"                
[27] "timeBodyGyroscopeJerk-mean()-Z"                
[28] "timeBodyGyroscopeJerk-std()-X"                 
[29] "timeBodyGyroscopeJerk-std()-Y"                 
[30] "timeBodyGyroscopeJerk-std()-Z"                 
[31] "timeBodyAccelerometerMagnitude-mean()"         
[32] "timeBodyAccelerometerMagnitude-std()"          
[33] "timeGravityAccelerometerMagnitude-mean()"      
[34] "timeGravityAccelerometerMagnitude-std()"       
[35] "timeBodyAccelerometerJerkMagnitude-mean()"     
[36] "timeBodyAccelerometerJerkMagnitude-std()"      
[37] "timeBodyGyroscopeMagnitude-mean()"             
[38] "timeBodyGyroscopeMagnitude-std()"              
[39] "timeBodyGyroscopeJerkMagnitude-mean()"         
[40] "timeBodyGyroscopeJerkMagnitude-std()"          
[41] "frequencyBodyAccelerometer-mean()-X"           
[42] "frequencyBodyAccelerometer-mean()-Y"           
[43] "frequencyBodyAccelerometer-mean()-Z"           
[44] "frequencyBodyAccelerometer-std()-X"            
[45] "frequencyBodyAccelerometer-std()-Y"            
[46] "frequencyBodyAccelerometer-std()-Z"            
[47] "frequencyBodyAccelerometerJerk-mean()-X"       
[48] "frequencyBodyAccelerometerJerk-mean()-Y"       
[49] "frequencyBodyAccelerometerJerk-mean()-Z"       
[50] "frequencyBodyAccelerometerJerk-std()-X"        
[51] "frequencyBodyAccelerometerJerk-std()-Y"        
[52] "frequencyBodyAccelerometerJerk-std()-Z"        
[53] "frequencyBodyGyroscope-mean()-X"               
[54] "frequencyBodyGyroscope-mean()-Y"               
[55] "frequencyBodyGyroscope-mean()-Z"               
[56] "frequencyBodyGyroscope-std()-X"                
[57] "frequencyBodyGyroscope-std()-Y"                
[58] "frequencyBodyGyroscope-std()-Z"                
[59] "frequencyBodyAccelerometerMagnitude-mean()"    
[60] "frequencyBodyAccelerometerMagnitude-std()"     
[61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
[62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
[63] "frequencyBodyGyroscopeMagnitude-mean()"        
[64] "frequencyBodyGyroscopeMagnitude-std()"         
[65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
[66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
[67] "subject"                                       
[68] "activity"


> dim(mean_std_Data)
[1] 10299    68

```

#### Final Dataset `finalData`
- This data frame has `10299` observations and `68` columns. 
- `2` columns for  `"activity"` and `"subject" and 66 comumns for measurement variables with measurements  
on the `mean()` and `std()`




---
### Tidy Data Set with the average of each variable for each activity and each subject

#### Activities:
- Reshape dataset to create a data frame with average of each measurement variable for each activity and each subject
- Writes new tidy data frame to a text file to create the required tidy data

#### Transformation Details
- using the function `aggregate()` whit the grouping argument `subject + activity` a new data frame named `mean_std_Data2`, compliant with the request, is obtained 
- finally, the data frame is ordered based on subject and activity variables

#### 
The below code shows data transformation done by using `aggregate` and `order` functions to create final data frame
```
> mean_std_Data2 <- aggregate(. ~subject + activity, mean_std_Data, mean)
> mean_std_Data2 <- mean_std_Data2[order(mean_std_Data2$subject, mean_std_Data2$activity),]


> head(mean_std_Data2[1:7])
    subject           activity timeBodyAccelerometer-mean()-X timeBodyAccelerometer-mean()-Y
1         1             LAYING                      0.2215982                   -0.040513953
31        1            SITTING                      0.2612376                   -0.001308288
61        1           STANDING                      0.2789176                   -0.016137590
91        1            WALKING                      0.2773308                   -0.017383819
121       1 WALKING_DOWNSTAIRS                      0.2891883                   -0.009918505
151       1   WALKING_UPSTAIRS                      0.2554617                   -0.023953149
    timeBodyAccelerometer-mean()-Z timeBodyAccelerometer-std()-X timeBodyAccelerometer-std()-Y
1                       -0.1132036                   -0.92805647                  -0.836827406
31                      -0.1045442                   -0.97722901                  -0.922618642
61                      -0.1106018                   -0.99575990                  -0.973190056
91                      -0.1111481                   -0.28374026                   0.114461337
121                     -0.1075662                    0.03003534                  -0.031935943
151                     -0.0973020                   -0.35470803                  -0.002320265
> 
```

#### Tidy data frame
- This data frame has `180` observations/rows and `68` columns/variables
- `68` columns(`2` columns for `activity` and `subject` and `66` columns for measurement variables) 
- Each measurement variable columns `[3 to 68]` is average value for each combination of `subjectId` and `activityName`


#### Tidy Data File
- The `mean_std_Data2` data frame is written to a file using `write.table` to create `tidydata.txt` file
- By default column names are kept in file. Row Names have to be explicity excluded using `row.names=FALSE` argument  
in `write.table` function
