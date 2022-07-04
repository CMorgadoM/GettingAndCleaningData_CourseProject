# GettingAndCleaningData_CourseProject

 At first i've didn't understood the data, so it were really helpful to read the following posts: 
 the response of Marilinda Croes in: https://www.coursera.org/learn/data-cleaning/discussions/threads/s0CLs6_BEeefpw51rAEiYg/replies/oEAZ07AFEeej-w4lzykahg
 the blog of David Hook in: https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/ 
 the guide from Luis Santino at: https://www.coursera.org/learn/data-cleaning/discussions/weeks/4/threads/wDoBFcHgEeWjNw6BzriyBQ 
 I'm really grateful 
 
 I'm not a native english speaker, so I appologize in advance on how this file is writen.
 
 # Repository files
 The repo contains 4 files (+ README.md), the first one is the scrip required for the project "run_analisys.R", there is also de codebook required, in csv
 format "codebook.csv", and the code I've used to make it "codebook.Rmd" in Rmarkdown format. Finally there is the resultant dataset of the 5th questión of the
 project, it's called "final_dataset" and contains the average for each mesurement for each activity and each subject.
 
 # run_analisys.R
 The file it's divided in 4 parts.
 The first one has the code for download, save, and unzip the files.
 
 The second part (Charge data) read the files for the train and test groups (using read.tables() ), and in point 2.1.A and 2.2.A replace the variables codes
 (numbers) for their respective names (achiving the 3th part of the task), before merging the data frames. Finally in point 2.3 I use cbind() 
 to create one dataset named merged_data (achiving the first part of the project). After every point I've used rm() function to remove the unnecesary files
 
 The third part is destined to extract the columns that measure the mean and standar deviations.
 in the point 3.1 I've extract the columns that had the word "mean" and "std" in their names, in point 3.2 I've assign them to an object and then merge them
 with cbind(), alongside of the subjects and the activity names, in the "MeanAndStd" data frame (achiving the 2th part of the project).
 In point 3.3 I've change the variables names of "MeanAndStd" in an affort of making them more "descriptive" (achiving the 4th part of the project).
 
 Finally, in the 4th part of the script, I create a dataset called "Final_dataset_xd" that contains the dataset required for the 5th part of the project.
 I've first group the "MeanAndStd" data frame by subject and activity, then used summarise_at() function to calculate the mean of every variable sorted 
 by subject and activity, finally I've used pivot_wider() function (from the tidyr package) to convert every activity in a independient varible linked
 to each mesurement. I've used the %>% operator for this proces.
 The final data set contains a first column with subjects ID and 474 columns with every pair messurement-activity, with their respectives mean values for 
 each subject.
 
  #summarizing: the questions:
 
1)Merges the training and the test sets to create one data set. -> Its respond in the point 2.3 of the script ( in the "merged_data" data frame) 

2)Extracts only the measurements on the mean and standard deviation for each measurement. -> It's responded on the 3.2 point (in the "MeanAndStd" data frame)

3)Uses descriptive activity names to name the activities in the data set. -> It's responded on the points 2.1 and 2.2 ( in the "merged_data" data frame) 

4)Appropriately labels the data set with descriptive variable names. -> It's responded on the 3.3 (in the "MeanAndStd" data frame)

5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. -> It's responded in the point 4 (with the Final_dataset_xd data frame)

# Codebook.Rmd
This is the code I've used to create the codebook, stored in csv format in this repo. 
The first part create a function called Var_description, that creates a diferent description of each variable depending on its name. For this I've used 
mostly IF estatements and the grepl() function.

The second part extract every caracterstic of the data that I've found relevant, as a vector, and merged it into a data frame with the variable name, 
the class of the variable, the number of observations, their mean, their standar deviation, max and minimum value and a description of the variable, created
with the Var_descriptión function previusly described.
 
 
 

