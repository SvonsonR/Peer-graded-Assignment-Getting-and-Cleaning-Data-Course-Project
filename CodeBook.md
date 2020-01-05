# Code Book
The run_analysis.R script performs som pre steps and the main 5 steps required as described in the course project's definition to accomplish the "Peer-graded Assignment: Getting and Cleaning Data Course Project".

# Steps
## Download
* Download the File
* Unzip it
* read features and activities into R: ```  features ```, ```  activities ```

## Step 1: Merge the training and the test sets to create one data set
* Read and merge training data
* Variables: ```  subject_train``` , ```  y_train```, ```  x_train``` , ```  train``` 
* Read and merge test data: train
* Variables: ```  subject_test``` , ```  y_test```, ```  x_test``` , ```  test```
* Merge training and test data.frames
* Variables: ```  data <- rbind(train, test)```

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement
* Only measurements which contains "std" or "mean" into the data.frame: ```  data_meanstd```

## Step 3: Use descriptive activity names to name the activities in the data set
* Change the labels of the ```  data_meanstd§i ```-column using the ```  activities ```

## Step :4 Appropriately label the data set with descriptive variable names
* i column in TidyData renamed into activities
* Remove abbreviations in column names and other "hard to read"-things:
    + Acc is replaced by Accelerometer
    + angle is replaced by Angle
    + BodyBody is replaced by Body
    + gravity is replaced by Gravity
    + Gyro is replaced by Gyroscope
    + Mag is replaced by Magnitude
    + tBody is replaced by TimeBody
    + f are replaced by Frequency (only in the beginnig of the string)
    + t aee replaced by Time (only in the beginnig of the string)
    + mean, std, freq are replaced by Mean, STD, Frequency
  
## Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
* ```  tidy_data```  is created by sumarizing ```  data_meanstd```  taking the means of each variable for each activity and each subject, after groupped by subject and activity.
* Export ```  tidy_data``` into tidy_data.txt file

