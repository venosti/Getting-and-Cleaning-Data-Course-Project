# Getting-and-Cleaning-Data-Course-Project
Gettting and Celaning Data Project to prepare tidy data, based on Human Activity Recognition Using Smartphones Dataset 

This project shows how to collect, work with, and clean a data set. It is about the exciting areas of wearable computing.

The data linked below represent data collected from the accelerometers from the Samsung Galaxy S smartphone
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

A full description is available at the site where the data was obtained
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>


---
### Files included in this Repository
* README.md -- this file
* CodeBook.md -- codebook describes the variables, the data, and transformations performed to clean up the data
* run_analysis.R -- actual R code

---
### run_analysis.R goals
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. From the data in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

It should run in a folder of the Samsung data (the zip had this folder: UCI HAR Dataset)
The script assumes it has in the working directory the following files and folders:

* activity_labels.txt
* features.txt
* test/
* train/

The output is created in the working directory with the name tidydata.txt

---
### run_analysis.R walkthrough
It follows the goals step by step:

* Step 1:
  * Read all the training and test files: y_train.txt, subject_train.txt, X_train.txt, and y_test.txt, subject_test.txt, X_test.txt 
  * Combine the files to a data frame in the form of subjects, activities and features.

* Step 2:
  * Read the features from features.txt and filter it to only leave features that are either means ("mean()") or standard deviations ("std()"). The reason for leaving out meanFreq() is that the goal for this step is to only include means and standard deviations of measurements, of which meanFreq() is neither.
  * A new data frame is then created that includes subjects, activities and the described features.

* Step 3:
  * Read the activity labels from activity_labels.txt and replace the numbers with the names.

* Step 4:
  * Labels the data set with descriptive variable names
  * Suffixes and abbreaviations are replaced with extended names to make the features better readable
   
* Step 5:
  * Create a new data frame by finding the mean for each combination of subject and activity. 
  
* Final step:
  * Write the new tidy set into a text file called tidydat.txt, for downstream analysis.

*Note:* the R script is built to run without including any library.


---
### Running the script
To run the script, you just have to download the script and source the script from your working directory in R. 
`source(run_analysis.R)`

---
### Details of *CodeBook.md*
The code book file describes the variables, the data, and any transformations and work performed to clean up the data.


---
### Details of tidy Dataset file *tidydata.txt*
This is the tidy data file created after after running `run_analysis.R` script on the original data downloaded from this [URL](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 


#### The tidy dataset contains:  
- `180` observations and `68` columns(`2` columns for `activity` and `subject` and `66` columns for measurement variables)
- Each measurement variable column is average value for each combination of `subject` and `activity`

---



