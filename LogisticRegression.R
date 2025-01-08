# Clear environment
rm(list=ls())
# Clear console
cat("\014")

# Library
library(caTools)
library(dplyr)
#install.packages("ROCR")
library(ROCR)

# Summary of dataset in package
summary(mtcars)

# Splitting the dataset
split<-sample.split(mtcars,SplitRatio=0.8)
split

train_reg=subset(mtcars,split==T)
test_reg<-subset(mtcars,split==F)

# Training the model.
logistic_reg<-glm(vs~wt+disp,data=train_reg,family = "binomial")
logistic_reg

# Summary of model
summary(logistic_reg)

predict_reg<-predict(logistic_reg,test_reg,type = "response")
predict_reg

# Changing probabilities
predict_reg<-ifelse(predict_reg>0.5,1,0)

# Evaluating model accuracy
# Using confusion matrix
table(test_reg$vs,predict_reg)

missing_classerr<-mean(predict_reg!=test_reg$vs)
print(paste('Accuracy=',1- missing_classerr))

# ROC-AUC Curve
ROCPred<-prediction(predict_reg,test_reg$vs)
ROCPer<-performance(ROCPred,measure = "tpr",x.measure ="fpr")
auc<-performance(ROCPred,measure = "auc")
auc<-auc@y.values[[1]]
auc

# Plotting curve
plot(ROCPer)
plot(ROCPer,colorize=T,
     print.cutoffs.at=seq(0.1,by=0.1),
     main="ROC CURVE")
abline(a=0,b=1)

auc=round(auc,4)
legend(.6,.4,auc,title = "AUC",cex=1)
