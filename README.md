# Getting and Cleaning Data (Feb 2015) - course project

The repository contains the following files:
 - getData.R -> the script that fetches the zip file with the original data
 - run_analysis.R -> the script which, when sourced in the same directory with the original data (in the form of the 'getdata-projectfiles-UCI HAR Dataset.zip' file) generates the tidy data (in the form of the 'dat.means.txt' file)

To generate the tidy data, please:
 1. source getData.R or download the original data manually in the 'getdata-projectfiles-UCI HAR Dataset.zip' file
 2. in the same directory with the previous zip, source the run_analysis.R script
 3. the dat.means.txt file containing the tidy data should now be in the same directory as the zip file
 
