
S <- 1760
Sample_size <- 1500
Obs <- 2768
refit_fr <- 200
#coef_mat_models_dist = matrix(0,4,3)
info_mat_models_dist = matrix(,4,135)
rownames(info_mat_models_dist) <- c("AIC", "BIC","Shibata","Hanna-Quinn")
colnames(info_mat_models_dist) <- c("sGARCH(1,1)-normal","sGARCH(1,1)-t-dist","sGARCH(1,1)-GED","eGARCH(1,1)-normal","eGARCH(1,1)-t-dist","eGARCH(1,1)-GED","gjrGARCH(1,1)-normal","gjrGARCH(1,1)-t-dist","gjrGARCH(1,1)-GED","iGARCH(1,1)-normal","iGARCH(1,1)-t-dist","iGARCH(1,1)-GED","sGARCH(1,2)-normal","sGARCH(1,2)-t-dist","sGARCH(1,2)-GED","eGARCH(1,2)-normal","eGARCH(1,2)-t-dist","eGARCH(1,2)-GED","gjrGARCH(1,2)-normal","gjrGARCH(1,2)-t-dist","gjrGARCH(1,2)-GED","iGARCH(1,2)-normal","iGARCH(1,2)-t-dist","iGARCH(1,2)-GED","sGARCH(1,3)-normal","sGARCH(1,3)-t-dist","sGARCH(1,3)-GED","eGARCH(1,3)-normal","eGARCH(1,3)-t-dist","eGARCH(1,3)-GED","gjrGARCH(1,3)-normal","gjrGARCH(1,3)-t-dist","gjrGARCH(1,3)-GED","iGARCH(1,3)-normal","iGARCH(1,3)-t-dist","iGARCH(1,3)-GED","sGARCH(2,1)-normal","sGARCH(2,1)-t-dist","sGARCH(2,1)-GED","eGARCH(2,1)-normal","eGARCH(2,1)-t-dist","eGARCH(2,1)-GED","gjrGARCH(2,1)-normal","gjrGARCH(2,1)-t-dist","gjrGARCH(2,1)-GED","iGARCH(2,1)-normal","iGARCH(2,1)-t-dist","iGARCH(2,1)-GED","sGARCH(2,2)-normal","sGARCH(2,2)-t-dist","sGARCH(2,2)-GED","eGARCH(2,2)-normal","eGARCH(2,2)-t-dist","eGARCH(2,2)-GED","gjrGARCH(2,2)-normal","gjrGARCH(2,2)-t-dist","gjrGARCH(2,2)-GED","iGARCH(2,2)-normal","iGARCH(2,2)-t-dist","iGARCH(2,2)-GED","sGARCH(2,3)-normal","sGARCH(2,3)-t-dist","sGARCH(2,3)-GED","eGARCH(2,3)-normal","eGARCH(2,3)-t-dist","eGARCH(2,3)-GED","gjrGARCH(2,3)-normal","gjrGARCH(2,3)-t-dist","gjrGARCH(2,3)-GED","iGARCH(2,3)-normal","iGARCH(2,3)-t-dist","iGARCH(2,3)-GED","sGARCH(3,1)-normal","sGARCH(3,1)-t-dist","sGARCH(3,1)-GED","eGARCH(3,1)-normal","eGARCH(3,1)-t-dist","eGARCH(3,1)-GED","gjrGARCH(3,1)-normal","gjrGARCH(3,1)-t-dist","gjrGARCH(3,1)-GED","iGARCH(3,1)-normal","iGARCH(3,1)-t-dist","iGARCH(3,1)-GED","sGARCH(3,2)-normal","sGARCH(3,2)-t-dist","sGARCH(3,2)-GED","eGARCH(3,2)-normal","eGARCH(3,2)-t-dist","eGARCH(3,2)-GED","gjrGARCH(3,2)-normal","gjrGARCH(3,2)-t-dist","gjrGARCH(3,2)-GED","iGARCH(3,2)-normal","iGARCH(3,2)-t-dist","iGARCH(3,2)-GED","sGARCH(3,3)-normal","sGARCH(3,3)-t-dist","sGARCH(3,3)-GED","eGARCH(3,3)-normal","eGARCH(3,3)-t-dist","eGARCH(3,3)-GED","gjrGARCH(3,3)-normal","gjrGARCH(3,3)-t-dist","gjrGARCH(3,3)-GED","iGARCH(3,3)-normal","iGARCH(3,3)-t-dist","iGARCH(3,3)-GED","tGARCH(1,1)-normal","tGARCH(1,1)-t-dist","tGARCH(1,1)-GED","tGARCH(1,2)-normal","tGARCH(1,2)-t-dist","tGARCH(1,2)-GED","tGARCH(1,3)-normal","tGARCH(1,3)-t-dist","tGARCH(1,3)-GED","tGARCH(2,1)-normal","tGARCH(2,1)-t-dist","tGARCH(2,1)-GED","tGARCH(2,2)-normal","tGARCH(2,2)-t-dist","tGARCH(2,2)-GED","tGARCH(2,3)-normal","tGARCH(2,3)-t-dist","tGARCH(2,3)-GED","tGARCH(3,1)-normal","tGARCH(3,1)-t-dist","tGARCH(3,1)-GED","tGARCH(3,2)-normal","tGARCH(3,2)-t-dist","tGARCH(3,2)-GED","tGARCH(3,3)-normal","tGARCH(3,3)-t-dist","tGARCH(3,3)-GED")
var_mat_models_dist_1p =matrix(,Obs-S,135)
var_mat_models_dist_5p =matrix(,Obs-S,135)
colnames(var_mat_models_dist_1p) <- c("sGARCH(1,1)-normal","sGARCH(1,1)-t-dist","sGARCH(1,1)-GED","eGARCH(1,1)-normal","eGARCH(1,1)-t-dist","eGARCH(1,1)-GED","gjrGARCH(1,1)-normal","gjrGARCH(1,1)-t-dist","gjrGARCH(1,1)-GED","iGARCH(1,1)-normal","iGARCH(1,1)-t-dist","iGARCH(1,1)-GED","sGARCH(1,2)-normal","sGARCH(1,2)-t-dist","sGARCH(1,2)-GED","eGARCH(1,2)-normal","eGARCH(1,2)-t-dist","eGARCH(1,2)-GED","gjrGARCH(1,2)-normal","gjrGARCH(1,2)-t-dist","gjrGARCH(1,2)-GED","iGARCH(1,2)-normal","iGARCH(1,2)-t-dist","iGARCH(1,2)-GED","sGARCH(1,3)-normal","sGARCH(1,3)-t-dist","sGARCH(1,3)-GED","eGARCH(1,3)-normal","eGARCH(1,3)-t-dist","eGARCH(1,3)-GED","gjrGARCH(1,3)-normal","gjrGARCH(1,3)-t-dist","gjrGARCH(1,3)-GED","iGARCH(1,3)-normal","iGARCH(1,3)-t-dist","iGARCH(1,3)-GED","sGARCH(2,1)-normal","sGARCH(2,1)-t-dist","sGARCH(2,1)-GED","eGARCH(2,1)-normal","eGARCH(2,1)-t-dist","eGARCH(2,1)-GED","gjrGARCH(2,1)-normal","gjrGARCH(2,1)-t-dist","gjrGARCH(2,1)-GED","iGARCH(2,1)-normal","iGARCH(2,1)-t-dist","iGARCH(2,1)-GED","sGARCH(2,2)-normal","sGARCH(2,2)-t-dist","sGARCH(2,2)-GED","eGARCH(2,2)-normal","eGARCH(2,2)-t-dist","eGARCH(2,2)-GED","gjrGARCH(2,2)-normal","gjrGARCH(2,2)-t-dist","gjrGARCH(2,2)-GED","iGARCH(2,2)-normal","iGARCH(2,2)-t-dist","iGARCH(2,2)-GED","sGARCH(2,3)-normal","sGARCH(2,3)-t-dist","sGARCH(2,3)-GED","eGARCH(2,3)-normal","eGARCH(2,3)-t-dist","eGARCH(2,3)-GED","gjrGARCH(2,3)-normal","gjrGARCH(2,3)-t-dist","gjrGARCH(2,3)-GED","iGARCH(2,3)-normal","iGARCH(2,3)-t-dist","iGARCH(2,3)-GED","sGARCH(3,1)-normal","sGARCH(3,1)-t-dist","sGARCH(3,1)-GED","eGARCH(3,1)-normal","eGARCH(3,1)-t-dist","eGARCH(3,1)-GED","gjrGARCH(3,1)-normal","gjrGARCH(3,1)-t-dist","gjrGARCH(3,1)-GED","iGARCH(3,1)-normal","iGARCH(3,1)-t-dist","iGARCH(3,1)-GED","sGARCH(3,2)-normal","sGARCH(3,2)-t-dist","sGARCH(3,2)-GED","eGARCH(3,2)-normal","eGARCH(3,2)-t-dist","eGARCH(3,2)-GED","gjrGARCH(3,2)-normal","gjrGARCH(3,2)-t-dist","gjrGARCH(3,2)-GED","iGARCH(3,2)-normal","iGARCH(3,2)-t-dist","iGARCH(3,2)-GED","sGARCH(3,3)-normal","sGARCH(3,3)-t-dist","sGARCH(3,3)-GED","eGARCH(3,3)-normal","eGARCH(3,3)-t-dist","eGARCH(3,3)-GED","gjrGARCH(3,3)-normal","gjrGARCH(3,3)-t-dist","gjrGARCH(3,3)-GED","iGARCH(3,3)-normal","iGARCH(3,3)-t-dist","iGARCH(3,3)-GED","tGARCH(1,1)-normal","tGARCH(1,1)-t-dist","tGARCH(1,1)-GED","tGARCH(1,2)-normal","tGARCH(1,2)-t-dist","tGARCH(1,2)-GED","tGARCH(1,3)-normal","tGARCH(1,3)-t-dist","tGARCH(1,3)-GED","tGARCH(2,1)-normal","tGARCH(2,1)-t-dist","tGARCH(2,1)-GED","tGARCH(2,2)-normal","tGARCH(2,2)-t-dist","tGARCH(2,2)-GED","tGARCH(2,3)-normal","tGARCH(2,3)-t-dist","tGARCH(2,3)-GED","tGARCH(3,1)-normal","tGARCH(3,1)-t-dist","tGARCH(3,1)-GED","tGARCH(3,2)-normal","tGARCH(3,2)-t-dist","tGARCH(3,2)-GED","tGARCH(3,3)-normal","tGARCH(3,3)-t-dist","tGARCH(3,3)-GED")
rownames(var_mat_models_dist_1p) <- NULL
colnames(var_mat_models_dist_5p) <- c("sGARCH(1,1)-normal","sGARCH(1,1)-t-dist","sGARCH(1,1)-GED","eGARCH(1,1)-normal","eGARCH(1,1)-t-dist","eGARCH(1,1)-GED","gjrGARCH(1,1)-normal","gjrGARCH(1,1)-t-dist","gjrGARCH(1,1)-GED","iGARCH(1,1)-normal","iGARCH(1,1)-t-dist","iGARCH(1,1)-GED","sGARCH(1,2)-normal","sGARCH(1,2)-t-dist","sGARCH(1,2)-GED","eGARCH(1,2)-normal","eGARCH(1,2)-t-dist","eGARCH(1,2)-GED","gjrGARCH(1,2)-normal","gjrGARCH(1,2)-t-dist","gjrGARCH(1,2)-GED","iGARCH(1,2)-normal","iGARCH(1,2)-t-dist","iGARCH(1,2)-GED","sGARCH(1,3)-normal","sGARCH(1,3)-t-dist","sGARCH(1,3)-GED","eGARCH(1,3)-normal","eGARCH(1,3)-t-dist","eGARCH(1,3)-GED","gjrGARCH(1,3)-normal","gjrGARCH(1,3)-t-dist","gjrGARCH(1,3)-GED","iGARCH(1,3)-normal","iGARCH(1,3)-t-dist","iGARCH(1,3)-GED","sGARCH(2,1)-normal","sGARCH(2,1)-t-dist","sGARCH(2,1)-GED","eGARCH(2,1)-normal","eGARCH(2,1)-t-dist","eGARCH(2,1)-GED","gjrGARCH(2,1)-normal","gjrGARCH(2,1)-t-dist","gjrGARCH(2,1)-GED","iGARCH(2,1)-normal","iGARCH(2,1)-t-dist","iGARCH(2,1)-GED","sGARCH(2,2)-normal","sGARCH(2,2)-t-dist","sGARCH(2,2)-GED","eGARCH(2,2)-normal","eGARCH(2,2)-t-dist","eGARCH(2,2)-GED","gjrGARCH(2,2)-normal","gjrGARCH(2,2)-t-dist","gjrGARCH(2,2)-GED","iGARCH(2,2)-normal","iGARCH(2,2)-t-dist","iGARCH(2,2)-GED","sGARCH(2,3)-normal","sGARCH(2,3)-t-dist","sGARCH(2,3)-GED","eGARCH(2,3)-normal","eGARCH(2,3)-t-dist","eGARCH(2,3)-GED","gjrGARCH(2,3)-normal","gjrGARCH(2,3)-t-dist","gjrGARCH(2,3)-GED","iGARCH(2,3)-normal","iGARCH(2,3)-t-dist","iGARCH(2,3)-GED","sGARCH(3,1)-normal","sGARCH(3,1)-t-dist","sGARCH(3,1)-GED","eGARCH(3,1)-normal","eGARCH(3,1)-t-dist","eGARCH(3,1)-GED","gjrGARCH(3,1)-normal","gjrGARCH(3,1)-t-dist","gjrGARCH(3,1)-GED","iGARCH(3,1)-normal","iGARCH(3,1)-t-dist","iGARCH(3,1)-GED","sGARCH(3,2)-normal","sGARCH(3,2)-t-dist","sGARCH(3,2)-GED","eGARCH(3,2)-normal","eGARCH(3,2)-t-dist","eGARCH(3,2)-GED","gjrGARCH(3,2)-normal","gjrGARCH(3,2)-t-dist","gjrGARCH(3,2)-GED","iGARCH(3,2)-normal","iGARCH(3,2)-t-dist","iGARCH(3,2)-GED","sGARCH(3,3)-normal","sGARCH(3,3)-t-dist","sGARCH(3,3)-GED","eGARCH(3,3)-normal","eGARCH(3,3)-t-dist","eGARCH(3,3)-GED","gjrGARCH(3,3)-normal","gjrGARCH(3,3)-t-dist","gjrGARCH(3,3)-GED","iGARCH(3,3)-normal","iGARCH(3,3)-t-dist","iGARCH(3,3)-GED","tGARCH(1,1)-normal","tGARCH(1,1)-t-dist","tGARCH(1,1)-GED","tGARCH(1,2)-normal","tGARCH(1,2)-t-dist","tGARCH(1,2)-GED","tGARCH(1,3)-normal","tGARCH(1,3)-t-dist","tGARCH(1,3)-GED","tGARCH(2,1)-normal","tGARCH(2,1)-t-dist","tGARCH(2,1)-GED","tGARCH(2,2)-normal","tGARCH(2,2)-t-dist","tGARCH(2,2)-GED","tGARCH(2,3)-normal","tGARCH(2,3)-t-dist","tGARCH(2,3)-GED","tGARCH(3,1)-normal","tGARCH(3,1)-t-dist","tGARCH(3,1)-GED","tGARCH(3,2)-normal","tGARCH(3,2)-t-dist","tGARCH(3,2)-GED","tGARCH(3,3)-normal","tGARCH(3,3)-t-dist","tGARCH(3,3)-GED")
rownames(var_mat_models_dist_5p) <- NULL

