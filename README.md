##Samsung Dataset Cleaning and Processing

Coursera Assignment - Getting and Cleaning Data

==================================================================


###Goals:

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

18 files are NOT used for the purpose of this assignment: 9 files in subfolder "test/Inertial Signals" and 9 files in subfolder "train/Inertial Signals".



###Script:

Save the Samgsung data set in the R working directory “./”

** R packages required for this script:

	library(dplyr)

	library(reshape2)

	library(tidyr)


Data Processing:

1.	Read raw data(1)-(8) from R working directory “./”.

2.	Produce data frame “allData” (10299 obs. of 563 variables) that combines train data set and test data set using cbind and rbind functions.

		column 1: subject number(raw data(5)&(8))
		
		column 2: activity label number(raw data(4)&(7))

		column 3-563: measurements(raw data(3)&(6))

	Variable names(column headers) are “subject”, “activity”, and 561 measurements from raw data(2) features.txt with 2 modifications:

		Names of feature 516-554(column 518-556) are corrected to remove the excessive "Body" from characters. ex)original: fBodyBodyGyroJerkMag, fixed: fBodyGyroJerkMag.

		All "()" are removed from the variable names.

	Raw data(1) activity_labels.txt provides the activity label names for column2.

	* "allData" fulfills Assignment Goal 1, 3, and 4.

3.	From “allData”, produce data frame “allData2” (10299 obs. of 88 variables) that contains only "subject", "activity", and variables on the mean and standard deviation(std) for each measurement. 

	There are 86 “mean” and “std” variables, including 7 variables obtained by averaging the signals in a signal window sample (ex. angle(tBodyAccMean,gravity), angle(X,gravityMean)). 

	“allData2” data frame is generated with “select” function from package “dplyr”.

	* "allData2" fulfills Assignment Goal 2.

4.	From “allData2”, produce data frame “tidyData”(180 obs. of 88 variables).

	"tidyData" data set is a “wide” form of tidy data that includes “subject”, “activity”, and the average of each variable(from allData2) for each activity and each subject. 
	
	The assignment grading rubric states that either a wide or a long form tidy data set is acceptable. Based on personal experience working with lab data, I opt to produce a wide form tidy data that is usually more suitable for my analysis needs. 

	discussion link: https://class.coursera.org/getdata-009/forum/thread?thread_id=192

	tidyData is generated with “melt”, “group_by”, “summarize”, "ungroup", “spread” functions from packages ”dplyr”, “reshape2”, and “tidyr”.

	* "tidyData" fulfills Assignment Goal 5.


###Script Output:

(1) Data set tidyData
(2) Text file tidyData.txt

The script includes generating “tidyData.txt” using “write.table” function. “tidyData.txt” is saved in the R working directory ”./”.

To open tidyData.txt with MS Excel, use delimiter=”space”.

Please see to “CODEBOOK.md” for details of each variables.
