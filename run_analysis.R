run_analysis <- function(){

## Getting and Cleaning Data Course Assignment
# 03/21/2015

# load packages:
library("reshape2")
library("dplyr")

#Load relevant data:

# test data
test_dat <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE, sep = "") # data from test subjects
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE, sep = "") # Activity codes for test subjects
subj_test_id <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE, sep = "") # training subject IDs, index rows of training data

# train data
train_dat <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE, sep = "") # data from training subjects
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE, sep = "") # Activity codes for training subjects
subj_train_id <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE, sep = "") # training subject IDs, index rows of training data

# feature variables:
features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE, sep = "")

# combine data sets
dat <- rbind(test_dat,train_dat)

# set original variable names from features
names(dat) <- tolower(as.character(features[,2]))

# select only raw, time-varying mean and std acceleration and gyroscopic data for x/y/z coordinates:  
col_idxs <- which(grepl("tbodyacc-mean()|tbodyacc-std()|tbodygyro-mean()|tbodygyro-std()", tolower(as.character(features[,2]))))
dat <- dat[,col_idxs]

# Create new variable names that are more straight-forward:
new_names <- c('Accel_Mean_X','Accel_Mean_Y','Accel_Mean_Z',
               'Accel_STD_X','Accel_STD_Y','Accel_STD_Z',
               'Gyro_Mean_X','Gyro_Mean_Y','Gyro_Mean_Z',
               'Gyro_STD_X','Gyro_STD_Y','Gyro_STD_Z')

# Assign new variable names:
names(dat) <- new_names

# add subject IDs
ids <- c(as.numeric(subj_test_id[,1]),as.numeric(subj_train_id[,1]))
dat$Subj_ID <- ids
dat$Subj_ID <- as.factor(dat$Subj_ID)

# add activities
acts <- c(as.numeric(test_activity[,1]),as.numeric(train_activity[,1]))
dat$activity <- acts
dat$activity <- as.factor(dat$activity)
levels(dat$activity) <- c("walk","walk_up","walk_dwn","sit","stand","lay")

# put subject IDs as first column, activity as second, followed by the remaining variables:
dat <- dat[,c('Subj_ID','activity',new_names)]

# sort data fram in ascending order by Subject ID, and then by activity factor:
dat <- dat[order(dat$Subj_ID,dat$activity),]

## Make a smaller tidy data set of the mean values for each participant and activity for all variables:

# use dplyr functions to group the data by participant and activity, and then summarize by taking the mean:
dat_tidy <- group_by(dat,Subj_ID,activity) %>% summarise_each(funs(mean))

# Write it out:
write.table(dat_tidy,file = "tidy_data.txt", append = FALSE, row.names = FALSE)

}




