#logistic regression
#library
library(aod)
library(ggplot2)

raw_data <- read.csv("datasets_228_482_diabetes.csv")

#view
head(raw_data)

#summary
summary(raw_data)

#see specific data
sapply(raw_data, sd)
sapply(raw_data,mean)

#missing value
sapply(raw_data,function(x) sum(is.na(x)))
library(Amelia)
missmap(raw_data, main = "Missing values vs observed")

#adjusting 0 values
raw_data$Glucose[raw_data$Glucose==0] <- mean(raw_data$Glucose,na.rm=T)
raw_data$BloodPressure[raw_data$BloodPressure==0] <- mean(raw_data$BloodPressure,na.rm=T)
raw_data$SkinThickness[raw_data$SkinThickness==0] <- mean(raw_data$SkinThickness,na.rm=T)
raw_data$BMI[raw_data$BMI==0] <- mean(raw_data$BMI,na.rm=T)

#checking factor
is.factor(raw_data$Pregnancies)
raw_data$Pregnancies<-as.factor(raw_data$Pregnancies)
is.factor(raw_data$Outcome)

#tabuler view of pregnency
contrasts(raw_data$Pregnancies)
#factoring outcome
raw_data$Outcome<-as.factor(raw_data$Outcome)

#train and test
train <- raw_data[1:600,]
test <- raw_data[601:768,]

model <- glm(Outcome~.,family=binomial(link='logit'),data=train)

#call summary
summary(model)

#anova model
anova(model,test="Chisq")

#mcfadden r2
library(pscl)
pR2(model)

#prediction
fitted.response <- predict(model,newdata=test,type="response")
fitted.results <- ifelse(fitted.response > 0.5,1,0)
misClasificError <- mean(fitted.results != test$Outcome)
print(paste('Accuracy',1-misClasificError))

#roc curve
library(ROCR)
p <- predict(model,newdata=test,type="response")
pr <- prediction(p, test$Outcome)
prf <- performance(pr, measure = "tpr",x.measure = "fpr")
plot(prf)

#area-under curve
auc <- performance(pr,measure = "auc")
auc <- auc@y.values[[1]]
auc