realized_ret <- sp500ret[(S+1):Obs]
indic_var_models_dist_1p = matrix(,Obs-S,135)
indic_var_models_dist_5p = matrix(,Obs-S,135)
uncond_f_models_dist_1p = matrix(,3,45)
uncond_f_models_dist_5p = matrix(,3,45)
QL_var_models_dist_1p = matrix(,Obs-S,135)
QL_var_models_dist_5p = matrix(,Obs-S,135)
average_QL_models_dist_1p= matrix(,3,45)
average_QL_models_dist_5p= matrix(,3,45)


colnames(average_QL_models_dist_1p) <- c("sGARCH(1,1)","sGARCH(1,2)","sGARCH(1,3)","sGARCH(2,1)","sGARCH(2,2)","sGARCH(2,3)","sGARCH(3,1)","sGARCH(3,2)","sGARCH(3,3)", "eGARCH(1,1)","eGARCH(1,2)","eGARCH(1,3)","eGARCH(2,1)","eGARCH(2,2)","eGARCH(2,3)","eGARCH(3,1)","eGARCH(3,2)","eGARCH(3,3)","gjrGARCH(1,1)","gjrGARCH(1,2)","gjrGARCH(1,3)","gjrGARCH(2,1)","gjrGARCH(2,2)","gjrGARCH(2,3)","gjrGARCH(3,1)","gjrGARCH(3,2)","gjrGARCH(3,3)", "iGARCH(1,1)","iGARCH(1,2)","iGARCH(1,3)","iGARCH(2,1)","iGARCH(2,2)","iGARCH(2,3)","iGARCH(3,1)","iGARCH(3,2)","iGARCH(3,3)","tGARCH(1,1)","tGARCH(1,2)","tGARCH(1,3)","tGARCH(2,1)","tGARCH(2,2)","tGARCH(2,3)","tGARCH(3,1)","tGARCH(3,2)","tGARCH(3,3)")
rownames(average_QL_models_dist_1p) <- c("norm", "std", "ged")
colnames(average_QL_models_dist_5p) <- c("sGARCH(1,1)","sGARCH(1,2)","sGARCH(1,3)","sGARCH(2,1)","sGARCH(2,2)","sGARCH(2,3)","sGARCH(3,1)","sGARCH(3,2)","sGARCH(3,3)", "eGARCH(1,1)","eGARCH(1,2)","eGARCH(1,3)","eGARCH(2,1)","eGARCH(2,2)","eGARCH(2,3)","eGARCH(3,1)","eGARCH(3,2)","eGARCH(3,3)","gjrGARCH(1,1)","gjrGARCH(1,2)","gjrGARCH(1,3)","gjrGARCH(2,1)","gjrGARCH(2,2)","gjrGARCH(2,3)","gjrGARCH(3,1)","gjrGARCH(3,2)","gjrGARCH(3,3)", "iGARCH(1,1)","iGARCH(1,2)","iGARCH(1,3)","iGARCH(2,1)","iGARCH(2,2)","iGARCH(2,3)","iGARCH(3,1)","iGARCH(3,2)","iGARCH(3,3)","tGARCH(1,1)","tGARCH(1,2)","tGARCH(1,3)","tGARCH(2,1)","tGARCH(2,2)","tGARCH(2,3)","tGARCH(3,1)","tGARCH(3,2)","tGARCH(3,3)")
rownames(average_QL_models_dist_5p) <- c("norm", "std", "ged")
colnames(uncond_f_models_dist_1p) <- c("sGARCH(1,1)","sGARCH(1,2)","sGARCH(1,3)","sGARCH(2,1)","sGARCH(2,2)","sGARCH(2,3)","sGARCH(3,1)","sGARCH(3,2)","sGARCH(3,3)", "eGARCH(1,1)","eGARCH(1,2)","eGARCH(1,3)","eGARCH(2,1)","eGARCH(2,2)","eGARCH(2,3)","eGARCH(3,1)","eGARCH(3,2)","eGARCH(3,3)","gjrGARCH(1,1)","gjrGARCH(1,2)","gjrGARCH(1,3)","gjrGARCH(2,1)","gjrGARCH(2,2)","gjrGARCH(2,3)","gjrGARCH(3,1)","gjrGARCH(3,2)","gjrGARCH(3,3)", "iGARCH(1,1)","iGARCH(1,2)","iGARCH(1,3)","iGARCH(2,1)","iGARCH(2,2)","iGARCH(2,3)","iGARCH(3,1)","iGARCH(3,2)","iGARCH(3,3)","tGARCH(1,1)","tGARCH(1,2)","tGARCH(1,3)","tGARCH(2,1)","tGARCH(2,2)","tGARCH(2,3)","tGARCH(3,1)","tGARCH(3,2)","tGARCH(3,3)")
rownames(uncond_f_models_dist_1p) <- c("norm", "std", "ged")
colnames(uncond_f_models_dist_5p) <- c("sGARCH(1,1)","sGARCH(1,2)","sGARCH(1,3)","sGARCH(2,1)","sGARCH(2,2)","sGARCH(2,3)","sGARCH(3,1)","sGARCH(3,2)","sGARCH(3,3)", "eGARCH(1,1)","eGARCH(1,2)","eGARCH(1,3)","eGARCH(2,1)","eGARCH(2,2)","eGARCH(2,3)","eGARCH(3,1)","eGARCH(3,2)","eGARCH(3,3)","gjrGARCH(1,1)","gjrGARCH(1,2)","gjrGARCH(1,3)","gjrGARCH(2,1)","gjrGARCH(2,2)","gjrGARCH(2,3)","gjrGARCH(3,1)","gjrGARCH(3,2)","gjrGARCH(3,3)", "iGARCH(1,1)","iGARCH(1,2)","iGARCH(1,3)","iGARCH(2,1)","iGARCH(2,2)","iGARCH(2,3)","iGARCH(3,1)","iGARCH(3,2)","iGARCH(3,3)","tGARCH(1,1)","tGARCH(1,2)","tGARCH(1,3)","tGARCH(2,1)","tGARCH(2,2)","tGARCH(2,3)","tGARCH(3,1)","tGARCH(3,2)","tGARCH(3,3)")
rownames(uncond_f_models_dist_5p) <- c("norm", "std", "ged")



