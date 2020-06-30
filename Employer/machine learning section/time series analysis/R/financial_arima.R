##time series arima model(p,d,q)
library(ggplot2)
library(tseries)
library(forecast)

daily_data <- read.csv("../Downloads/AAPL10Y.csv") #loading data google-ai

#2517 * 6 variables

##step-2

#data examination
daily_data$date <- as.Date(daily_data$date)

#plot
ggplot(daily_data,aes(date,close)) +geom_line() +scale_x_date("month")
+ylab("daily closing volumns")+xlab("")

#upward trend, seasonal data and lot's of noise

##step-3

#outlier detection

count_ts <- ts(daily_data[,c("close")])

daily_data$clean_close <- tsclean(count_ts)

#plot
ggplot(daily_data,aes(date,clean_close)) +geom_line() +scale_x_date("month")
+ylab("daily closing volumns")+xlab("")


##step-4 

#moving average

daily_data$cnt_ma7 <- ma(daily_data$clean_close,order = 7)
daily_data$cnt_ma30 <- ma(daily_data$clean_close,order = 30)

#plot
ggplot() + 
  geom_line(data = daily_data, aes(x = date, y = clean_close, colour = "Counts")) +
  geom_line(data = daily_data, aes(x = date, y = cnt_ma7,   colour = "Weekly Moving Average"))  +
  geom_line(data = daily_data, aes(x = date, y = cnt_ma30, colour = "Monthly Moving Average"))  +
  ylab('Bicycle Count')

#understands the pattern well but not the zig-zag version of the curve

#decompose seasonality,trend,error

count_ma = ts(na.omit(daily_data$cnt_ma7), frequency=30) 
decomp = stl(count_ma, s.window="periodic")
deseasonal_cnt <- seasadj(decomp)
plot(decomp) 

# Dickey-Fuller 
adf.test(count_ma,alternative = "stationary")

#autocorelation and order of model
#order of ma
#pacf order of p
Acf(count_ma, main='')

Pacf(count_ma, main='')

#difference 1
count_d1 = diff(deseasonal_cnt, differences = 1)
plot(count_d1)
adf.test(count_d1, alternative = "stationary")

Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series') 

#target minimize AIC BIC
auto.arima(deseasonal_cnt,seasonal = FALSE)

fit<-auto.arima(deseasonal_cnt, seasonal=FALSE)
tsdisplay(residuals(fit), lag.max=45, main='(1,1,1) Model Residuals')

#forecast
fcast <- forecast(fit,h=30)
plot(fcast)

hold <- window(ts(deseasonal_cnt), start=2300)

fit_no_holdout = arima(ts(deseasonal_cnt[-c(2300:2325)]), order=c(2,1,3))

fcast_no_holdout <- forecast(fit_no_holdout,h=25)
plot(fcast_no_holdout, main=" ")
lines(ts(deseasonal_cnt))

fit_w_seasonality = auto.arima(deseasonal_cnt, seasonal=TRUE)
fit_w_seasonality

seas_fcast <- for ecast(fit_w_seasonality, h=30)
plot(seas_fcast) 






































