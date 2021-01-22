rm(list=ls())
graphics.off()
library(minpack.lm)
library(ggplot2)
library(reshape2)
library(grid)

print("Data processing...")
data = read.csv("../data/ThermRespData.csv")
# Store all possible relevant information in a new data frame
cData = data.frame(data$ID,data$StandardisedTraitName, data$OriginalTraitValue, data$OriginalTraitUnit,data$Consumer, data$Habitat, data$Location, data$ConStage, data$ConTemp)
names(cData) = c("ID", "trait_name", "trait_value", "trait_unit","consumer", "habitat", "location", "stage", "temp")
cData = cData[-which(cData$trait_value < 0),] # Getting rid of negative trait values
cData$temp = as.numeric(cData$temp)
cData$trait_name[cData$trait_name == "gross photosynthesis rate" | cData$trait_name == "net photosynthesis rate"] = "photosynthesis rate"
print("Done!")
#write.csv(cData, "../results/cData.csv", row.names = F)

#############Fitting linear models##############
print("Fitting the linear models...") 
lm2_model_fitting = data.frame()
lm3_model_fitting = data.frame()
x = c()

for(i in unique(cData$ID)){
  datai = subset(cData, cData$ID== i) #Data subset for iteration
  if(nrow(datai) >= 5) x = c(x, i) # ID with more than 5 data points
  #Fitting the quadratic
  plm2 = try(lm(trait_value ~poly(temp,2), data = datai), silent = T) #Fitting the quadratic model
  if(class(plm2) != "try-error"){
    summ = summary(plm2)
    RSS_i = sum(residuals(plm2)^2) # Residual sum of squares
    n = nrow(datai) # sample size
    p_i = length(coef(plm2)) # Number of parameters
    AICc_i = n+2+n*log((2*pi)/n)+n*log(RSS_i) + 2*p_i*(n/(n-p_i-1))
    dataframe = data.frame( #Outputing the model fitting dataframe
      ID = i, consumer = unique(datai$consumer), trait_name = unique(datai$trait_name),
      r2 = summ$r.squared, a = summ$coefficients[2], b = summ$coefficients[3], intercept = summ$coefficients[1],
      AIC = AIC(plm2), AICc = AICc_i, BIC = BIC(plm2),
      habitat = unique(datai$habitat), location = unique(datai$location), stage = unique(datai$stage)
    )
    lm2_model_fitting = rbind(lm2_model_fitting, dataframe) #Combining dataframe
  }
  #Fitting the cubic
  plm3 = try(lm(trait_value ~poly(temp,3),data = datai), silent = T) #Fitting the cubic model
  if(class(plm3) != "try-error"){
    summ = summary(plm3)
    RSS_i = sum(residuals(plm3)) # Residual sum of squares
    n = nrow(datai) # sample size
    p_i = length(coef(plm3)) # Number of parameters
    AICc_i = n+2+n*log((2*pi)/n)+n*log(RSS_i) + 2*p_i*(n/(n-p_i-1))
    dataframe = data.frame( #Outputing the model fitting dataframe
      ID = i, consumer = unique(datai$consumer), trait_name = unique(datai$trait_name),
      r2 = summ$r.squared, a = summ$coefficients[2], b = summ$coefficients[3], c = summ$coefficients[4], intercept = summ$coefficients[1],
      AIC = AIC(plm3), AICc = AICc_i, BIC = BIC(plm3),
      habitat = unique(datai$habitat), location = unique(datai$location), stage = unique(datai$stage))
    lm3_model_fitting = rbind(lm3_model_fitting, dataframe) #Combining dataframe
  }
#  print(i) # The progress bar~~
}
print("Done!")
# count how many fitting curves have r2>0.9
# sum(lm2_model_fitting$r2>0.9)/length(unique(data$ID))
# sum(lm3_model_fitting$r2>0.9)/length(unique(data$ID))
# length(x)/length(unique(data$ID)) #How many datasets have more than 5 points

# #Exporting csv
# write.csv(lm2_model_fitting, "../results/quadratic.csv", row.names = F)
# write.csv(lm3_model_fitting, "../results/cubic.csv", row.names = F)
# #importing the csv
# lm2_model_fitting = read.csv("../results/quadratic.csv", header = T)
# lm3_model_fitting = read.csv("../results/cubic.csv", header = T)


