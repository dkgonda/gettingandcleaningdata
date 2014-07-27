#run_analysis.R
#David Keith Gonda, author
#27-JUL-2014
#R script for partial fulfillment of project requirements for
#Coursera class "Getting and Cleaning Data"
#
#See accompanying README file for description of script


#read in the dataset files after unzipping archive in working directory
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

#combine test and train data pieces
X_combined <- rbind(X_train,X_test)
subject_combined <- rbind(subject_train,subject_test)
y_combined <- rbind(y_train,y_test)

#combine attributes
all_combined <- cbind(subject_combined,y_combined,X_combined)

#initial name of attributes
names(features) <- c("featureID","featureName")
names(activity_labels) <- c("activityID","activityLabel")
featureNames <- as.vector(features[,"featureName"])
names(all_combined) <- c("subjectID","activityID",featureNames)

#restrict names to subject/training ids + mean and std attributes
mean_std_data <- all_combined[,grep("subjectID|activityID|mean|std",names(all_combined))]

#clean up attribute names
temp1 <- gsub("\\(\\)","",names(mean_std_data))
temp1 <- gsub("-mean","Mean",temp1)
temp1 <- gsub("-std","Std",temp1)
temp1 <- gsub("-","",temp1)
names(mean_std_data) <- temp1

#decode trainingLabelID into descriptive names:
mean_std_data <- merge(activity_labels,mean_std_data,by.x="activityID",by.y="activityID")
mean_std_data["activityID"] <- NULL

#mean_std_data is final tidy data set; write out
write.csv(mean_std_data,"tidydata.csv",row.names=FALSE)

#aggregate data set to take mean of all measurements for each combination
#of subject and activity,
#and alter names of frame to reflect new values;
#append "avgBySubjectActivity" to all but first two columns
agg_mean_std_data <- aggregate(.~activityLabel+subjectID,mean_std_data,mean)
n <- names(agg_mean_std_data)
new_n <- c( n[1:2],paste("avgBySubjectActivity", n[3:length(n)],sep=""))
names(agg_mean_std_data) <- new_n

#write out aggregated tidy data set
write.csv(agg_mean_std_data,"agg_tidydata.csv",row.names=FALSE)

#end of script
