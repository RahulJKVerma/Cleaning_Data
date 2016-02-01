library(dplyr)
subject_train <- read.table("train/subject_train.txt", quote="\"")
subject_test <- read.table("test/subject_test.txt", quote="\"")
X_train <- read.table("train/X_train.txt", quote="\"")
y_train <- read.table("train/y_train.txt", quote="\"")
features <- read.table("features.txt", quote="\"")
X_test <- read.table("test/X_test.txt", quote="\"")
y_test <- read.table("test/y_test.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")



# Cleaning the feature names using gsub

head(features)
View(cleanedcolnames)

#cleanedcolnames <- gsub("[[t|f]([A-z]+)-([a-zA-Z]+)\\(?\\)?-?([A-z0-9,]*)|(angle)\\(t?([A-z]+),([A-z]+)\\)]", "\\2\\1for\\3", features$V2, perl=TRUE)
cleanedcolnames <- gsub("([A-Za-z]+)-([a-zA-Z]+)\\(?\\)?-?([A-z0-9,]*)", "\\2\\U\\1for\\3", features$V2, perl=TRUE)
cleanedcolnames <- gsub("(angle)\\(t?([A-z]+)\\)?,([A-z]+)\\)", "\\3\\1\\2", cleanedcolnames, perl=TRUE)
cleanedcolnames <- gsub(",", "to", cleanedcolnames, perl=TRUE)
cleanedcolnames <- gsub("\\.", "", cleanedcolnames, perl=TRUE)
cleanedcolnames <- gsub("for$", "", cleanedcolnames, perl=TRUE)

# Merge the test and traain datasets
complete_set <- rbind(X_test, X_train)
y_set <- rbind(y_test, y_train)
subject_set <- rbind(subject_test, subject_train)

# Assigning the colnames
colnames(complete_set) <- cleanedcolnames

# Select mean and standard deviation columns

selectcols <- grep("^mean|^std", colnames(complete_set))
complete_set <- complete_set[,selectcols]

# Creating the new columns for Subjects and Labels

complete_set[,"subjectIds"] <- subject_set
complete_set[,"yLabel"] <- y_set

# Joining the descriptive labels
colnames(activity_labels) <- c("yLabel","activitylabel")

complete_set <- merge(complete_set,activity_labels,by = "yLabel")

tidy_data <- complete_set %>%
                group_by(subjectIds, activitylabel) %>%
                summarise_each(funs(mean))

# Eliminating the automatically introduced decimal
colnames(tidy_data) <- gsub("\\.", "", colnames(tidy_data), perl=TRUE)

# Exporting data

write.table(tidy_data, "tidyData.txt", sep=" ")




