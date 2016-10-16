==================================================================
COURSERA - GETTING AND CLEANING DATA FINAL PROJECT - README
==================================================================
Raphael Alves da Silva
==================================================================



Ir order to complete the final project, I had to create a R script name run_analysis.R, it is composed of several steps:
* Loads the libraries that are going to be used in the script;
* Download and unzip the file who have the data I will work on;
* Import all the files regarding train and test data (x_test.txt; y_test.txt; x_train.txt; y_train.txt and subject_test.txt for train and test);
* Import the features file with the variables names;
* Change all the variables names;
* Merge the 3 train data;
* Merge the 3 test data;
* Merge train and test data in one data frame;
* Selection and keeping only the columns I wanted for further analysis, all columns with mean or std values;
* Labeling the Activities accordingly;
* Creating a new data frame for the almost tidy data;
* Selecting Activity and personId (subject) as factors;
* Apllying the mean for all the variables according to PersonId (Subject) and Activity;
* Creating a file called "tidyData.txt" with the table of the tidy data requested.