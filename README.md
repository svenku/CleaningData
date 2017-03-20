The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

Introduction

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Accroding to the course requirements I created R script run_analysis.R that does the following:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Assigns descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From this data creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script assumes that the data above is downloaded and unzipped to /data/ subfolder (relative to working directory). The script will create requested tidy data file tidydata.txt in working directory.
