This README file supports the Course Project for Coursera's course "Getting 
and Cleaning Data", and is submitted by Perry Koorevaar.

****************************************************************************

The zipped data used for the assignment is provided by Coursera's link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is originally from:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

After unzipping the directory ./UCI HAR Dataset is created, with 2 sub-
directories "train" and "test", along with 4 descriptive files:
1) feature_labels 2) features 3) features_info and 4) Readme. These
files contain descriptions of the actual data, labelling, units and data files 
in the sub-directories "train" and "test".
The sub-directories "train" and "test" each contain one sub-directory 
with the original signals, "Inertial Signals", and 3 files:

1) the "X_*" (with * either "train" or "test") file containing the combined,
lightly pre-processed data of measurements and gravity accelerations

2) the subject_* file describing the number of the person on whom
the measurement was taken

3) the y_* file describing the Activity during the measurement

In the assignment the X, y and subject file will be combined and used,
the inertial signals are not needed as all required info is in the X-file.

****************************************************************************

The script to process the data is called run.analysis.R. It contains 6 steps: 

Step 1 is to merge the files containg the measurments (X-files) 
with the Subject file (describing individuals) and y file (describing
activities). This is done "column-wise) and separately for the train 
and test set. 

Step 2 is to merge the train and test set (row-wise). The result is one
big file with all required data in it. 

Step 3 is inserting descriptive activity names to the data set (by 
mapping the numbers to actual activities using the "activity_labels" file)

Step 4) inserts descriptive variable names ("column naming") based on the 
"features" file (and remembering that the subject column describes subjects
and y-test column describes activities)

Step 5 removes all columns that are not representing original measurements
(apart from 2 columns describing Subjects and Activity)
This implies that all processed resuts, from e.g. applying filters or Fourier transformations, are removed from the dataset. In the original 
dataset (the "X-files") the original measurements are located in 18 columns

Namely, there are three sets for "tBody", "tGravity" and "tBodyGyro". For
each of those 3 sets, there are 3 dimensions - the X, Y and Z dimensions.
This makes 3x3 = 9 columns. (Measurements are done by an accelerometer and a
gyroscope, independently for the X,Y and Z dimensions. On top, for the
accelerometer also the "gravity"" forces have to be measured and correctied
for, giving an additional3 independent measurements).
Finally, for each combination, we keep both the
results for the Mean and Standard Deviation (SD). So the total number of
columns to keep = 2 x 9 = 18 columns. (Plus 2 extra for describing
Subject and Activity)

Step 6 averages the data for every unique pair of Subject and
Activity. This results in a tidy data set, which is saved in a file 
TotaTidy.txt. This file is to be submitted to Coursera for review. It can directly be read back into R by the read.table("TotaTidy.txt") command.
 
***************************************************************************
