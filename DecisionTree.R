rm(list=ls())
cat('\014')
install.packages('party')
install.packages('caret')

library(datasets)
library(caTools)
library(party)
library(dplyr)
library(magrittr)
library(caret)

data("iris")
head(iris)

sample<-sample.split(iris,SplitRatio = 0.8)
train_data<-subset(iris,sample==T)
test<-subset(iris,sample==F)
View(iris)

model=ctree(Species~.,train_data)
plot(model)

predict_model<-predict(model,test)

m_at<-table(test$Species,predict_model)
m_at

ac_Test<-sum(diag(m_at))/sum(m_at)

print(paste('Accuracy fot test is found to be:',100*ac_Test))
