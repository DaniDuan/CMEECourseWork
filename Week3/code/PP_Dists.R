rm(list=ls())
graphics.off()

require(tidyverse)
library(ggplot2)

MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
dplyr::glimpse(MyDF)
MyDF$Type.of.feeding.interaction = as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location = as.factor(MyDF$Location)

x=unique(MyDF$Type.of.feeding.interaction)
length(x)

ratio_data = log(MyDF$Prey.mass/MyDF$Predator.mass)
MyDF$ratio= ratio_data
MyDF$ratio = as.numeric(MyDF$ratio)

Av_pred_mass = c()
Av_prey_mass = c()
Av_ratio = c()
Med_pred_mass = c()
Med_prey_mass = c()
Med_ratio = c()

pdf("../results/Pred_Subplots.pdf",8.3,11.7)
par(mfcol=c(5,1))
n=0
for(i in x){
  n= n+1
  par(mfg = c(n,1))
  plot(density(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction==i])),xlab="log(Predator Mass)", ylab = "Density", main=i, cex.main = 1)
  pred_mass = mean(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction==i]))
  pred_med = median(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction ==i]))
  Av_pred_mass=c(Av_pred_mass,pred_mass)
  Med_pred_mass = c(Med_prey_mass, pred_med)
}
mtext("Predator Mass by Feeding Interaction Type", side=3, outer=T, line=-1.5)
graphics.off()

pdf("../results/Prey_Subplots.pdf",8.3,11.7)
par(mfcol=c(5,1))
n=0
for(i in x){
  n=n+1
  par(mfg=c(n,1))
  plot(density(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==i])), xlab = "log(Prey Mass)", ylab = "Density", main = i, cex.main = 1)
  prey_mass = mean(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==i]))
  prey_med = median(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==i]))
  Av_prey_mass = c(Av_prey_mass, prey_mass)
  Med_prey_mass = c(Med_prey_mass, prey_med)
}
mtext("Prey Mass by Feeding Interaction Type", side=3, outer=T, line=-1.5)
graphics.off()

pdf("../results/SizeRatio_Subplots.pdf",8.3,11.7)
par(mfcol=c(5,1))
n=0
for(i in x){
  n=n+1
  par(mfg=c(n,1))
  plot(density(MyDF$ratio[MyDF$Type.of.feeding.interaction==i]), xlab = "log(Ratio)", ylab = "Density", main = i)
  rat_mean = mean(MyDF$ratio[MyDF$Type.of.feeding.interaction==i])
  rat_med = median(MyDF$ratio[MyDF$Type.of.feeding.interaction==i])
  Av_ratio = c(Av_ratio, rat_mean)
  Med_ratio = c(Med_ratio, rat_med)
}
mtext("Prey/Predator Size Ratio by Feeding Interaction Type", side=3, outer=T, line=-1.5)
graphics.off()

data_mean = data.frame(x, Av_pred_mass,Av_prey_mass,Av_ratio)
colnames(data_mean) = c("Type of Feeding","Mean log(Predator Mass)", "Mean log(Prey Mass)", "Mean log(Ratio)")
data_med = data.frame(x,Med_pred_mass, Med_pred_mass, Med_ratio)
colnames(data_med) = data.frame("Type of Feeding", "Median log(Predator Mass)", "Median log(Prey Mass)", "Mean log(ratio)")

write.table(data_mean, file = "../results/PP_Results.csv",row.names = F)
cat("\n",file = "../results/PP_Results.csv", append = T)
write.table(data_med, file = "../results/PP_Results.csv", row.names = F, append = T)