# Load data.table package
library(data.table)

# set path
path <- "./data/UCI HAR Dataset/"

# Get subject data
subjectTrain <- read.table(file.path(path, "train", "subject_train.txt"))
subjectTest <- read.table(file.path(path, "test", "subject_test.txt"))

# Get training and test labels
labelTrain <- read.table(file.path(path, "train", "y_train.txt"))
labelTest <- read.table(file.path(path, "test", "y_test.txt"))

# Get training and test set data
dataTrain <- read.table(file.path(path, "train", "x_train.txt"))
dataTest <- read.table(file.path(path, "test", "x_test.txt"))

# merge subjects, labels, data

subjects <- rbind(subjectTrain, subjectTest)
labels <- rbind(labelTrain, labelTest)
data <- rbind(dataTrain, dataTest)

# rename variables in subjects and labels to be more descriptive

names(subjects) <- "subjectnumber"
names(labels) <- "activitylabel"

# read variable names from file features.txt to rename columns in 'data'
features <- read.table(file.path(path, "features.txt"))
names(data) <- features$V2

# merge all three tables to one full data table
fulldata <- cbind(subjects, labels, data)

# get feature (column) names which contain "mean" or "std"
selected_features <- grep("mean|std", features$V2, value = TRUE)

# prepare add first 2 columns of fulldata, to prepare extraction of needed data

selected_features <- c("subjectnumber", "activitylabel", selected_features)

# extract only needed mean, std columns for further analysis
fulldata <- subset(fulldata, select = selected_features)

# read activity labels and names from file, use as.is to prevent values turning to factors 

activities <- read.table(file.path(path, "activity_labels.txt"), as.is = TRUE)

# replace activitylabels in fulldata with activity names, rename column respectively

fulldata[["activitylabel"]] <- activities[ match(fulldata[['activitylabel']], activities[['V1']]), 'V2']
setnames(fulldata, "activitylabel", "activity")

# Make variable names more descriptive

names(fulldata) <- gsub("^t", "time", names(fulldata));
names(fulldata) <- gsub("^f", "frequency", names(fulldata));
names(fulldata) <- gsub("Acc", "Accelerometer", names(fulldata));
names(fulldata) <- gsub("Gyro", "Gyroscope", names(fulldata));
names(fulldata) <- gsub("Mag", "Magnitude", names(fulldata));

# Aggregate the fulldata by calculating the means for each subjects each activity, write data to file

tidydata <- aggregate(. ~ subjectnumber - activity, data = fulldata, FUN = mean)
write.table(tidydata, file = "tidydata.txt", row.name = FALSE)

