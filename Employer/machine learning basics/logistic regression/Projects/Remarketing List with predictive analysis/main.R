#google analytics premium bigquery statistics

#loading the data
data <- read.csv("./data/train_data.csv")

#see head
head(data)
View(data)

#columns names
names(data)

#remove columns that are insignificant to me
data <- data[c(-1,-2,-22)]

#too much variable still left use pearson coreration to see colinearity
corr<-cor(data)
library(corrplot)
corrplot1<-corrplot(corr)

symnum(abs(cor(data)),cutpoints = c(0, 0.2, 0.4, 0.6, 0.9, 1), symbols = c(" ", ".", "_", "+", "*"))

#remove a_sum_total_hits and a_diffdays for .9 colinear value
data <- data[c(-3,-7)]

#removing midnignt_flag 
data <- data[,c(-13)]


#we can run initial data model but first lets see balancing act
table(data$b_CV_flag)

#pure unbalanced data you see

model <- glm(b_CV_flag~.,data,family = binomial("logit"))
result <- summary(model)
result


#now let's say this is my benchmark model

#check for multicolinear data
library(car)
library(rms)
vif(model)

#removing _pageview for colinearity
#unchanged our basemodel data
data1 <- data[,c(-2)]

#new model
model1 <- glm(formula = b_CV_flag ~., data = data1, family = binomial("logit"))
result1 <- summary(model1)
result1

vif(model1)

#result view
prob <- data.frame(predict(model1, data1, type = "response"))
gain <- cumsum(sort(prob[, 1], decreasing = TRUE)) / sum(prob)
png('gain_curve_plot.png')
plot(gain,main ="Gain chart",xlab="number of users", ylab="cumulative conversion rate")
dev.off()

#ROC CURVE
library(ROCR)
pred <- prediction(prob, data1$b_CV_flag)
perf <- performance(pred, measure = "tpr", x.measure = "fpr")
qplot(x = perf@x.values[[1]], y = perf@y.values[[1]], xlab = perf@x.name, ylab = perf@y.name, main="ROC curve")

#coefficient
coef <- names(model1$coefficients)
value <- as.vector(model1$coefficients)
result <- data.frame(coef,value)
result





