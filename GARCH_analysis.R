library(readxl)
library(xts)
library(PerformanceAnalytics)
library(rugarch)
library(lubridate)
library(tseries)

rm(list=ls())
shell("cls")
gc()

input_data = read.csv("/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/istratqwmnw5blgd.csv")
input_data$caldt <- as.Date(ymd(input_data$caldt), "%Y-%m-%d")
input_data = as.xts(input_data)
sp500indx = input_data[,1]
sp500ret = input_data[,2]
sp500ret = log(1+sp500ret) 

##############################################################
###################### sGARCH ################################
##############################################################

m <- 3
n <- 3
S <- 1760
Sample_size <- 1500
Obs <- 2768
coef_mat_sGARCH = matrix(0,20,m*n)
info_mat_sGARCH = matrix(,4,m*n)
rownames(info_mat_sGARCH) <- c("AIC", "BIC","Shibata","Hanna-Quinn")
colnames(info_mat_sGARCH) <- c("1,1","1,2","1,3","2,1","2,2","2,3","3,1","3,2","3,3")
var_mat_sGARCH =matrix(,Obs-S,m*n)
colnames(var_mat_sGARCH) <- c("1,1","1,2","1,3","2,1","2,2","2,3","3,1","3,2","3,3")
rownames(var_mat_sGARCH) <- NULL

realized_ret <- sp500ret[(S+1):Obs]
indic_var_sGARCH = matrix(,Obs-S,m*n)
uncond_f_sGARCH = matrix(,1,m*n)

