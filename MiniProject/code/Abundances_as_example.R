library(ggplot2)
library(minpack.lm)

t = seq(0,22,2)
N = c(32500, 33000, 38000, 105000, 445000, 1430000, 3020000, 4720000, 5670000, 5870000, 5930000, 5940000)
set.seed(1234)
data = data.frame(t,N*(1+rnorm(length(t),sd = 0.1)))
names(data) = c("Time", "N")
head(data)

ggplot(data, aes(x= Time, y = N))+ geom_point(size = 3)+ labs(x = "Time(Hours)", y = "Population size(cells)")

data$LogN = log(data$N)
ggplot(data,aes(x=t,y=LogN))+geom_point(size=3)+labs(x = "Time(Hours)", y = "log(cell number)")

#use time periods to calculate the growth rate
(data[data$Time == 10,]$LogN -data[data$Time == 6,]$LogN)/(10-6)
#maximum observed gradient, /2 to get successive time points
diff(data$LogN)
max(diff(data$LogN))/2


#####USING OLS###########
lm_growth = lm(LogN ~Time, data = data[data$Time>2&data$Time<12,])
summary(lm_growth)


#####USING NLLS##########
logistic_model  =function(t,r_max,N_max, N_0){
  return(N_0 * N_max *exp(r_max *t)/(N_max+N_0*(exp(r_max *t)-1)))
}
N_0_start = min(data$N)
N_max_start = max(data$N)
r_max_start = 0.62 #from OLS fitting
fit_logistic = nlsLM(N~logistic_model(t=Time,r_max, N_max, N_0),data,
                     list(r_max = r_max_start, N_0 = N_0_start, N_max = N_max_start))
summary(fit_logistic)

timepoints = seq(0, 22, 0.1)
logistic_points = logistic_model(t = timepoints, 
                                 r_max = coef(fit_logistic)["r_max"],
                                 N_max = coef(fit_logistic)["N_max"],
                                 N_0 = coef(fit_logistic)["N_0"])
df1 = data.frame(timepoints, logistic_points)
df1$model = "Logistic equation"
names(df1) = c("Time", "N", "model")

ggplot(data, aes(x= Time, y = N))+ 
  geom_point(size = 3)+
  geom_line(data = df1, aes(x = Time, y = N, col = model), size =1)+
  theme(aspect.ratio =1)+
  labs(x = "Time", y = "Cell number")

ggplot(data, aes(x = Time, y = LogN))+ 
  geom_point(size = 3)+ 
  geom_line(data = df1, aes(x = Time, y = log(N),col = model),size=1)+
  theme(aspect.ratio = 1)+
  labs(x="Time", y = "log(Cell number)")

ggplot(data, aes(x=N, y= LogN)) +
  geom_point(size = 3)+
  theme(aspect.ratio = 1)+
  labs(x="N", y = "log(N)")

gompertz_model = function(t,r_max, N_max, N_0, t_lag){
  return(N_0 + (N_max - N_0)* exp(-exp(r_max*exp(1)* (t_lag -t)/((N_max-N_0)*log(10))+1)))
}
N_0_start = min(data$LogN)
N_max_start = max(data$LogN)
r_max_start = 0.62
t_lag_start = data$Time[which.max(diff(diff(data$LogN)))]

diff(data$LogN)
diff(diff(data$LogN))
which.max(diff(diff(data$LogN)))
data$Time[which.max(diff(diff(data$LogN)))]
fit_gompertz = nlsLM(LogN~gompertz_model(t=Time, r_max, N_max, N_0, t_lag), data,
                     list(t_lag = t_lag_start, r_max=r_max_start, N_0 = N_0_start, N_max = N_max_start))
summary(fit_gompertz)


timepoints = seq(0,24,0.1)
logistic_points = log(logistic_model(t = timepoints, r_max = coef(fit_logistic)["r_max"],
                                     N_max = coef(fit_logistic)["N_max"],
                                     N_0 = coef(fit_logistic)["N_0"]))
gompertz_points = gompertz_model(t = timepoints, r_max = coef(fit_gompertz)["r_max"],
                                     N_max = coef(fit_gompertz)["N_max"],
                                     N_0 = coef(fit_gompertz)["N_0"],
                                     t_lag = coef(fit_gompertz)["t_lag"])
df1 = data.frame(timepoints, logistic_points)
df1$model = "Logistic model"
names(df1) = c("Time", "LogN", "model")

df2 = data.frame(timepoints, gompertz_points)
df2$model = "Gompertz model"
names(df2) = c("Time", "LogN", "model")

model_frame = rbind(df1, df2)
ggplot(data,aes(x=Time, y=LogN))+
  geom_point(size=3)+
  geom_line(data = model_frame,aes(x=Time, y=LogN,col= model),size=1)+
              theme_bw()+
              theme(aspect.ratio = 1)+
              labs(x="Time",y="log(Abundance)")

