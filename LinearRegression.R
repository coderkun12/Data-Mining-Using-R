rm(list = ls())
cat("\014")
# Creation of data frame.
data<-data.frame(
  Years_Exp=c(1.1,1.3,1.5,2.0,2.2,2.9,3.0,3.2,3.2,3.7),
  Salary=c(39343.00,46205.00,37731.00,43525.00,39891.00,56642.01,60150.20,54445.67,64445.89,57189.33))

# Creation of scatter plot: 
plot(data$Years_Exp,data$Salary,pch=19,xlab = 'Years Experienced',ylab='Salary',main='Scatter plot: Years Experienced v/s Salary',col='red')

# Partitioning the data
install.packages('caTools')
library(caTools)
split=sample.split(data$Salary,SplitRatio = 0.7)
training_set=subset(data,split==T)
testset=subset(data,split==F)

# Fitting simple linear regression to the training set
lm.r=lm(formula = Salary ~ Years_Exp,data=training_set)

# summary of the model.
summary(lm.r)

# Create a data feame with new input values:
new_data=data.frame(Years_Exp=c(4.0,9.0,7.5))

# Predict them using Linear regression model
predict_salaries=predict(lm.r,newdata = new_data)

# Print the predicted salary: 
predict_salaries

# Visualize training set results:
library(ggplot2)
ggplot() + geom_point(aes(x = training_set$Years_Exp, y = training_set$Salary), colour = 'red') +
  geom_line(aes(x = training_set$Years_Exp,	y = predict(lm.r, newdata = training_set)), colour = 'blue') +
  ggtitle('Salary vs Experience (Training set)') +
  xlab('Years of experience') +
  ylab('Salary')

# Visualize test set results
ggplot() +
  geom_point(aes(x = testset$Years_Exp, y = testset$Salary), colour = 'red') +
  geom_line(aes(x = training_set$Years_Exp, y = predict(lm.r, newdata = training_set)), colour = 'blue') +
  ggtitle('Salary vs Experience (Test set)') +
  xlab('Years of experience') +
  ylab('Salary')
