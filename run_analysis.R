

# Download the zipfile and put it in the directoty "data" 
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setInternet2(use=TRUE)
download.file(fileUrl,destfile="./data/Dataset.zip", method="internal")

# Unzip the file "Dataset.zip" and get the list of the unzipped files 
unzip(zipfile="./data/Dataset.zip",exdir="./data")
path_ref <- file.path("./data" , "UCI HAR Dataset")


## STEP 1 - Merge the training and the test sets to create one data set

# Read training data
dataActivityTrain <- read.table(file.path(path_ref, "train", "y_train.txt"),header = FALSE)
dataSubjectTrain <- read.table(file.path(path_ref, "train", "subject_train.txt"),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_ref, "train", "X_train.txt"),header = FALSE)

# Read test data
dataActivityTest  <- read.table(file.path(path_ref, "test" , "y_test.txt" ),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_ref, "test" , "subject_test.txt"),header = FALSE)
dataFeaturesTest  <- read.table(file.path(path_ref, "test" , "X_test.txt" ),header = FALSE)

# concatenate the data tables (by rows)
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

# set names of columns
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_ref, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# merge columns to get the data frame for all data
Data <- cbind(dataFeatures, dataSubject, dataActivity)


## STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement

# subset Name of Features extracting  the column indices that have either mean or std in them
subdataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

# subset the data frame Data by seleted names of Features
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
mean_std_Data <- subset(Data,select=selectedNames)


## STEP 3 - Uses descriptive activity names to name the activities in the data set

# read activity names from "activity_labels.txt"
activityLabels <- read.table(file.path(path_ref, "activity_labels.txt"),header = FALSE)

# replace in mean_std_Data activity number with activity name
mean_std_Data$activity <- as.character(mean_std_Data$activity)
mean_std_Data$activity <- activityLabels[mean_std_Data$activity, 2]



## STEP 4 - Appropriately labels the data set with descriptive variable names

# prefix t is replaced by time
# prefix f is replaced by frequency
# Acc is replaced by Accelerometer
# Gyro is replaced by Gyroscope
# Mag is replaced by Magnitude
# BodyBody is replaced by Body

names(mean_std_Data)<-gsub("^t", "time", names(mean_std_Data))
names(mean_std_Data)<-gsub("^f", "frequency", names(mean_std_Data))
names(mean_std_Data)<-gsub("Acc", "Accelerometer", names(mean_std_Data))
names(mean_std_Data)<-gsub("Gyro", "Gyroscope", names(mean_std_Data))
names(mean_std_Data)<-gsub("Mag", "Magnitude", names(mean_std_Data))
names(mean_std_Data)<-gsub("BodyBody", "Body", names(mean_std_Data))


## STEP 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# create mean_std_Data2 as a data set with average for each activity and subject
mean_std_Data2<-aggregate(. ~subject + activity, mean_std_Data, mean)

# order the entries in mean_std_Data2 
mean_std_Data2 <- mean_std_Data2[order(mean_std_Data2$subject, mean_std_Data2$activity),]


## FINAL STEP 

# write the tidy data set into "tidydata.txt" that contains the processed data
write.table(mean_std_Data2, file = "tidydata.txt",row.name=FALSE)