# Specify a standard GARCH model with constant mean
for (i in 1:m) {
  for (j in 1:n) {
    
    # model specification
    garchspec <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                            variance.model = list(model = "sGARCH", garchOrder = c(i,j)), 
                            distribution.model = "norm")
    
    #in-sample fit with IC
    garchfit <- ugarchfit(spec = garchspec,data = sp500ret, out.sample = (Obs - S), fit.control = list(stationarity = 1))
    # show(garchfit)
     # coef_mat_sGARCH[1:2+i+j,(i-1)*3+j]   <- coef(garchfit)
    info_mat_sGARCH[,(i-1)*3+j] = infocriteria(garchfit)
    
   # rolling OOS prediction
    garch_pred <- ugarchroll(spec=garchspec, data=sp500ret, n.ahead = 1, n.start = S, 
                   refit.every = 22, refit.window = c( "moving"), 
                   window.size = Sample_size, calculate.VaR = TRUE, VaR.alpha = c(0.01, 
                                                                                0.05), keep.coef = TRUE, ) 
    var_mat_sGARCH[,(i-1)*3+j] <-garch_pred@forecast[["VaR"]][["alpha(1%)"]]
    
    write.csv(var_mat_sGARCH,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/var_mat_sGARCH.csv")
 
    indic_var_sGARCH[,(i-1)*3+j] <- ifelse(realized_ret[,1] < var_mat_sGARCH[,(i-1)*3+j],  1, 0)
    
    uncond_f_sGARCH[1,(i-1)*3+j] <- mean(indic_var_sGARCH[,(i-1)*3+j])
    
    report(garch_pred, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)
     }
}
write.csv(uncond_f_sGARCH,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/uncond_cov.csv")


# find uncond & condi coverage through frequency of exceedence
for (i in 1:m) {
  for (j in 1:n) {
   # uncond_f_sGARCH[1,(i-1)*3+j] <- mean(indic_var_sGARCH[,(i-1)*3+j]) 
    print(VaRTest(0.01, as.numeric(realized_ret[,1]), as.numeric(var_mat_sGARCH[,(i-1)*3+j])))
    }}


###################different underlying dists for sGARCH(1,1)###############################

#Set-up:
p <- 1
q <- 1
S <- 1760
Sample_size <- 1500
Obs <- 2768
coef_mat_sGARCH_dist = matrix(0,4,3)
info_mat_sGARCH_dist = matrix(,4,3)
rownames(info_mat_sGARCH_dist) <- c("AIC", "BIC","Shibata","Hanna-Quinn")
colnames(info_mat_sGARCH_dist) <- c("normal","t-dist","GED")
var_mat_sGARCH_dist =matrix(,Obs-S,3)
colnames(var_mat_sGARCH_dist) <- c("normal","t-dist","GED")
rownames(var_mat_sGARCH_dist) <- NULL

realized_ret <- sp500ret[(S+1):Obs]
indic_var_sGARCH_dist = matrix(,Obs-S,3)
uncond_f_sGARCH_dist = matrix(,1,3)

####Loop through models:

    
for (i in c("norm", "std", "ged")) {
  
  garchspec <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                          variance.model = list(model = "sGARCH", garchOrder = c(p,q)), 
                          distribution.model = i)
  garchfit <- ugarchfit(spec = garchspec,data = sp500ret, out.sample = (Obs-S), fit.control = list(stationarity = 1))
  j<- ifelse (i =="norm",1,ifelse(i =="std",2,3))
  info_mat_sGARCH_dist[,j] = infocriteria(garchfit)
  garch_pred <- ugarchroll(spec=garchspec, data=sp500ret, n.ahead = 1, n.start = S, 
                           refit.every = 22, refit.window = c( "moving"), 
                           window.size = Sample_size, calculate.VaR = TRUE, VaR.alpha = c(0.01, 
                                                                                          0.05), keep.coef = TRUE, ) 
  var_mat_sGARCH_dist[,j] <-garch_pred@forecast[["VaR"]][["alpha(1%)"]]
  report(garch_pred, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)
  gc()
  
}
    write.csv(var_mat_sGARCH_dist,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/var_mat_sGARCH_dist.csv")

        
    for (i in 1:3){
    indic_var_sGARCH_dist[,i] <- ifelse(realized_ret[,1] < var_mat_sGARCH_dist[,i],  1, 0)
    
    uncond_f_sGARCH_dist[1,i] <- mean(indic_var_sGARCH_dist[,i])
    
  }

    write.csv(uncond_f_sGARCH_dist,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/uncond_f_sGARCH_dist.csv")


 ######################################################################################################
 ###################different underlying dists for different GARCH models###############################

    p <- 1
    q <- 1
    S <- 1760
    Sample_size <- 1500
    Obs <- 2768
    coef_mat_models_dist = matrix(0,4,3)
    info_mat_models_dist = matrix(,4,3*3)
    rownames(info_mat_models_dist) <- c("AIC", "BIC","Shibata","Hanna-Quinn")
    colnames(info_mat_models_dist) <- c("sGARCH-normal","sGARCH-t-dist","sGARCH-GED","eGARCH-normal","eGARCH-t-dist","eGARCH-GED","gjrGARCH-normal","gjrGARCH-t-dist","gjrGARCH-GED")
    var_mat_models_dist =matrix(,Obs-S,3*3)
    colnames(var_mat_models_dist) <- c("sGARCH-normal","sGARCH-t-dist","sGARCH-GED","eGARCH-normal","eGARCH-t-dist","eGARCH-GED","gjrGARCH-normal","gjrGARCH-t-dist","gjrGARCH-GED")
    rownames(var_mat_models_dist) <- NULL
    
    realized_ret <- sp500ret[(S+1):Obs]
    indic_var_models_dist = matrix(,Obs-S,3*3)
    uncond_f_models_dist = matrix(,3,3)
    colnames(uncond_f_models_dist) <- c("sGARCH", "eGARCH", "gjrGARCH")
    rownames(uncond_f_models_dist) <- c("norm", "std", "ged")
    
   for (pi_model in c("sGARCH", "eGARCH", "gjrGARCH"))   { 
    for (pi_dist in c("norm", "std", "ged")) {
      
      garchspec <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                              variance.model = list(model = pi_model, garchOrder = c(p,q)), 
                              distribution.model = pi_dist)
      garchfit <- ugarchfit(spec = garchspec,data = sp500ret, out.sample = (Obs-S), fit.control = list(stationarity = 1))
      j<- ifelse (pi_model =="sGARCH",1,ifelse(pi_model =="eGARCH",2,3))
      i<- ifelse (pi_dist =="norm",1,ifelse(pi_dist =="std",2,3))
      info_mat_models_dist[,(j-1)*3+i] = infocriteria(garchfit)
      garch_pred <- ugarchroll(spec=garchspec, data=sp500ret, n.ahead = 1, n.start = S, 
                               refit.every = 22, refit.window = c( "moving"), 
                               window.size = Sample_size, calculate.VaR = TRUE, VaR.alpha = c(0.01, 
                                                                                              0.05), keep.coef = TRUE, ) 
      var_mat_models_dist[,(j-1)*3+i] <-garch_pred@forecast[["VaR"]][["alpha(1%)"]]
      report(garch_pred, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)
      gc()
      
    }
   }
    
    for (i in 1:3){
      for (j in 1:3){ 
      indic_var_models_dist[,(j-1)*3+i] <- ifelse(realized_ret[,1] < var_mat_models_dist[,(j-1)*3+i],  1, 0)
      
      uncond_f_models_dist[i,j] <- mean(indic_var_models_dist[,(j-1)*3+i])
    }}
    # suspicious due to identical coverages
    
    write.csv(uncond_f_models_dist,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/uncond_f_models_dist.csv")
    
   
    

# Use the method sigma to retrieve the estimated volatilities 
garchvol <- sigma(garchfit) 

args(ugarchspec)
function (variance.model = list(model = "sGARCH", garchOrder = c(1, 
                                                                    1), submodel = NULL, external.regressors = NULL, variance.targeting = FALSE), 
             mean.model = list(armaOrder = c(1, 1), include.mean = TRUE, 
                               archm = FALSE, archpow = 1, arfima = FALSE, external.regressors = NULL, 
                               archex = FALSE), distribution.model = "norm", start.pars = list(), 
             fixed.pars = list(), ...) 
args(ugarchfit)
function (spec, data, out.sample = 0, solver = "solnp", solver.control = list(), 
          fit.control = list(stationarity = 1, fixed.se = 0, scale = 0, 
                             rec.init = "all", trunclag = 1000), numderiv.control = list(grad.eps = 1e-04, 
                                                                                         grad.d = 1e-04, grad.zero.tol = sqrt(.Machine$double.eps/7e-07), 
                                                                                         hess.eps = 1e-04, hess.d = 0.1, hess.zero.tol = sqrt(.Machine$double.eps/7e-07), 
                                                                                       r = 4, v = 2), ...) 
 
  args(ugarchroll) 

function (spec, data, n.ahead = 1, forecast.length = 500, n.start = NULL, 
          refit.every = 25, refit.window = c("recursive", "moving"), 
          window.size = NULL, solver = "hybrid", fit.control = list(), 
          solver.control = list(), calculate.VaR = TRUE, VaR.alpha = c(0.01, 
                                                                       0.05), cluster = NULL, keep.coef = TRUE, ...) 
  
  
   help(paste0
      )
  help(ugarchfit)
  