############Fitting Briere model#########################
## Define Briere model
Briere = function(Temp, T0, Tm, B0){
  return(B0*Temp*(Temp-T0)*(abs(Tm-Temp))^0.5)*as.numeric(T<Tm)*as.numeric(T>T0)
}

print("Fitting the Briere model...") 
Briere_model_fitting = as.data.frame(matrix(NaN, nr=90300, nc=13)) # Creating an empty data frame for filling in
#system.time(
  for(i in unique(cData$ID)){
    datai = subset(cData, cData$ID==i) #Data subset for iteration
    T0_start = min(datai$temp)
    Tm_start = max(datai$temp)
    # Calculate a mean value for B0 start distribution  
    B0_est = datai$trait_value/(datai$temp*(datai$temp - T0_start)*(Tm_start - datai$temp)^0.5)
    B0_est = B0_est[!is.nan(B0_est)]
    B0_start_est = mean(B0_est[B0_est != Inf])
    set.seed(1234) #Saving random number generation pattern
    # Get a reasonable normal distribution range for different power of B0 start
    B0_start_range = rnorm(100, mean = B0_start_est, sd = abs(B0_start_est))
    # Start to sample and fit through B0 starting value range
    for(n in 1:100){
      non_linear = try(nlsLM(trait_value~Briere(Temp = temp, T0, Tm, B0), datai,
                             list(T0 =T0_start, Tm = Tm_start, B0 = B0_start_range[n]),
                             upper = c(40,100,Inf), lower = c(-80,0,-Inf),
                             control = list(maxiter = 500)), silent = T) # Fitting nlm Briere model
      if(class(non_linear) != "try-error" && non_linear$convInfo[2]<500){ #if no error detected and didnt exceed maxiter
        summ = summary(non_linear)
        res = datai$trait_value - Briere(Temp = datai$temp, T0 = summ$coefficients[1], Tm = summ$coefficients[2], B0 = summ$coefficients[3])
        RSS_i = sum(res^2)
        n_i= nrow(datai)
        p_i = length(coef(non_linear))
        AICc_i = n_i+2+n_i*log((2*pi)/n_i)+n_i*log(RSS_i) + 2*p_i*(n_i/(n_i-p_i-1))
        Briere_model_fitting[(i-1)*100+n,] = c(as.numeric(i), unique(datai$consumer), 
                                               unique(datai$trait_name),
                                               B0_start_range[n],
                                               summ$coefficients[1], summ$coefficients[2],summ$coefficients[3],
                                               AIC(non_linear), BIC(non_linear),AICc_i, 
                                               unique(datai$habitat), unique(datai$location), unique(datai$stage))
      }
    }
#    print(i) # The progress bar~~
    if(i == 225) print("progress: 25%")
    if(i == 451) print("progress: 50%")
    if(i == 675) print("progress: 75%")
    if(i == 903) print("Done!")
  }
#)
colnames(Briere_model_fitting) = c('ID', 'consumer', 'trait_name', 'B0start', 'T0', 'Tm', 'B0', 'AIC', 'BIC', 'AICc', 'habitat', 'location', 'stage')
Briere_model_fitting$ID = as.numeric(Briere_model_fitting$ID)
Briere_model_fitting$T0 = as.numeric(Briere_model_fitting$T0)
Briere_model_fitting$Tm = as.numeric(Briere_model_fitting$Tm)
Briere_model_fitting$B0 = as.numeric(Briere_model_fitting$B0)
Briere_model_fitting$AIC = as.numeric(Briere_model_fitting$AIC)
Briere_model_fitting$BIC = as.numeric(Briere_model_fitting$BIC)
Briere_model_fitting$AICc = as.numeric(Briere_model_fitting$AICc)

# #Output csv
# write.csv(Briere_model_fitting, "../results/Briere_model_fitting_FullResult.csv", row.names = F)
# #Import csv
# Briere_model_fitting = read.csv("../results/Briere_model_fitting_FullResult.csv", header =T)
print("Selecting Briere fits...")
Briere_AIC = data.frame() #Select on AIC
for(i in unique(Briere_model_fitting$ID)){
  x = Briere_model_fitting[Briere_model_fitting$ID == i,][which.min(Briere_model_fitting$AIC[Briere_model_fitting$ID == i]),]
  Briere_AIC = rbind(Briere_AIC,x)
}
Briere_BIC = data.frame() #Select on BIC
for(i in unique(Briere_model_fitting$ID)){
  x = Briere_model_fitting[Briere_model_fitting$ID == i,][which.min(Briere_model_fitting$BIC[Briere_model_fitting$ID == i]),]
  Briere_BIC = rbind(Briere_BIC,x)
}
print("Done!")

