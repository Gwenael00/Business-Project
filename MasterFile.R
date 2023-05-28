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

garch_models <- list("sGARCH", "gjrGARCH","eGARCH","iGARCH")

#maybe try different parameters for first 5 years, see which model fits best, then apply on remaining 15 years
for (garch_model in garch_models) {

  garchspec <- paste0("garchspec_", garch_model)
  garchfit <- paste0("garchfit_", garch_model)
  garchforecast <- paste0("garchforecast_", garch_model)
  garchroll <- paste0("garchroll_", garch_model)
  
  #model specification
  garchspec_value <- ugarchspec(mean.model = list(armaOrder = c(0,0)), #maybe change armaorder?
                     variance.model = list(model = garch_model), #maybe arma in mean?
                     distribution.model = "norm") #maybe change to sstd?
  
  #rolling backtest
  garchroll_value <- ugarchroll(garchspec_value, data = sp500ret, n.start = 1260,
                                refit.window = "moving", refit.every = 20)  
  
  #in sample
  garchfit_value <- ugarchfit(spec = garchspec_value,data = sp500ret,
                    out.sample = 1000 )
  
  #out of sample forecast
  garchforecast_value <- ugarchforecast(fitORspec = garchfit_value,
                         n.ahead = 100) 
  
  assign(garchspec, garchspec_value)  
  assign(garchroll, garchroll_value)
  assign(garchfit, garchfit_value)
  assign(garchforecast,garchforecast_value)
  
  #evaluate model, note: you can also check models properties by using show(garchfit_garch_model)
  
  #check significance of parameters
  round(garchfit@fit$matcoef,5)
  
  #Information criteria (prefer small values)
  infocriteria(garchfit)
  
  #if we use constant mean garch model we can use Ljung-Box test -> on returns
  
}

#maybe do overlay instead of 4 seperate
par(mfrow=c(2,2)) 
for (garch_model in garch_models) {
  predictions <- as.data.frame(garchroll_sGARCH)
  #get predicted volatilities
  garchvolroll <- xts( predictions$Sigma, order.by = as.Date(rownames(predictions)))
  #insample
  volplot <- plot(sigma(garchfit_sGARCH), col = "darkgrey", lwd = 1.5, main = "In-sample versus rolling vol forecasts")
  # rolling (no lookahead bias)
  volplot <- addSeries(garchvolroll, col = "blue", on = 1)
  volplot <- addSeries(abs(sp500ret), col = "grey")
  plot(volplot)  
}

#we could plot standardized residuals against normaldist to show nonnormality, then redo with skewed studednts t dist
# there are also prebuild QQ plots that show nonnormality, especially in tails  
  


# Analyze RMSE (predicted variance)
# Analyze Information criteria (goodness of fit for distribution)












