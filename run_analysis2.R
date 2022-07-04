######## Course Project ########
# At first i've didn't understood the data, so it were really helpful to read the following posts:
# the response of Marilinda Croes in: https://www.coursera.org/learn/data-cleaning/discussions/threads/s0CLs6_BEeefpw51rAEiYg/replies/oEAZ07AFEeej-w4lzykahg
# the blog of David Hook in: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
# the guide from Luis Santino at: https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/wDoBFcHgEeWjNw6BzriyBQ
# I'm really grateful

######## 1-download data ########

urldatos <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dtfile <- paste(getwd(), "/dataset.zip", sep = "")
download.file(urldatos, dtfile)
unzip(zipfile = "dataset.zip")

######### 2-Charge Data #########
### 2.1-training data
library(dplyr)
dir_X_train<-paste(getwd(), "/UCI HAR Dataset/train/X_train.txt", sep = "")
dir_Y_train <- paste(getwd(), "/UCI HAR Dataset/train/y_train.txt", sep = "")
dir_subject_train <- paste(getwd(), "/UCI HAR Dataset/train/subject_train.txt", sep = "")
dir_act_labels <- paste(getwd(), "/UCI HAR Dataset/activity_labels.txt" , sep= "")
dir_features <- paste(getwd(), "/UCI HAR Dataset/features.txt" , sep= "")

x_train <- read.table(dir_X_train)
y_train <- read.table(dir_Y_train)
sub_train <- read.table(dir_subject_train)
act_lab <- read.fwf(dir_act_labels, widths = c(1,18))
features <- read.table(dir_features) 

# a) replace the activity numbers with their correspondent names

for(i in 1:nrow(y_train)){
    if(y_train[i,1] == act_lab[1,1]){
        y_train[i,1] <- act_lab[1,2]
    }else if(y_train[i,1] == act_lab[2,1]){
        y_train[i,1] <- act_lab[2,2]
    }else if(y_train[i,1] == act_lab[3,1]){
        y_train[i,1] <- act_lab[3,2]
    }else if(y_train[i,1] == act_lab[4,1]){
        y_train[i,1] <- act_lab[4,2]
    }else if(y_train[i,1] == act_lab[5,1]){
        y_train[i,1] <- act_lab[5,2]
    }else if(y_train[i,1] == act_lab[6,1]){
        y_train[i,1] <- act_lab[6,2]}
}
y_train <- rename(y_train, activity_name = V1)

# b) merge the activity with the value(x_train) and the subject (sub_train))
sub_train <- rename(sub_train, subject = V1)
names(x_train)<-features$V2
train_data <- cbind(sub_train, y_train, x_train) 
# c) Erase used objects
rm(sub_train, x_train, y_train, dir_act_labels,dir_subject_train, dir_X_train, dir_Y_train, dtfile, urldatos, dir_features)

### 2.2 -test data
dir_X_test<-paste(getwd(), "/UCI HAR Dataset/test/X_test.txt", sep = "")
dir_Y_test <- paste(getwd(), "/UCI HAR Dataset/test/y_test.txt", sep = "")
dir_subject_test <- paste(getwd(), "/UCI HAR Dataset/test/subject_test.txt", sep = "")

x_test <- read.table(dir_X_test)
y_test <- read.table(dir_Y_test)
sub_test <- read.table(dir_subject_test)

# a) replace the activity numbers with their correspondent names
for(i in 1:nrow(y_test)){
    if(y_test[i,1] == act_lab[1,1]){
        y_test[i,1] <- act_lab[1,2]
    }else if(y_test[i,1] == act_lab[2,1]){
        y_test[i,1] <- act_lab[2,2]
    }else if(y_test[i,1] == act_lab[3,1]){
        y_test[i,1] <- act_lab[3,2]
    }else if(y_test[i,1] == act_lab[4,1]){
        y_test[i,1] <- act_lab[4,2]
    }else if(y_test[i,1] == act_lab[5,1]){
        y_test[i,1] <- act_lab[5,2]
    }else if(y_test[i,1] == act_lab[6,1]){
        y_test[i,1] <- act_lab[6,2]}
}
y_test <- rename(y_test, activity_name = V1)

# b) merge the activity with the value(x_train) and the subject (sub_train))
sub_test <- rename(sub_test, subject = V1)
names(x_test)<-features$V2
test_data <- cbind(sub_test, y_test, x_test) 

# c) Erase used objects
rm(sub_test, x_test, y_test,dir_subject_test, dir_X_test, dir_Y_test, act_lab, i)

### 2.3 - Merge the data sets
merged_data <- rbind(train_data, test_data)
rm(test_data, train_data, features)

######### 3-Extract mean and std #########
### 3.1 - Extract the relevant columns
promedios <- grep("mean", names(merged_data), value = T)
estandardev <- grep("std", names(merged_data), value = T)
dat1 <- select(merged_data, promedios)
dat2 <- select(merged_data, estandardev)
acts <- select(merged_data, subject, activity_name)

### 3.2 - Merge the resultant columns
MeanAndStd <- cbind(acts, dat1, dat2)
rm(acts, dat1,dat2, estandardev, promedios)

### 3.3 Adapt names of the variables (change to descriptive names)
varnames <-gsub("^t", "time_", names(MeanAndStd))
varnames <-gsub("\\()", "", varnames) 
varnames <-gsub("^f", "freq_", varnames)
varnames <-gsub("Acc", "_acceleration_", varnames)
varnames <-gsub("Gyro", "_gyroscope_", varnames)
varnames <-gsub("\\-", "_", varnames) 
names(MeanAndStd) <- varnames
rm(varnames)

###### 4 - Create a dataset with average of each variable per activity and subject ######

library(tidyr)
Final_dataset_xd <- MeanAndStd %>%  
    group_by(subject, activity_name) %>% 
    summarise_at(names(MeanAndStd)[3:81], mean) %>% 
    pivot_wider(names_from = activity_name, values_from = names(MeanAndStd)[3:81])

# sorry for the name of the dataset, I've was just happy to finally end this assignment jaja


write.table(Final_dataset_xd, file = "C:/Users/juice/final_dataset.txt", row.names = F)