###########Fitting Schoolfield model###################
## Defining Schoolfield model function
Schoolfield = function(tran_kT, lnB0, Th, Ea, Eh){
  return(lnB0+(tran_kT+1/(283.15*k))*Ea-log(1+exp((1/(Th*k)+tran_kT)*Eh)))
}

## Fitting lnB ~ -1/k*(1/T-1/283.15) as linear model (Arrhenius)
## intercept = lnB0, slope = Ea 
k = 8.61*10^(-5)
# Creating a new data frame for school field model fitting
sch_cData = cData
sch_cData$lnB = log(sch_cData$trait_value)
sch_cData$temp = sch_cData$temp+273.15
sch_cData$tran_kT = -1/(k*sch_cData$temp)
sch_cData$tran_kTT = sch_cData$tran_kT+1/(283.15*k)
sch_cData = sch_cData[-which(sch_cData$lnB == -Inf),]

# write.csv(sch_cData, "../results/sch_cData.csv", row.names = F)
print("Getting start values for Schoolfield model...")
# Fitting Arrhenius, dividing all data with before and after deactivation;
# get estimation values(possible starting values) on A0(B0) and Ea
ID = c(); consumer = c(); stage= c(); trait_name = c(); Th = c(); lnA0 = c(); Ea = c(); Eh = c(); 
r2_befdeact = c(); r2_deact = c(); before = c(); after = c(); n = 0

for(i in unique(sch_cData$ID)){
  datai = sch_cData[sch_cData$ID == i,] # Data subset for iteration
  if(nrow(datai) > 3){
    #get the data to fit
    T_lnB_max = datai$temp[datai$lnB == max(datai$lnB)] # Deactivation temperature
    datai_befdeact = subset(datai, temp <= T_lnB_max) # Data before deactivation
    datai_deact = subset(datai, temp >= T_lnB_max) # Data after deactivation
    temph = max(datai_befdeact$temp) 
    if(nrow(datai_befdeact)>1){ # At least two data points to fit a linear
      lm_sch_befdeact = lm(lnB~tran_kTT, data = datai_befdeact)
      summ_befdeact = summary(lm_sch_befdeact)
      lnA0 = c(lnA0, summ_befdeact$coefficients[1])
      Ea_value = summ_befdeact$coefficients[2]
      r2_befdeact = c(r2_befdeact, round(summ_befdeact$r.squared, digits = 4))
    }else{ # Give an estimation if only one point
      lnA0 = c(lnA0, max(datai$lnB))
      Ea_value = 0.5
      r2_befdeact = c(r2_befdeact,NaN)
      before = c(before, i)}
    Ea = c(Ea, Ea_value)
    if(nrow(datai_deact)>1){ # At least two data points to fit a linear
      n = n+1 #How many have a deactivation point?
      lm_sch_deact = lm(lnB~tran_kTT, data = datai_deact)
      summ_deact = summary(lm_sch_deact)
      Eh = c(Eh, -summ_deact$coefficients[2])
      r2_deact = c(r2_deact, round(summ_deact$r.squared, digits = 4))
    }else{ # Give an estimation if only one point
      Eh = c(Eh,4*Ea_value)
      r2_deact = c(r2_deact,NaN)
      after = c(after, i)}
    ID = c(ID, i)
    consumer = c(consumer, unique(datai$consumer))
    stage = c(stage, unique(datai$stage))
    trait_name = c(trait_name, unique(datai$trait_name))
    Th = c(Th, temph)
  }
}
Arrhenius = data.frame(ID, consumer, stage, trait_name, Th, lnA0, Ea, Eh,r2_befdeact, r2_deact)
# n/nrow(Arrhenius)

# #Output csv
# write.csv(Arrhenius, "../results/Arrhenius.csv", row.names = F)
# #import csv
# Arrhenius = read.csv("../results/Arrhenius.csv", header = T)

