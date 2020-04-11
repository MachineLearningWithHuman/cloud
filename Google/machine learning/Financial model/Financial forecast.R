#loading packages
library('ggplot2')#visualization
library('forecast')#forecast
library('tseries')#timeseries

daily_data <- read.csv("AAPL10Y.csv", header=TRUE, stringsAsFactors=FALSE)  #loading the data

daily_data<-daily_data[order(as.Date(daily_data$date, format="%d/%m/%Y")),] #sorting data

#Examine your data
#A good stating point is to plot the series 
#and visually examine it for any outliers, volatility, or irregularities.

daily_data$date <- as.Date(daily_data$date)  


#plotting data
window()
ggplot(daily_data, aes(date, close)) + geom_line() + scale_x_date('Year')  + ylab("Closing volume") +
  xlab("")

#strucure
str(daily_data$close)
summary(daily_data$close)
#plotting histagram of the data
hist(daily_data$close,col = "blue")
daily_data$log_close <- log(daily_data$close)
hist(daily_data$log_close,col = "blue")  #right skewed distribution

#cleaning the outliers if any in ts
count_ts = ts(daily_data[, c('close')]) 

daily_data$clean_close = tsclean(count_ts)  #it is removing the maximum volume it treats it like outlier
summary(daily_data$clean_close) #summary statistics
length(daily_data$clean_close) #2517 observation
is.na(daily_data$clean_close) #no NA value

window()
ggplot() + 
  geom_line(data = daily_data, aes(x = date, y = clean_close)) + ylab('Cleaned close volume') 

#smoothning curve with moving average
daily_data$close_ma = ma(daily_data$clean_close, order=7) # using the clean count with no outliers
daily_data$close_ma30 = ma(daily_data$clean_close, order=30)

#plotting
ggplot() + 
  geom_line(data = daily_data, aes(x = date, y = clean_close, colour = "Counts")) +
  geom_line(data = daily_data, aes(x = date, y = close_ma,   colour = "Weekly Moving Average"))  +
  geom_line(data = daily_data, aes(x = date, y = close_ma30, colour = "Monthly Moving Average"))  +
  ylab('close volume')

#decomposing additive
count_ma = ts(na.omit(daily_data$close_ma), frequency=30) #time series
decomp = stl(count_ma, s.window="periodic") #seasonal component
deseasonal_cnt <- seasadj(decomp)
plot(decomp)



#fuller test
adf.test(count_ma, alternative = "stationary") #augmented Dickey-Fuller (ADF)


Acf(count_ma, main='')

Pacf(count_ma, main='')


count_d1 = diff(deseasonal_cnt, differences = 1)
plot(count_d1)
adf.test(count_d1, alternative = "stationary")


Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series')

count_d2 = diff(deseasonal_cnt, differences = 2)
plot(count_d2)


adf.test(count_d2, alternative = "stationary")


Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series')


count_d3 = diff(log(deseasonal_cnt),differences = 2)
plot(count_d3)


adf.test(count_d2, alternative = "stationary")


Acf(count_d1, main='ACF for Differenced Series')
Pacf(count_d1, main='PACF for Differenced Series')

auto.arima(deseasonal_cnt, seasonal=FALSE)





fit<-auto.arima(deseasonal_cnt, seasonal=FALSE)
tsdisplay(residuals(fit), lag.max=45, main='(1,1,1) Model Residuals') 


fit2 = arima(deseasonal_cnt, order=c(2,1,7))

fit2

tsdisplay(residuals(fit2), lag.max=15, main='Seasonal Model Residuals')


fcast <- forecast(fit2, h=30)
plot(fcast)


hold <- window(ts(deseasonal_cnt), start=2480)

fit_no_holdout = arima(ts(deseasonal_cnt[-c(2480:2511)]), order=c(2,1,4))

fcast_no_holdout <- forecast(fit_no_holdout,h=31)
plot(fcast_no_holdout, main=" ")
lines(ts(deseasonal_cnt))

fit_w_seasonality = auto.arima(deseasonal_cnt, seasonal=TRUE)
fit_w_seasonality

seas_fcast <- forecast(fit_w_seasonality, h=30)
plot(seas_fcast)