for (pi_model in c("sGARCH", "eGARCH", "gjrGARCH","iGARCH"))   { 
  for (pi_dist in c("norm", "std", "ged")) {
    for (p in 1:3) {
      for (q in 1:3) {
    
    garchspec <- ugarchspec(mean.model = list(armaOrder = c(0,0)),
                            variance.model = list(model = pi_model, garchOrder = c(p,q)), 
                            distribution.model = pi_dist)
    garchfit <- ugarchfit(spec = garchspec,data = sp500ret, out.sample = (Obs-S), fit.control = list(stationarity = 1))
    j<- ifelse (pi_model =="sGARCH",1,ifelse(pi_model =="eGARCH",2,ifelse(pi_model =="gjrGARCH",3,4)))
    i<- ifelse (pi_dist =="norm",1,ifelse(pi_dist =="std",2,3))
    info_mat_models_dist[,(p-1)*36+(q-1)*12+(j-1)*3+i] = infocriteria(garchfit)
    garch_pred <- ugarchroll(spec=garchspec, data=sp500ret, n.ahead = 1, n.start = S, 
                             refit.every = refit_fr, refit.window = c( "moving"), 
                             window.size = Sample_size, calculate.VaR = TRUE, VaR.alpha = c(0.01, 
                                                                                            0.05), keep.coef = TRUE ) 
    var_mat_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <-garch_pred@forecast[["VaR"]][["alpha(1%)"]]
    var_mat_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <-garch_pred@forecast[["VaR"]][["alpha(5%)"]]
    # reports for conditional & unconditional coverage  
    report(garch_pred, type = "VaR", VaR.alpha = 0.01, conf.level = 0.99)
    report(garch_pred, type = "VaR", VaR.alpha = 0.05, conf.level = 0.95)
    gc()
      }} 
  }
}


