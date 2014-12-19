## Getting and Cleaning Data Week 3 Programming Assignment
## Please unzip and save the Samsung data in the R working directory
## See CODEBOOK.md for files required from the Samsung dataset

# Check and load required R packages: dplyr, reshapes, tidyr
pkg<-c("dplyr","reshape2","tidyr")
pkgCheck<-pkg %in% rownames(installed.packages())
for(i in 1:length(pkg)) {
    if(pkgCheck[i]==FALSE) {
        install.packages(pkg[i])
    } 
    library(pkg[i],character.only = TRUE)
}
rm(i,pkg,pkgCheck)

# Read "activity"& "features" labels.  
act<-read.table("./activity_labels.txt",colClasses=c("integer","character"))
features<-read.table("./features.txt",colClasses=c("integer","character"))
features[,2]<-gsub("[()]","",features[,2])  # remove "()" in the variable names
features[,2]<-gsub("fBodyBody","fBody",features[,2])  # correct variable names #516-554

# Read raw data and sets column headers(descriptive variable names)
train<-read.table("./X_train.txt",col.names=features[,2])
test<-read.table("./X_test.txt",col.names=features[,2])
trainSub<-read.table("./subject_train.txt",col.names="subject")
trainAct<-read.table("./y_train.txt",col.names="activity")
testSub<-read.table("./subject_test.txt",col.names="subject")
testAct<-read.table("./y_test.txt",col.names="activity")

# Merge training data and test data
allSub<-rbind(trainSub,testSub)
allAct<-rbind(trainAct,testAct)
allData<-rbind(train,test)
colnames(allData)<-gsub("[.]","-",colnames(allData))
allData<-cbind(allAct,allData)
allData<-cbind(allSub,allData)

# Remove data sets that are no longer required
rm(trainAct,trainSub,testAct,testSub,allAct,allSub,test,train)

# Label descriptive acitvity names
allData$activity<-factor(allData$activity,labels=act[,2])

# Extract only the measurements of the mean and standard deviation for each measurement
allData2<-select(allData,subject:activity,contains("mean"),contains("std"))
# allData2 contais only "mean" and "std" measurements

# Create a second, independent tidy dataset with the average of each variable for 
# each activity and each subject
tidyData<-allData2 %>%
    melt(id.vars = c("subject", "activity"),variable.name="features") %>%
    group_by(subject,activity,features) %>%
    summarize(m=mean(value))

# Ungroup tidyData because "spread" function doesn't work with grouped tbl
# dplyr bug(https://github.com/hadley/tidyr/issues/32)
tidyData<-spread(ungroup(tidyData),features,m) 

# Save output "tidyData.txt" in the R working directory "./"
# To open tidyData.txt with MS Excel, use delimiter="space"
write.table(tidyData,"./tidyData.txt",row.names=FALSE)
