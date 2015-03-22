## run_analysis. R Read Me
The run_analysis script:
1. reads-in the data available from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Combines the train and test data.
2. Assigns the original variable names each measurement.
3. Assigns the participant ID to each measurement.
4. Assigns the activity (e.g., walking, standing, etc.) to each measurement.
5. A subset of the measurements are selected:
* All mean accelerometer and gyroscopic time-series data for each X, Y, and Z coordinate.
* All standard deviation accelerometer and gyroscopic time-series data for each X, Y, and Z coordinate.
6. The mean for each participant and activity is taken for each variable.
7. This data frame is written out as 'tidy_data.txt' to the current working directory.
 