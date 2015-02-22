loadData <- function(path,type) {
  dat <- list()
  
  dat$X <- read.csv(header=F,paste(sep='',path,'/X_',type,'.txt'),sep='')
  names(dat$X) <- unlist(lapply(names(dat$X),function(x) paste(sep='.','X',x)))
  dat$y <- read.csv(header=F,paste(sep='',path,'/y_',type,'.txt'),sep='')
  names(dat$y) <- c('activity')
  dat$s <- read.csv(header=F,paste(sep='',path,'/subject_',type,'.txt'),sep='')
  names(dat$s) <- c('subject')
  for (measure in c('total_acc','body_gyro','body_acc')) {
    for (coord in c('x','y','z')) {
      name <- paste(sep='_',measure,coord)
      dat[[name]] <- read.csv(header=F,paste(sep='',path,'/Inertial Signals/',name,'_',type,'.txt'),sep='')
      names(dat[[name]]) <- unlist(lapply(names(dat[[name]]),function(x) paste(sep='.',name,x)))
    }
  }
  result <- dat$X
  for (n in names(dat)) {
    if (n != 'X') result <- cbind(result,dat[[n]])
  }
  result$type <- type
  result
}


generateCleanData <- function() {
  # 1. Merges the training and the test sets to create one data set.
  dat <- loadData('UCI HAR Dataset/train','train')
  dat <- rbind(dat,loadData('UCI HAR Dataset/test','test'))
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  # 4. Appropriately labels the data set with descriptive variable names.
  features <- read.csv('UCI HAR Dataset/features.txt',header=F,sep='')
  filter <- grepl('mean',features$V2) | grepl('std',features$V2)
  dat.filtered <- dat[,which(filter)]
  names(dat.filtered) <- features[which(filter),'V2']
  dat.filtered <- cbind(dat.filtered,dat[,c('activity','subject','type')])
  
  # 3. Uses descriptive activity names to name the activities in the data set
  activities <- read.csv('UCI HAR Dataset/activity_labels.txt',header=F,sep='')
  names(activities) <- c('activity','activityExplicit')
  dat.labeled <- merge(dat.filtered,activities,by='activity')
  dat.labeled$activity <- dat.labeled$activityExplicit
  dat.labeled <- subset(dat.labeled,select=-c(activityExplicit))
  
  dat.labeled
}

unzip('getdata-projectfiles-UCI HAR Dataset.zip')
dat <- generateCleanData()
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
dat.means <- ddply(dat,.(activity,subject), function(df) {colMeans(subset(df,select=-c(activity,subject,type)))})
write.table(dat.means,"dat.means.txt",row.name=FALSE)
