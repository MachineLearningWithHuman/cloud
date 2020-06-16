#R-logistics

#import data
data <- read.csv("../Downloads/datasets_228_482_diabetes.csv")

head(data)

#first check for bias-ness in data
table(data$Outcome)

#clear bias data

#create training data
input_ones <- data[which(data$Outcome==1),]
input_zeros <- data[which(data$Outcome==0),]

set.seed(1)
input_one_training_rows <- sample(1:nrow(input_ones), 0.8*nrow(input_ones))
input_zero_training_rows <- sample(1:nrow(input_zeros), 0.8*nrow(input_ones))
training_ones <- input_ones[input_one_training_rows, ]  
training_zeros <- input_zeros[input_zero_training_rows, ]
trainingData <- rbind(training_ones, training_zeros)  # row bind the 1's and 0's 

# Create Test Data
test_ones <- input_ones[-input_one_training_rows, ]
test_zeros <- input_zeros[-input_zero_training_rows, ]
testData <- rbind(test_ones, test_zeros)  # row bind the 1's and 0's 


#build logit
logitMod <- glm(Outcome ~ .,data=trainingData,family =binomial(link = "logit"))

predicted <- predict(logitMod,testData,type = "response")

#optimal cutoff point
library(InformationValue)
optcutoff <- optimalCutoff(testData$Outcome, predicted)[1]
optcutoff

#model diagonsis
summary(logitMod)

library(car)
vif(logitMod)

misClassError(testData$Outcome,predicted,threshold = optcutoff)

#roc curve
plotROC(testData$Outcome,predicted)
Concordance(testData$Outcome,predicted)

confusionMatrix(testData$Outcome,predicted,threshold = optcutoff)
