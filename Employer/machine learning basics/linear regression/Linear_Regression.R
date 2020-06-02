#R LINEAR regression

#Assumptions of Linear Regression
#1.The regression model is linear in parameters
#2.The mean of residuals is zero
#3.Homoscedasticity of residuals or equal variance
#4.No autocorrelation of residuals
#5.The X variables and residuals are uncorrelated
#6.The number of observations must be greater than number of Xs
#7.The variability in X values is positive
#8.The regression model is correctly specified
#9.No perfect multicollinearity
#10.Normality of residuals

#2 Example
model <- lm(dist ~ speed,data=cars)
mean(model$residuals)

#3 example
par(mfrow=c(2,2))
model <- lm(dist ~ speed,data=cars)
plot(model)


#4
library(ggplot2)
lmmod <- lm(dist ~ speed, data=cars)
acf(lmmod$residuals)

#test
library(lawstat)
runs.test(lmmod$residuals) #no pattern

#durbin-watson test
lmtest::dwtest(lmmod)

#if autocorelation found
library(DataCombine)
lmMod <- lm(pce ~ pop, data=economics)
econ_data <- data.frame(economics, resid_mod1=lmMod$residuals)
econ_data_1 <- slide(econ_data, Var="resid_mod1", NewVar = "lag1", slideBy = -1)
econ_data_2 <- na.omit(econ_data_1)
lmMod2 <- lm(pce ~ pop + lag1, data=econ_data_2)

#acf
acf(lmMod2$residuals)
runs.test(lmMod2$residuals)


#5
mod.lm <- lm(dist ~ speed, data=cars)
cor.test(cars$speed, mod.lm$residuals)

#7
var(cars$speed)

#9
library(car)
mod2 <- lm(mpg ~ ., data=mtcars)
vif(mod2)


#iteratively remove x with highest vif
#corelation
library(corrplot)
corrplot(cor(mtcars[,-1]))

mod <- lm(mpg ~ cyl + gear, data=mtcars)
vif(mod)

#10
par(mfrow=c(2,2))
mod <- lm(dist ~ speed, data=cars)
plot(mod)

#auto check
par(mfrow=c(2,2))  # draw 4 plots in same window
mod <- lm(dist ~ speed, data=cars)
gvlma::gvlma(mod)

plot(mod)

mod <- lm(dist ~ speed, data=cars[-c(23, 35, 49), ])
gvlma::gvlma(mod)

influence.measures(mod)

#linear regression
head(cars)
#some graphs
scatter.smooth(x=cars$speed,y=cars$dist, main="Dist ~Speed")

#boxplot
par(mfrow=c(1, 2))  # divide graph area in 2 columns
boxplot(cars$speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$speed)$out))  # box plot for 'speed'
boxplot(cars$dist, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$dist)$out))  # box plot for 'distance'

#dinsity check
library(e1071)
par(mfrow=c(1, 2))  # divide graph area in 2 columns
plot(density(cars$speed), main="Density Plot: Speed", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$speed), 2)))  # density plot for 'speed'
polygon(density(cars$speed), col="red")
plot(density(cars$dist), main="Density Plot: Distance", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$dist), 2)))  # density plot for 'dist'
polygon(density(cars$dist), col="red")


#correlation
cor(cars$speed, cars$dist)
linearMod <- lm(dist ~ speed, data=cars)  # build linear regression model on full data
print(linearMod)

#summary
summary(linearMod)
#statistics
modelSummary <- summary(linearMod)  # capture model summary as an object
modelCoeffs <- modelSummary$coefficients  # model coefficients
beta.estimate <- modelCoeffs["speed", "Estimate"]  # get beta estimate for speed
std.error <- modelCoeffs["speed", "Std. Error"]  # get std.error for speed
t_value <- beta.estimate/std.error  # calc t statistic
p_value <- 2*pt(-abs(t_value), df=nrow(cars)-ncol(cars))  # calc p Value
f_statistic <- linearMod$fstatistic[1]  # fstatistic
f <- summary(linearMod)$fstatistic  # parameters for model p-value calc
model_p <- pf(f[1], f[2], f[3], lower=FALSE)




















