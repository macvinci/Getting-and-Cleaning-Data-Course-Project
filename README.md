# Getting-and-Cleaning-Data-Course-Project
Here is how I proceed to achieve this Project.

First I loaded feature.txt file and put all features names in a vector. 
Then I loaded train datas in a dataframe and replaced columns names with values contain in the features vector.
Then I loaded activity training ID (y_train.txt) and subject ID (subject_test.txt)  into 2 differents dataframes and combined them with the previous data frame.

I repeat the same patern with test data set to obtain 2  identical dataframes and merge them together to obtain one main dataframe.

Then I removed several columns of the main data frame : I kept columns with  words "mean" and "std" plus activity  and subject ID.

Then I loaded activity labels  (activity_labels.txt) and merge them with the main dataframe to remplace activities ID by descriptives names.

Then I created 2 function to make sure that all the datas were between -1 and 1.

Finally, I used data.table package to transform the main data frame in a data table. I grouped it by subject ID and Activity names to finally calculate the average of each variable for each activity and each subject.

To get the result in txt file, I used the classic write.table function.