print("Fitting Schoolfield model...") # with mean start values calculated using Arrhenius
School_fit = data.frame()
#system.time(
for(i in Arrhenius$ID){
  Adatai = subset(Arrhenius, Arrhenius$ID == i) # Data subset for iteration(start values)
  datai = subset(sch_cData, ID ==i) # Data subset for iteration
  lnB0_get = Adatai$lnA0
  Th_get = Adatai$Th
  Ea_get = Adatai$Ea
  Eh_get = Adatai$Eh
  # Start range
  set.seed(1234) # Saving random number generation pattern
  # Get reasonable normal distribution range for different power of everything
  lnB0_range = rnorm(100,mean = lnB0_get, sd = 5)
  Th_range = rnorm(100, mean = Th_get, sd = 100)
  Ea_range = rnorm(100, mean = Ea_get, sd = 10)
  Eh_range = rnorm(100, mean = Eh_get, sd = abs(Eh_get))
  for(n in 1:100){
    lnB0_start = sample(lnB0_range,1); Th_start = sample(Th_range,1)
    Ea_start = sample(Ea_range,1); Eh_start = sample(Eh_range,1)
    School_model = try(nlsLM(lnB~Schoolfield(tran_kT = tran_kT, lnB0, Th, Ea, Eh),subset(sch_cData, ID ==i), 
                             list(lnB0 = lnB0_start, Th = Th_start, Ea= Ea_start, Eh = Eh_start),
                             upper = c(Inf, 333, 2, 5), lower = c(-Inf, 273, 0, 0), 
                             control = list(maxiter = 500)), silent = T)
    if(class(School_model) != "try-error"){
      if(School_model$convInfo[2]<500){
        summ = summary(School_model)
        # Manual calculation of R square and AIC values given the model was logged before fitting
        res = datai$trait_value - exp(Schoolfield(tran_kT = datai$tran_kT, summ$coefficients[1],
                                                  summ$coefficients[2], summ$coefficients[3], summ$coefficients[4])) # Residual
        RSS_i = sum(res^2) # Residual sum of squares
        TSS_i = sum((datai$trait_value - mean(datai$trait_value))^2) # Total sum of squares
        Rsq_i = 1 - (RSS_i/TSS_i) # R squared
        n = nrow(datai) # sample size
        p_i = length(coef(School_model)) # Number of parameters
        AIC_i = n+2+n*log((2*pi)/n)+n*log(RSS_i) + 2*p_i
        AICc_i = n+2+n*log((2*pi)/n)+n*log(RSS_i) + 2*p_i*(n/(n-p_i-1))
        BIC_i = n+2+n*log((2*pi)/n)+n*log(RSS_i) + p_i* log(n)
        dataframe = data.frame(
          ID = i,
          lnB0_start = lnB0_start, Th_start = Th_start,
          Ea_start = Ea_start, Eh_start = Eh_start,
          lnB0 = summ$coefficients[1], Th = summ$coefficients[2],
          Ea = summ$coefficients[3], Eh = summ$coefficients[4],
          r2 = Rsq_i, AIC = AIC_i, AICc = AICc_i, BIC = BIC_i, 
          trait_name = Adatai$trait_name, consumer = Adatai$consumer, 
          habitat = unique(datai$habitat), stage = unique(datai$stage)
        )
        School_fit = rbind(School_fit, dataframe)
      }
    }
  }
#  print(i) # The progress bar~
  if(i == 226) print("progress: 25%")
  if(i == 453) print("progress: 50%")
  if(i == 675) print("progress: 75%")
  if(i == 903) print("Done!")
}#)
# #Output csv
# write.csv(School_fit, "../results/School_fit.csv", row.names = F)
# #Import csv
# School_fit = read.csv("../results/School_fit.csv", header =T)

