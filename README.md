# Coursera-Getting-and-Cleaning-Project

Introduction

This repository contains the course project for the "Getting and Cleaning data" module, part of the Data Science specialization. The project uses data collected from the accelerometers from the Samsung Galaxy S smartphone available from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data set contains training and test data with 561 features.  For this project, only the measurements on the mean and standard deviation for each measurement are to be extracted.  The main output is a tidy data set from merging the training and test data set.

About the Script

The run_analysis.R script shall download and unzipped the data set into "UCI HAR Dataset" folder, then read the activity labels and features files.  Next, the measurements on the mean and standard deviation shall be extracted.  This followed by loading the the training and test datasets. The subjects, activities with selected features from each dataset shall be column bind and descriptive labels are given.  Next the training and test datasets are merged. The subject and activity are converted into factor, and then the mean are computed.  

Lastly, the script will create a tidy data set containing the mean of each variable for each subject and each activity. This tidy dataset will be written to a file called tidydata.txt, which can also be found in this repository.

About the Code Book

The CodeBook.md file describes the variables and summaries used in the script.
