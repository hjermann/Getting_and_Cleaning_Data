Current project contains one R script file:
run_analysis.R
The script is meant to gather source data and transform it into tidy dataset. Result of that script generates two datasets in comma separated files:

1. tidy.csv
2. TidyAggregatedBySourceAndActivity.csv

The script expect all source files to be available in "./data" subfolder. Into same folder also final results are saved.

run_analysis.R workflow
------------------------
At first script load needed library(dplyr). This library is needed for further data manipulation. Second command cleans workspace from existing variables. 
Next step sets working folder into “./data” subfolder. And searching current working directory for *.txt files and loads them into R with same variable names. Same time giving also feedback to user, what file is currently in process.
Following command searching “features” variable and filtering out only commands with “mean()” and “std()” strings in names and assigning according index and existing command names to “id” and “nms” variables.
From line 18 to 36 are block of code, what is replacing step-by-step existing variable names more readable format. 
Now following train and test data merging. At first data binding by rows for subject (variable “s”), X_train and X_test files (variable “X”) and Y_test and Y_train data (variable “y”). In case of X data binding script also filters out all unnecessary columns from dataset and keeping only data about means and standard deviation values.
Line 43 assigning human readable names for variable “X”. After that following subject merge to “X” data and renaming subject variable name true the chain and “dplyr” rename function.
Next command find for activity according descriptions from “activity_labels” variable.
Line 48 binds activity info with existing “X” dataset and assigning with proper variable name. With that activity the first part of assignment is done. Variable “tidy” is now containing last modified dataset.
Line 49 command aggregates existing tidy dataset by subject and activity and using mean function to calculate mean value for every variable in that table.
Lines 51 and 52 are exporting existing datasets to file system as CSV files. After that script sets working directory back to original location and notifying user about work finish.