for (j in 1:4){ #model
 for (i in 1:3){ #distribution
    for (p in 1:3) { #order
      for (q in 1:3) { #order
  
      
    #manual calc unconditional coverage
    indic_var_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <- ifelse(realized_ret[,1] < var_mat_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i],  1, 0)
    uncond_f_models_dist_1p[i,(j-1)*9+(p-1)*3+q] <- mean(indic_var_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i])
    
    indic_var_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <- ifelse(realized_ret[,1] < var_mat_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i],  1, 0)
    uncond_f_models_dist_5p[i,(j-1)*9+(p-1)*3+q] <- mean(indic_var_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i])
    
    
    #graphs - doesn't work yet
    par(mfrow=c(2,1)) 
    plot_VaR <- chart.TimeSeries(R = realized_ret["2012::2022"], type="p", col = "black",main="VaR exceedances")
    rownames(var_mat_models_dist_1p) <- rownames(realized_ret)
    plot_VaR <- addSeries(var_mat_models_dist_1p[,1], color = ifelse(indic_var_models_dist_1p[i,1]==1,"red","grey"), on = 1)
    plot_VaR
    
    #Quadratic loss function see Orhan & Köksal
    QL_var_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <- ifelse(realized_ret[,1] < var_mat_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i],  1+(realized_ret[,1]-var_mat_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i])^2, 0)
    average_QL_models_dist_1p[i,(j-1)*9+(p-1)*3+q] <- mean(QL_var_models_dist_1p[,(p-1)*36+(q-1)*12+(j-1)*3+i])
    
    QL_var_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i] <- ifelse(realized_ret[,1] < var_mat_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i],  1+(realized_ret[,1]-var_mat_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i])^2, 0)
    average_QL_models_dist_5p[i,(j-1)*9+(p-1)*3+q] <- mean(QL_var_models_dist_5p[,(p-1)*36+(q-1)*12+(j-1)*3+i])
    
  }}}}
warnings()


write.csv(uncond_f_models_dist_1p,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/uncond_f_models_dist_1p.csv")
write.csv(uncond_f_models_dist_5p,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/uncond_f_models_dist_5p.csv")
write.csv(average_QL_models_dist_1p,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/average_QL_models_dist_1p.csv")
write.csv(average_QL_models_dist_5p,"/Users/benita/Documents/Benita/Uni/CBS/Semester 2/Business Project/R/average_QL_models_dist_5p.csv")
