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

################ for initial part, say that vola of returns differ over time
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

garch_models <- list("sGARCH", "gjrGARCH","eGARCH")

for (garch_model in garch_models) {

  garchspec <- paste0("garchspec_", garch_model)
  garchfit <- paste0("garchfit_", garch_model)
  garchforecast <- paste0("garchforecast_", garch_model)
  
  garchspec_value <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                     variance.model = list(model = garch_model), 
                     distribution.model = "norm")
  
  garchfit_value <- ugarchfit(spec = garchspec_value,data = sp500ret,
                    out.sample = 1000 )
  
  garchforecast_value <- ugarchforecast(fitORspec = garchfit_value,
                         n.ahead = 10)
  
  assign(garchspec, garchspec_value)                  
  assign(garchfit, garchfit_value)
  assign(garchforecast,garchforecast_value)
  
}


#estimated volatilities 
#garchvol <- sigma(garchfit) 
#unconditional volatility
#sqrt(uncvariance(garchfit))








