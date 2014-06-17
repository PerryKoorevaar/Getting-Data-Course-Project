This CodeBook file supports the Course Project for Coursera's course "Getting 
and Cleaning Data", and is submitted by Perry Koorevaar. 
It explains the R script run.analysis.R.

****************************************************************************

The script contains 6 steps: 

Step 1 is to merge the files containg the measurments (X-files) 
with the Subject file (describing individuals) and y file (describing
activities). First the data is read into data.tables, e.g. for the Test set
into DataTest, SubjTest and ActiTest. These 3 data tables are column-
binded into data table TotaTest. This is also done  separately for the train 
set. 

Step 2 is to merge the train and test set (row-wise). The result is one
big table with all required data in it, called Tota.

Step 3 is inserting descriptive activity names to the data set Tota (by 
mapping the numbers to actual activities using the "activity_labels" file)

Step 4) inserts descriptive variable names ("column naming") based on the 
"features" file (and remembering that the subject column describes subjects
and y-test column describes activities). The feature file is manipulated into 
 a help-vector "HelpName", to which 2 elements (Subject and Activity) are 
 added to form vector HelpName2. This vector is used 1-on-1 to named the 
 columns of data table Tota.

Step 5 removes all columns that are not representing original measurements
(apart from 2 columns describing Subjects and Activity). First the 
column numbers to be kept are identified. Then the names of these
columns are stored in the table "NameColumnKeep".Based on this
table the file Tota can be filtered to keep only the columns of which
the name is in NameColumnKeep.


Step 6 averages the data for every unique pair of Subject and
Activity. This results in a tidy data set, which is saved in a file 
TotaTidy.txt. This file is to be submitted to Coursera for review. It can directly be read back into R by the read.table("TotaTidy.txt") command.
 
***************************************************************************

The units for the measurements are:
- for the tBodyAcc and tGravityAcc series the units are standard gravity
units "g"
- for the tBodyGyro series the unit is radians/second

***************************************************************************

For further information on the original data set see:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

***************************************************************************
