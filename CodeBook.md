# CodeBook 

## Variable names

The variables in the dataset have been cleaned up as per the tidy data principles. The first part of the variable name represents the statistical measure, for example 'entropyFBODYACCforX' gives the entropy in small case. The next upper case letter 'T' or ' F' represents the time or frequency characteristic of the measurement. The next upper case letter represents the sensor in the form of the accelerometer. The final part of the variable name is represented for the direction, as in X, Y , Z or numeric values denoting range. 'for' and 'to' have been used to make the variables easier to read.

## Data

*Please note, below text paragraph has been modified in order to include the new tidy variable names*

The time domain signals were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TBODYACCforXYZ and TGRAVITYACCforXYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TBODYACCJERKforXYZ and TBODYGYROJERKforXYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TBODYACCMAG, TGRAVITYACCMAG, TBODYACCJERKMAG, TBODYGYROMAG, TBODYGYROJERKMAG). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FBODYACCforXYZ, FBODYACCJERKforXYZ, FBODYGYROforXYZ, FBODYACCJERKMAG, FBODYGYROMAG, FBODYGYROJERKMAG. (Note the starting 'F' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* TBODYACCforXYZ
* TGRAVITYACCforXYZ
* TBODYACCJERKforXYZ
* TBODYGYROforXYZ
* TBODYGYROJERKforXYZ
* TBODYACCMAG
* TGRAVITYACCMAG
* TBODYACCJERKMAG
* TBODYGYROMAG
* TBODYGYROJERKMAG
* FBODYACCforXYZ
* FBODYACCJERKforXYZ
* FBODYGYROforXYZ
* FBODYACCMAG
* FBODYACCJERKMAG
* FBODYGYROMAG
* FBODYGYROJERKMAG

The set of variables that were estimated from these signals are: 

* mean: Mean value
* std: Standard deviation
* mad: Median absolute deviation 
* max: Largest value in array
* min: Smallest value in array
* sma: Signal magnitude area
* energy: Energy measure. Sum of the squares divided by the number of values. 
* iqr: Interquartile range 
* entropy: Signal entropy
* arCoeff: Autorregresion coefficients with Burg order equal to 4
* correlation: correlation coefficient between two signals
* maxInds: index of the frequency component with largest magnitude
* meanFreq: Weighted average of the frequency components to obtain a mean frequency
* skewness: skewness of the frequency domain signal 
* kurtosis: kurtosis of the frequency domain signal 
* bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle: Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle variable:

* GRAVITYMean
* TBODYACCMEAN
* TBODYACCJERKMEAN
* TBODYGYROMEAN
* TBODYGYROJERKMEAN

# Transformations

The following steps were followed for making the transformations

1. Import the data for the subject_train.txt, subject_test.txt, X_train.txt, y_train.txt, features.txt, X_test.txt, y_test.txt, activity_labels.txt.

2. Use gsub to first identify the 3 parts of the variable names separated by '-'. Assign these parts to groups. Rearrange the groups to make the variable easier to understand and also make the sensor word uppercase.

3. Use a secind  gsub statment to clean up the 'angle(' variable names.

4. Eliminate all special cases where there are only 2 parts in the variable name.

5. Eliminate any existing '.'.

6. Use rbind to merge the training and testing datasets. Name it 'complete_set'.

7. Assign the new column names to the merged dataset.

8. Merge the subject-id and label columns to this 'complete_set'.

9. Join the 'complete_set' to the 'activity_label' set inorder to get the descriptive lables.

10. Use grep to get a list of all the column names having 'mean' or 'std' as part of the string.

11. Select these columns and re-assign them to 'complete_set'

12. Using dplyr package, group by in the subject-id and activityLabel columns. Using summarise_each we can get the means for all the columns in the dataset.

13. Use data.table to export the tidy data as a space delimited file.