print("Selecting Schoolfield fits...")
School_fit_AIC = data.frame() # Selecting the best AIC fitting for each sample ID
for(i in unique(School_fit$ID)){
  x = School_fit[School_fit$ID == i,][which.min(School_fit$AIC[School_fit$ID == i]),]
  School_fit_AIC = rbind(School_fit_AIC,x)
}
School_fit_BIC = data.frame() # Selecting the best BIC fitting for each sample ID
for(i in unique(School_fit$ID)){
  x = School_fit[School_fit$ID == i,][which.min(School_fit$BIC[School_fit$ID == i]),]
  School_fit_BIC = rbind(School_fit_BIC,x)
}
print("Done!")
###########Plotting Everything################
# pdf("../results/2+3+b+s_plots_AIC.pdf")
# for(i in unique(cData$ID)){
#   datai = subset(cData, cData$ID == i) # Data subset for iteration
#   t_max = max(datai$temp)
#   t_min = min(datai$temp)
#   t_points = seq(t_min, t_max, 0.1)
#   plot(datai$temp, datai$trait_value, xlab = "Temperature(celsius)", ylab = c(unique(datai$trait_name), unique(datai$trait_unit)), ylim = c(0.95*min(datai$trait_value),1.1*max(datai$trait_value)))
#   plm2 = try(lm(trait_value ~poly(temp,2), data = datai), silent = T)
#   if(class(plm2) != "try-error"){
#     plm2_pre = predict(plm2, newdata = list(temp = t_points))
#     lines(t_points, plm2_pre, col = 2)}
#   plm3 = try(lm(trait_value ~poly(temp,3), data = datai), silent = T)
#   if(class(plm3) != "try-error"){
#     plm3_pre = predict(plm3, newdata = list(temp = t_points))
#     lines(t_points, plm3_pre, col = 3)}
#   Bdatai = subset(Briere_AIC, Briere_AIC$ID == i)
#   nlm_pre = Bdatai$B0*t_points*(t_points-Bdatai$T0)*(Bdatai$Tm-t_points)^0.5
#   try(lines(t_points, nlm_pre, col = 4), silent = T)
#   datas = subset(sch_cData, sch_cData$ID == i) # Data subset for iteration(Schoolfield)
#   dataA = subset(School_fit_AIC, School_fit_AIC$ID ==i) # Data subset for starting values
#   tran_kT = -1/(k*(t_points+273.15))
#   nlm_pre_school = exp(dataA$lnB0+(tran_kT+1/(283.15*k))*dataA$Ea)/(1+exp((1/(dataA$Th*k)+tran_kT)*dataA$Eh))
#   try(lines(t_points, nlm_pre_school, col = 7), silent = T)
#   legend("topleft", legend = c("quadratic","cubic", "Briere", "Schoolfield"), lwd = 2, col = c(2:4, 7))
#   text(max(datai$temp), 1.1*max(datai$trait_value), i, pos = c(1,2))
#   print(i) # The progress bar~~
# }
# graphics.off()

##############Comparing models based on AIC values############
print("Comparing and selecting using AIC & BIC...")
Compare_AIC = as.data.frame(matrix(NaN, nr=903, nc=5))
for(i in 1:903){
  Compare_AIC[i,1] = i
  if(any(lm2_model_fitting$ID == i,na.rm = T)) Compare_AIC[i, 2] = lm2_model_fitting$AIC[lm2_model_fitting$ID == i]
  if(any(lm3_model_fitting$ID == i,na.rm = T)) Compare_AIC[i, 3] = lm3_model_fitting$AIC[lm3_model_fitting$ID == i]
  if(any(Briere_AIC$ID == i, na.rm = T)) Compare_AIC[i, 4] = Briere_AIC$AIC[Briere_AIC$ID == i]
  if(any(School_fit_AIC$ID == i, na.rm = T)) Compare_AIC[i, 5] = School_fit_AIC$AIC[School_fit_AIC$ID == i]
}
colnames(Compare_AIC) = c("ID", "quadratic", "cubic", "Briere", "Schoolfield")
Compare_AIC = Compare_AIC[-which(is.na(Compare_AIC$quadratic)),]

