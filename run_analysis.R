# Loading needed library
library(dplyr)
# Cleaning environment
rm(list=ls())
# Data import
setwd("./data")
files<-list.files(pattern=".txt")
for(f in files){
        vf<-strsplit(f,"[.]")
        #         Giving feedback to user
        print(paste("...<-",f,sep=":"))
        assign(vf[[1]][[1]],read.table(f))
}
ftr<-filter(features,grepl('mean()|std()',V2))
id<-ftr[,1]
# Proper variables names
nms<-ftr[,2]
nms <- sub("^t", "timeDomain",as.character(nms))
nms <- sub("^f", "frequencyDomain",as.character(nms))
nms <- sub("BodyAcc-", "BodyAccelerationSignal",as.character(nms))
nms <- sub("BodyGyro-", "BodyAngularVelocitySignal",as.character(nms))
nms <- sub("-X", "AlongXaxis",as.character(nms))
nms <- sub("-Y", "AlongYaxis",as.character(nms))
nms <- sub("-Z", "AlongZaxis",as.character(nms))
nms <- sub("GravityAcc-", "GravityAcceleration",as.character(nms))
nms <- sub("BodyAccJerk-", "DerivedBodyLinearAcceleration",as.character(nms))
nms <- sub("BodyGyroJerk-", "DerivedBodyAngularVelocity",as.character(nms))
nms <- sub("BodyAccMag-", "EuclideanBodyAcceleration",as.character(nms))
nms <- sub("GravityAccMag-", "EuclideanGravityAcceleration",as.character(nms))
nms <- sub("BodyAccJerkMag-", "DerivedEuclideanBodyLinearAcceleration",as.character(nms))
nms <- sub("BodyGyroMag-", "EuclideanBodyAngularVelocity",as.character(nms))
nms <- sub("BodyGyroJerkMag-", "DerivedEuclideanBodyAngularVelocity",as.character(nms))
nms <- sub("mean\\()", "Mean",as.character(nms))
nms <- sub("std\\()", "Stddev",as.character(nms))
nms <- sub("meanFreq\\()", "MeanFrequency",as.character(nms))
nms <- sub("BodyBody", "Body",as.character(nms))

# Merge train and test data.
s <- tbl_df(rbind(subject_train,subject_test))
X <- tbl_df(rbind(X_train[,id],X_test[,id]))
y <- tbl_df(rbind(y_train,y_test))

names(X)<-nms
# Joining subject with variables
X<-tbl_df(cbind(s,X)) %>% rename(c('V1'='subject'))
# Joining activity with variables
ya<-tbl_df(join(y,activity_labels))
tidy<-tbl_df(cbind(ya$V2,X)) %>% rename(c('ya$V2'='activity'))
tidy_agg<-tbl_df(aggregate(tidy,by = list(tidy$subject,tidy$activity),FUN="mean")) %>% select(-c(activity,subject)) %>% rename(c('Group.1'='subject',c('Group.2'='activity')))
# Export data
write.csv(tidy,"tidy.csv")
write.table(tidy_agg,"TidyAggregatedBySourceAndActivity.txt",row.name=FALSE)
setwd("../")
print("Work is DONE...")