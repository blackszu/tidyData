##Code book for run_analysis.R and the output dataset "tidyData"

This is a course assignment for Getting and Cleaning Data, Data Science Specialization by Johns Hopkins University via Coursera

==================================================================

###Assignment Goals:

Create one R script called run_analysis.R that does the following

1.	Merges the training and the test sets to create one data set.

2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
	
3.	Uses descriptive activity names to name the activities in the data set

4.	Appropriately labels the data set with descriptive variable names. 

5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Raw data: Samgsung dataset

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2 files provide the information of the raw data:

	(a) README.txt

	(b) features_info.txt

8 files are used for the purpose of this assignment:

	Labels:

	(1) activity_labels.txt

	(2) features.txt

	Train data:

	(3) X_train.txt

	(4) y_train.txt

	(5) subject_train.txt

	Test data:

	(6) X_test.txt

	(7) y_test.txt

	(8) subject_test.txt

18 files are NOT used for the purpose of this assignment: 9 files in subfolder "test/Inertial Signals" and 9 files in subfolder "train/Inertial Signals



###Processed Data 

	Train dataset and text data set are merged into one data set "allData" with column 1: subject number(raw data(5)&(8)), column 2: activity label number(raw data(4)&(7)), and column 3-563: measurements(raw data(3)&(6)).
	
	Raw data(1) activity_labels.txt provides the activity label names for column2.

	Raw data(2) features.txt provides the varialbe names(column headers) for column 3-563 with 2 modifications:

		Names of feature 516-554(column 518-556) are corrected to remove the excessive "Body" from characters. eg)original: fBodyBodyGyroJerkMag, fixed: fBodyGyroJerkMa

		All "()" are removed from the variable name

	Only "subject", "activity", and 86 variables on the mean and standard deviation(std) for each measurement are selected for data set "allData2". See "Feature Selection" below.

	Then "tidyData" data set is generated that includes “subject”, “activity”, and the average of each variable(from allData2) for each activity and each subject.




###Script Output:

	(1) Data set “tidyData”

	(2) Text file "tidyData.txt"



###Feature Selection(Variables) for data set "tidyData"

The features selected for this tidyData include variables on the mean and standard deviation(std) for each measurement.

There are 86 “mean” and “std” variables selected from the raw data(2) features.txt, including 7 variables obtained by averaging the signals in a signal window sample (ex. angle(tBodyAccMean,gravity), angle(X,gravityMean)).


Column 1 : subject

	Subject number

	Total subjects: 30

	Train data subjects: 1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30

	Test data subjects: 2,3,9,10,12,13,18,20,24

	Source: raw data(5) "subject_train.txt", raw data(8) "subject_test.txt"


Column 2 : activity

	Total activity labels: 6
	
	1.	WALKING

	2.	WALKING_UPSTAIRS
	
	3.	WALKING_DOWNSTAIRS
	
	4.	SITTING
	
	5.	STANDING
	
	6.	LAYING
	
	Source: raw data(1) "activity_labels.txt".

Column 3-88: mean and standard deviation measurements
	
	mean: Mean value
	
	std: Standard deviation
	
	See raw data(b) features_info.txt for detailed information:
	
	" The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
	
	Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

	Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

	These signals were used to estimate variables of the feature vector for each pattern:  
	'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

	tBodyAcc-XYZ

	tGravityAcc-XYZ
	
	tBodyAccJerk-XYZ
	
	tBodyGyro-XYZ
	
	tBodyGyroJerk-XYZ
	
	tBodyAccMag
	
	tGravityAccMag
	
	tBodyAccJerkMag
	
	tBodyGyroMag
	
	tBodyGyroJerkMag
	
	fBodyAcc-XYZ
	
	fBodyAccJerk-XYZ
	
	fBodyGyro-XYZ
	
	fBodyAccMag
	
	fBodyAccJerkMag
	
	fBodyGyroMag
	
	fBodyGyroJerkMag 
	
	Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
	
	gravityMean
	
	tBodyAccMean
	
	tBodyAccJerkMean
	
	tBodyGyroMean
	
	tBodyGyroJerkMean "

	