q = c(); c = c(); b = c(); s = c(); minimum = c()
for(i in 1:length(Compare_AIC$ID)){
  submin = subset(Compare_AIC[i,])
  min = min(as.numeric(submin[,2:5]), na.rm = T)
  minimum = c(minimum,min)
  if(!is.na(as.numeric(submin$quadratic)-min) & as.numeric(submin$quadratic)-min<= 2) q = c(q,1) else q = c(q,0)
  if(!is.na(as.numeric(submin$cubic)) & !is.na(as.numeric(submin$cubic)-min) & as.numeric(submin$cubic)-min <= 2) c = c(c,1) else c = c(c,0)
  if(!is.na(as.numeric(submin$Briere)) & !is.na(as.numeric(submin$Briere)-min) & as.numeric(submin$Briere)-min <= 2) b = c(b,1) else b = c(b,0)
  if(!is.na(as.numeric(submin$Schoolfield)) & !is.na(as.numeric(submin$Schoolfield)-min) & as.numeric(submin$Schoolfield)-min<= 2) s = c(s,1) else s = c(s,0)
}

Compare_AIC = cbind(Compare_AIC, minimum, q,c,b,s)
# sum(Compare_AIC$q); sum(Compare_AIC$c); sum(Compare_AIC$b); sum(Compare_AIC$s)
Best_fit = colnames(Compare_AIC[,2:5])[apply(Compare_AIC[,2:5], 1, function(x) which(as.numeric(x) == min(as.numeric(x), na.rm = T)))]
Compare_AIC = cbind(Compare_AIC, Best_fit, lm2_model_fitting[,c(2:3, 8:10)])
# nrow(Compare_AIC[Compare_AIC$cubic - Compare_AIC$Schoolfield < -2,])/nrow(Compare_AIC)
# #Export csv
# write.csv(Compare_AIC, "../results/Compare_AIC.csv", row.names = F)
# #Import csv
# Compare_AIC = read.csv("../results/Compare_AIC.csv", header = T)

##############Comparing models based on BIC values############
Compare_BIC = as.data.frame(matrix(NaN, nr=903, nc=5))
for(i in 1:903){
  Compare_BIC[i,1] = i
  if(any(lm2_model_fitting$ID == i,na.rm = T)) Compare_BIC[i, 2] = lm2_model_fitting$BIC[lm2_model_fitting$ID == i]
  if(any(lm3_model_fitting$ID == i,na.rm = T)) Compare_BIC[i, 3] = lm3_model_fitting$BIC[lm3_model_fitting$ID == i]
  if(any(Briere_BIC$ID == i, na.rm = T)) Compare_BIC[i, 4] = Briere_BIC$BIC[Briere_BIC$ID == i]
  if(any(School_fit_BIC$ID == i, na.rm = T)) Compare_BIC[i, 5] = School_fit_BIC$BIC[School_fit_BIC$ID == i]
}
colnames(Compare_BIC) = c("ID", "quadratic", "cubic", "Briere", "Schoolfield")
Compare_BIC = Compare_BIC[-which(is.na(Compare_BIC$quadratic)),]

q = c(); c = c(); b = c(); s = c(); minimum = c()
for(i in 1:length(Compare_BIC$ID)){
  submin = subset(Compare_BIC[i,])
  min = min(as.numeric(submin[,2:5]), na.rm = T)
  minimum = c(minimum,min)
  if(!is.na(as.numeric(submin$quadratic)-min) & as.numeric(submin$quadratic)-min<= 2) q = c(q,1) else q = c(q,0)
  if(!is.na(as.numeric(submin$cubic)) & !is.na(as.numeric(submin$cubic)-min) & as.numeric(submin$cubic)-min <= 2) c = c(c,1) else c = c(c,0)
  if(!is.na(as.numeric(submin$Briere)) & !is.na(as.numeric(submin$Briere)-min) & as.numeric(submin$Briere)-min <= 2) b = c(b,1) else b = c(b,0)
  if(!is.na(as.numeric(submin$Schoolfield)) & !is.na(as.numeric(submin$Schoolfield)-min) & as.numeric(submin$Schoolfield)-min<= 2) s = c(s,1) else s = c(s,0)
}

Compare_BIC = cbind(Compare_BIC, minimum, q,c,b,s)
# sum(Compare_BIC$q); sum(Compare_BIC$c); sum(Compare_BIC$b); sum(Compare_BIC$s)
Best_fit = colnames(Compare_BIC[,2:5])[apply(Compare_BIC[,2:5], 1, function(x) which(as.numeric(x) == min(as.numeric(x), na.rm = T)))]
Compare_BIC = cbind(Compare_BIC, Best_fit, lm2_model_fitting[,c(2:3, 8:10)])
bar_AIC = cbind(quadratic = sum(Compare_AIC$q)/nrow(Compare_AIC),
            cubic = sum(Compare_AIC$c)/nrow(Compare_AIC),
            Briere = sum(Compare_AIC$b)/nrow(Compare_AIC),
            Schoolfield = sum(Compare_AIC$s)/nrow(Compare_AIC))
