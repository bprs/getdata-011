# Getting and Cleaning Data (Feb 2015) - course project
## Code Book

The original data that the analysis started from was downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

It contained two datasets, a train and a test set.
The features of each set were spread across multiple files. For example, for the train set, they are:
 - Inertial Signals/total_acc_x_train.txt: Acceleration in the x axis from the accelerometer (total acceleration)
 - Inertial Signals/total_acc_y_train.txt: Acceleration in the y axis from the accelerometer (total acceleration)
 - Inertial Signals/total_acc_z_train.txt: Acceleration in the z axis from the accelerometer (total acceleration)
 - Inertial Signals/body_acc_x_train.txt:  Estimated body acceleration in the x axis
 - Inertial Signals/body_acc_y_train.txt:  Estimated body acceleration in the y axis
 - Inertial Signals/body_acc_z_train.txt:  Estimated body acceleration in the z axis
 - Inertial Signals/body_gyro_x_train.txt: Angular velocity in the x axis from the gyroscope
 - Inertial Signals/body_gyro_y_train.txt: Angular velocity in the y axis from the gyroscope
 - Inertial Signals/body_gyro_z_train.txt: Angular velocity in the z axis from the gyroscope
 - X_train.txt: A 561-feature vector with time and frequency domain variables
 - y_train.txt: Activity labels
 - subject_train.txt: Identifiers of the subjects who carried out the experiment
Analogous files were present for the test set.

For each set independently, each file was loaded into a data frame and the multiple
resulting data frames were concatenated (via cbind, each data frame thus providing one or more
columns across all rows).
The column name of the y_train dataframe was changed to "activity", and the column name of the
subject_train dataframe was changed to "subject".
An additional column was added named "type" that contained the string "train" in every row of the train set
and "test" in every row of the test set.

Finally, the two resulting concatenated data frames (one for train and one for test) were 
concatenated in turn (via rbind, each data frame thus providing all columns across part of the rows)
to generate a total data frame.

The names of the features in X_train were extracted from the "features.txt" file.
Features that contained the strings "mean" or "std" were selected and only the columns corresponding to those features 
were retained in the total data frame, along with the "activity", "subject" and "type" columns to produce a filtered
data frame. The description of the features retained from X_train can be found at the end of this file (copied from features_info.txt)

To replace the content of the "activity" column (currently containing numbers from 1 to 6) with activity labels,
those labels were read into a labels dataframe from the "activity_labels.txt" file. The name of the first column
of this dataframe was changed to "activity" and that of the second column was changed to "activityExplicit".
Then, the labels dataframe and the filtered dataframe were merged by the "activity" column.
In the resulting merged dataframe, the content of the activity column was replaced with the
content of the activityExplicit column and the latter was removed.

The resulting data frame is the first tidy dataset.

To obtain the second tidy dataset form the first tidy dataset,
the rows of the first set with identical values for both the activity and subject column
were averaged across rows for every column (via the ddply function).
The resulting data frame (means + activity and subject values) was returned as the second
tidy dataset


### Description of X_train features (copied from features_info.txt)

Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
