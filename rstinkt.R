library(readxl)
library(xts)
library(PerformanceAnalytics)
library(rugarch)
library(lubridate)
#citation("rugarch")


###################################################
############## Part 1 #############################
###################################################
#get return data

#import S&P500 data
#df = read_xls("D:/Master/SS23/Business Project/SP500.xls")
input_data = read.csv(url("https://github.com/Gwenael00/Business-Project/blob/main/qsidefvvgiaieddt.csv"))
input_data$caldt <- as.Date(ymd(input_data$caldt), "%Y-%m-%d")
input_data = as.xts(input_data)
sp500indx = input_data[,1]
sp500ret = input_data[,2]


###################################################
############## Part 2 #############################
###################################################
#why would you we use GARCH models

################ for initial part, says that vola of returns differ over time
par(mfrow=c(1,2))
plot(sp500indx)
plot(sp500ret)

#confirmed by data if we look at rolling vola
par(mfrow=c(2,1)) 
# Compute the rolling 1 month estimate of annualized volatility
chart.RollingPerformance(R = sp500ret["2000::2020"], width = 22,
                         FUN = "sd.annualized", scale = 252, main = "1m rolling volay")

# Compute the rolling 3 months estimate of annualized volatility
chart.RollingPerformance(R = sp500ret["2000::2020"], width = 66,
                         FUN = "sd.annualized", scale = 252, main = "3m rolling vola")

###################################################
############## Part 3 #############################
###################################################

#GARCH
# Specify a standard GARCH model with constant mean
garchspec <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                        variance.model = list(model = "sGARCH"), 
                        distribution.model = "norm")

# Estimate the model
garchfit <- ugarchfit(spec = garchspec,data = sp500ret, out.sample = 1000 )
show(garchfit)

# Use the method sigma to retrieve the estimated volatilities 
garchvol <- sigma(garchfit) 

# Plot the volatility for 2017
plot(garchvol["2015"])

# Compute unconditional volatility
sqrt(uncvariance(garchfit))

# Print last 10 ones in garchvol
tail(garchvol, 10)

# Forecast volatility 5 days ahead and add 
garchforecast <- ugarchforecast(fitORspec = garchfit, 
                                n.ahead = 5)