bar_BIC = cbind(quadratic = sum(Compare_BIC$q)/nrow(Compare_BIC),
                cubic = sum(Compare_BIC$c)/nrow(Compare_BIC),
                Briere = sum(Compare_BIC$b)/nrow(Compare_BIC),
                Schoolfield = sum(Compare_BIC$s)/nrow(Compare_BIC))

pdf("../results/bestfit.pdf", width = 9, height = 5)
par(mfrow = c(1,2))
barplot(bar_AIC, xlab = "Model type", ylab = "Percentage of best fit (AIC)", ylim = c(0,0.6))
barplot(bar_BIC, xlab = "Model type", ylab = "Percentage of best fit (BIC)", ylim = c(0,0.6))
graphics.off()

photosynthesis_rate = subset(Compare_BIC, Compare_BIC$trait_name == "photosynthesis rate")
respiration_rate = subset(Compare_BIC, Compare_BIC$trait_name == "respiration rate")
bestfit = c(); photo = c(); resp = c()
for(i in unique(Compare_BIC$Best_fit)){
  bestfit = c(bestfit, i)
  photo = c(photo, sum(photosynthesis_rate$Best_fit == i)/nrow(photosynthesis_rate))
  resp = c(resp, sum(respiration_rate$Best_fit == i)/nrow(respiration_rate))
}
subBIC_traitname = cbind(bestfit, photo, resp)
colnames(subBIC_traitname) = c("bestfit", "photosynthesis", "respiration")
rownames(subBIC_traitname) = subBIC_traitname[,1]
subBIC_traitname = subBIC_traitname[,2:3]
subBIC_traitname = melt(subBIC_traitname)
colnames(subBIC_traitname) = c("Best_fit", "trait_name", "trait_value")
subBIC_traitname$trait_value = as.numeric(subBIC_traitname$trait_value)
pdf("../results/sub_trait.pdf", width = 8, height = 6)
ggplot(subBIC_traitname, mapping = aes(x = trait_name, y =trait_value, fill = Best_fit))+
  geom_bar(stat = "identity", position = "fill", width = 0.5)+
  labs(x = "Trait Name", y = "Percentage of Best Fit")+ theme_bw()
graphics.off()
print("Done!")
################Average prediction#############
print("Comparing estimations from Schoolfield...")
# Subsets with habitat
School_fit_AIC$habitat[School_fit_AIC$habitat == "marine" | School_fit_AIC$habitat == "freshwater"] = "aquatic"
terrestrial = subset(School_fit_AIC, School_fit_AIC$habitat == "terrestrial")
aquatic = subset(School_fit_AIC, School_fit_AIC$habitat == "aquatic")
freshwater_terrestrial = subset(School_fit_AIC, School_fit_AIC$habitat == "freshwater / terrestrial")

# mean(terrestrial$Th); mean(aquatic$Th); mean(freshwater_terrestrial$Th)
# mean(terrestrial$Ea); mean(aquatic$Ea); mean(freshwater_terrestrial$Ea)
# mean(terrestrial$Eh); mean(aquatic$Eh); mean(freshwater_terrestrial$Eh)
# summary(aov(Ea~habitat, School_fit_AIC))
# pairwise.t.test(School_fit_AIC$Ea, School_fit_AIC$habitat, p.adj = "none")
# t.test(School_fit_AIC$Ea[School_fit_AIC$habitat == "aquatic"], School_fit_AIC$Ea[School_fit_AIC$habitat == "terrestrial"])
# summary(aov(Eh~habitat, School_fit_AIC))
# pairwise.t.test(School_fit_AIC$Eh, School_fit_AIC$habitat, p.adj = "none")
# t.test(School_fit_AIC$Eh[School_fit_AIC$habitat == "aquatic"], School_fit_AIC$Eh[School_fit_AIC$habitat == "terrestrial"])
# summary(aov(Th~habitat, School_fit_AIC))

