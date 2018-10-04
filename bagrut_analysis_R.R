


# =======================
# 
# school_details <- read.xlsx("school_details.xls", sheet = 1, startRow = 1, colNames = TRUE)
# school_details <- read.csv("israel_bagrut_averages_nonutf8.csv")

# =======================

setwd("C:/Users/y_vb/Downloads/bagrut-israel")

library(openxlsx)
library(readxl)
library(readr)
library(dplyr)

# Bagrut grades ============
bagrut <- read_csv(file = "israel_bagrut_averages_new.csv",
                           locale = locale(date_names = "he", encoding = "UTF-8"))

# transform to factor/hebrew
for ( col in names(bagrut) ) {
  if ( is.character(bagrut[[col]])) {
    bagrut[[col]] = as.factor(bagrut[[col]])
  }
}

bagrut <- data.frame(bagrut)
head(bagrut)
summary(bagrut)
sum(which(unique(bagrut$semel)))

# School details ==========
# data manually cleaned to remove "-" and change excel formatting to general
school_details <- read_excel("school_details_cleaned.xls", sheet = 1)

# transform to factor/hebrew
for ( col in names(school_details) ) {
  if ( is.character(school_details[[col]])) {
    school_details[[col]] = as.factor(school_details[[col]])
  }
}

head(school_details)
summary(school_details)
View(school_details)

unique(school_details[,2])
data.frame(school_details)

# combine
colnames(school_details)[2] <- "semel"
class(school_details$semel) 
school_details$semel <- as.numeric(as.character(school_details$semel))

bagrut_comb <- left_join(bagrut, school_details, by = "semel")
View(bagrut_comb)

dim(bagrut)
dim(bagrut_comb)
dim(school_details)

#combine, limit to average
bagrut_complete <- bagrut[!is.na(bagrut$grade),]
#for now getting averaging over years too
head(bagrut)
bagrut_avg = data.frame(bagrut_complete %>% group_by(semel) %>% summarise(mean(grade), mean(studyunits), mean(takers)))
bagrut_avg_comb <- left_join(bagrut_avg, school_details, by = "semel")
dim(bagrut_avg_comb)
View(bagrut_avg_comb)

# correlation

bagrut_numeric <- bagrut_comb[,sapply(bagrut_comb, is.numeric)]
bagrut_cor <- cor(bagrut_numeric, use = "complete.obs")
View(bagrut_cor)

# random forest
partykit
randomForest
# take out the NA grades first
head(bagrut_comb$grade, 100)
bagrut_comb_complete <- bagrut_comb[!is.na(bagrut_comb$grade),]
dim(bagrut_comb_complete_rf)
# take out the features with more than 53 categories (city through yr)
bagrut_comb_complete <- bagrut_comb_complete[,-c(6:11)]
f <- function(x){
  length(levels(x))<53
}
factors <- sapply(bagrut_avg_comb, f)
bagrut_avg_comb_complete_rf <- bagrut_avg_comb[,factors]
dim(bagrut_avg_comb_complete_rf)


library(randomForest)
set.seed(100)
# sample of around 80% for training
train=sample(1:nrow(bagrut_avg_comb_complete_rf),850)
# rough fix for NA values
bagrut.rf=randomForest(mean.grade. ~ . , data = bagrut_avg_comb_complete_rf, subset = train, na.action=na.roughfix)
bagrut.rf
plot(bagrut.rf)

summary(bagrut_comb_complete)
factors <- lapply(bagrut_comb_complete, length(levels))
View(factors)


