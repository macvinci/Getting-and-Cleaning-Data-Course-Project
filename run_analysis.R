

#install packages used in the sript

library(data.table)
library(dplyr)


# load features file an convert it in a vector
features<- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE, sep= "")
VectFeat<- as.vector(features$V2)



# load training set
trainingSet<- read.table(file = "UCI HAR Dataset/train/X_train.txt", header = FALSE, sep= "")
#add column names to the training set with the features
colnames(trainingSet)<-VectFeat

# load activity numbers and subject ID  then merge them with the training set
activityNumTrain<-read.table(file = "UCI HAR Dataset/train/y_train.txt", header = FALSE, sep= "")
IDNumTrain<-read.table(file = "UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep= "")
colnames(IDNumTrain)<- c('Subject_ID')
trainingSet2 <- cbind(activityNumTrain,IDNumTrain,trainingSet)

# load test set
testSet<- read.table(file = "UCI HAR Dataset/test/X_test.txt", header = FALSE, sep= "")
#add column names to the test set with the features
colnames(testSet)<-VectFeat
# load activity numbers and subject ID  then merge them with the test set
activityNumTest<-read.table(file = "UCI HAR Dataset/test/y_test.txt", header = FALSE, sep= "")
IDNumTest<-read.table(file = "UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep= "")
colnames(IDNumTest)<- c('Subject_ID')
testSet2 <- cbind(activityNumTest,IDNumTest,testSet)


#merge trainset and testset
ConcatSet<- rbind(trainingSet2,testSet2)

# Subset columns containing 'V1' , ID' , 'Mean' and 'Std' word in their names.
Subset.Set <- ConcatSet[,grep('[Vv][1]|[Ii][Dd]|[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]',names(ConcatSet))]



# load activity names
ActNames <- read.table(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE, sep= "")
# rename activity names column as 'Activity'
colnames(ActNames) <- c('V1','Activity')

#Add Activity Names 
Subset.Set.Name <- merge(ActNames,Subset.Set,by.x = "V1",by.y = "V1")


# function to detect sporious values less than -1
checkmin <- function(X){
  if(min(X) < -1){
  y = 1
  
  }else{
  y = 0
  }
}
testmin <- lapply(FinalSet[,-c(1,2)],FUN = checkmin)
if(length(which(testmin == 1) > 0)){
  print("there is a least one values less than -1")
}else{
  print("test ok")
}

# function to detect sporious values less than -1
checkmax <- function(X){
  if(max(X) > 1){
    y = 1
}else {
    y = 0
}
}
testmax <- lapply(FinalSet[,-c(1,2)],FUN = checkmax)
if(length(which(testmax == 1) > 0)){
  print("there is a least one values less than -1")
  }else{
  print("test ok")
}



# Remove Activity number
FinalSet <- subset(Subset.Set.Name,select = - c(V1))

#Transform Dataframe to Data table
FinalSetDT <- data.table(FinalSet)

# Calculate mean by ID subject and Activity 
GroupSet <- group_by(FinalSetDT,Subject_ID,Activity,add=TRUE)
FinalSet2 <- summarise_each(GroupSet,funs(mean))

# write the FinalSet on *.txt file
write.table(FinalSet, file = "FinalSet.txt", append = FALSE, quote = TRUE, sep = ",", na = "NA", dec = ".", row.names = FALSE,col.names = TRUE, qmethod = c("escape", "double"))



# write the FinalSet2 on *.txt file
write.table(FinalSet2, file = "FinalSet2.txt", append = FALSE, quote = TRUE, sep = ",", na = "NA", dec = ".", row.names = FALSE,col.names = TRUE, qmethod = c("escape", "double"))