# Subsets with trait name
photosynthesis_rate = subset(School_fit_AIC, School_fit_AIC$trait_name == "photosynthesis rate")
respiration_rate = subset(School_fit_AIC, School_fit_AIC$trait_name == "respiration rate")

# t.test(School_fit_AIC$Th[School_fit_AIC$trait_name == "photosynthesis rate"], School_fit_AIC$Th[School_fit_AIC$trait_name == "respiration rate"])
# t.test(School_fit_AIC$Ea[School_fit_AIC$trait_name == "photosynthesis rate"], School_fit_AIC$Ea[School_fit_AIC$trait_name == "respiration rate"])
# t.test(School_fit_AIC$Eh[School_fit_AIC$trait_name == "photosynthesis rate"], School_fit_AIC$Eh[School_fit_AIC$trait_name == "respiration rate"])

pdf("../results/habitat.pdf")
grid.newpage()
pushViewport(viewport(layout = grid.layout(2,2)))
print(qplot(habitat, Th, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Th (K)") +
  theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
  vp = viewport(layout.pos.row = 1, layout.pos.col = 1)) 
print(qplot(habitat, Ea, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Ea (eV)") +
        theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
      vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(qplot(habitat, Eh, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Eh (eV)") +
        theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
      vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
graphics.off()
pdf("../results/traits.pdf")
grid.newpage()
pushViewport(viewport(layout = grid.layout(2,2)))
print(qplot(trait_name, Th, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Th (K)") +
        theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
      vp = viewport(layout.pos.row = 1, layout.pos.col = 1)) 
print(qplot(trait_name, Ea, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Ea (eV)") +
        theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
      vp = viewport(layout.pos.row = 1, layout.pos.col = 2))
print(qplot(trait_name, Eh, data = School_fit_AIC, geom = "boxplot", xlab = "", ylab = "Eh (eV)") +
        theme(axis.text.x = element_text(angle = -12))+stat_summary(fun.y = "mean", geom = "point", shape = 4, size = 2),
      vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
graphics.off()
print("Done!")

#################Example plot##################
print("Plotting the example plot...")
pdf("../results/341.pdf")
i = 341
datai = subset(cData, cData$ID == i) # Data subset for iteration
t_max = max(datai$temp)
t_min = min(datai$temp)
t_points = seq(t_min, t_max, 0.1)
plot(datai$temp, datai$trait_value, xlab = "Temperature(celsius)", ylab = unique(datai$trait_name), ylim = c(0.95*min(datai$trait_value),1.1*max(datai$trait_value)))
plm2 = try(lm(trait_value ~poly(temp,2), data = datai), silent = T)
if(class(plm2) != "try-error"){
  plm2_pre = predict(plm2, newdata = list(temp = t_points))
  lines(t_points, plm2_pre, col = 2)}
plm3 = try(lm(trait_value ~poly(temp,3), data = datai), silent = T)
if(class(plm3) != "try-error"){
  plm3_pre = predict(plm3, newdata = list(temp = t_points))
  lines(t_points, plm3_pre, col = 3)}
Bdatai = subset(Briere_AIC, Briere_AIC$ID == i)
nlm_pre = Bdatai$B0*t_points*(t_points-Bdatai$T0)*(Bdatai$Tm-t_points)^0.5
try(lines(t_points, nlm_pre, col = 4), silent = T)
datas = subset(sch_cData, sch_cData$ID == i) # Data subset for iteration(Schoolfield)
dataA = subset(School_fit_AIC, School_fit_AIC$ID ==i) # Data subset for starting values
tran_kT = -1/(k*(t_points+273.15))
nlm_pre_school = exp(dataA$lnB0+(tran_kT+1/(283.15*k))*dataA$Ea)/(1+exp((1/(dataA$Th*k)+tran_kT)*dataA$Eh))
try(lines(t_points, nlm_pre_school, col = 7), silent = T)
legend("topleft", legend = c("quadratic","cubic", "Briere", "Schoolfield"), lwd = 2, col = c(2:4, 7))
text(30, 0.5, "AIC(cubic)=")
text(33.5,0.5,round(AIC(plm3),2))
text(30,0.45,"AIC(Schoolfield)=")
text(34.5,0.45, round(School_fit_AIC$AIC[School_fit_AIC$ID == i], 2))
graphics.off()
print("Finished running!")