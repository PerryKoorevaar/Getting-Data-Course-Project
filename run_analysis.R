# This script is part of the answer for the Course Project of the Coursera
# Course "Getting and cleaning data". The script uses the plyr-package and it:
#
# 1) merges the files containg the measurments (X-files) with the Subject
# file (describing individuals) and y file (describing activities). This is
# done separately for the train and test set. The result is stored in the table
# TotaTrain and TotaTest, respectively.
#
# 2) merges the TotaTrain and TotaTest tables (row wise), into table Tota
#
# 3) inserts descriptive activity names to the data set (by  
# mapping the numbers to actual activities using the "activity_labels" file)
#
# 4) inserts descriptive variable names ("column naming") based on the 
# "features" file (and remembering that the subject column describes subjects
# and y-test column describes activities)
#
# 5) subtracts only the original measurements on the mean and SD. All columns 
# from the X files that are not original measurements are removed as well, 
# even though they might indicate a mean or SD on a processed result
# (e.g. all frequency domain variables are removed)
#
# 6) Creates a second tidy data set (named TotaTidy) with the average of each
# variable of each activity and each subject.
#
# Step 1 *****
  DataTest <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/test/X_test.txt")
  SubjTest <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/test/subject_test.txt")
  ActiTest <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/test/y_test.txt")
  TotaTest <- cbind(SubjTest, ActiTest, DataTest)
#
  DataTrain <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/train/X_train.txt")
  SubjTrain <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/train/subject_train.txt")
  ActiTrain <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/train/y_train.txt")
  TotaTrain <- cbind(SubjTrain, ActiTrain, DataTrain)
#
# Step 2 *****
  Tota <- rbind(TotaTest, TotaTrain)
#
# Step 3 *****
  Activity <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/activity_labels.txt")
  Tota[,2] <- Activity[match(Tota[,2], Activity[,1]),2]
#
# Step 4 *****
  Features <- read.table("C:/Users/Perry/Documents/UCI HAR Dataset/features.txt")
  HelpName <- as.vector(Features[,2])
  HelpName2 <- c("Subject","Activity", HelpName)
  names(Tota) <- HelpName2
#
# Step 5 *****
# In Step 5 only the columns representing the original measurements are kept,
# next to the first 2 columns describing Subjects and Activity.
# This implies that all processed resuts, from e.g. applying filters or 
# Fourier transformations, are removed from the dataset. In the original 
# dataset (the "X-files") the original measurements are located in 18 columns.
# Namely, there are three sets for "tBody", "tGravity" and "tBodyGyro". For
# each of those 3 sets, there are 3 dimensions - the X, Y and Z dimensions.
# This makes 3x3 = 9 columns. Finally, for each combination, we keep both the
# results for the Mean and Standard Deviation (SD). So the total number of
# columns to keep = 2 x 9 = 18 columns. 
# In the original "X-files" the column numbers representing the data to be 
# kept are nr's: 1-6, 41-46 and 121-126. Since we added 2 columns in front
# to form the data table "Tota", the columns to be kept from "Tota" are
# nr's 3-8, 43-48, 123-128. Also, we keep columns nr's 1 and 2 representing
# Subject and Activity.
# The actual names of the columns are already defined in the previous step,
# in the help vector "HelpName2". The column naming in this vector is 
# identical to the column naming in the table containing all the information
# i.e. data table Tota.
  NameColumnKeep <- c(HelpName2[1],HelpName2[2],
                      HelpName2[3],HelpName2[4],HelpName2[5],
                      HelpName2[6],HelpName2[7],HelpName2[8],
                      HelpName2[43],HelpName2[44],HelpName2[45],
                      HelpName2[46],HelpName2[47],HelpName2[48],
                      HelpName2[123],HelpName2[124],HelpName2[125],
                      HelpName2[126],HelpName2[127],HelpName2[128])
  Tota <- Tota[NameColumnKeep]
#
# Step 6 *****
# In Step 6 the data are averaged for every unique pair of Subject and
# Activity. This results is a "Tidy" data set, stored in "TotaTidy", where 
# for every given Subject
# and Activity, only 1 value for the 18 measurements is present in the data
# set, and this value for any given observable equals the average over all
# the measurements for this given observable.Given that we have 30 Subjects
# and 6 Activities, the resulting data set "TotaTidy" has a maximum number
# of 6x30 = 180 rows (this serves just as a sanity check but is not used in the 
# actual calculation)
# Finally, the data set TotaTidy is saved in a file TotaTidy.txt, to be 
# submitted to Coursera for review. This file can directly be read back
# into R by the read.table("TotaTidy.txt") command
  TotaTidy <- ddply(Tota, .(Subject, Activity), numcolwise(mean))
  write.table(TotaTidy, file = "TotaTidy.txt")
#
# End *****
  
  
  

  
  