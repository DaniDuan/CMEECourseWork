rm(list=ls()) #Clear workplace
dev.off()

data = load("../data/KeyWestAnnualMeanTemperature.RData")
View(ats)
plot(ats,type="p")

temp1 = ats$Temp[2:length(ats$Temp)]
temp2 = ats$Temp[1:length(ats$Temp)-1]
cor = cor(temp1, temp2)
cor.test(temp1,temp2)

cor_random = c()
for(i in 1:10000){
  temp_random = sample(ats$Temp, 100, replace = F)
  temp_random_1 = temp_random[2:length(temp_random)]
  temp_random_2 = temp_random[1:length(temp_random)-1]
  x = cor(temp_random_1, temp_random_2)
  cor_random = c(cor_random,x)
}

pdf("Autocorrelation_plot.pdf", 8,5)
plot(density(cor_random), xlab = "Correlation Coefficients", main = "")
abline(v=cor, lty=2)
text(x = cor, y = 3.5, labels = "correlation between\nsuccessive years\nr = 0.326")
graphics.off()

fraction = length(cor_random[cor_random>cor])/10000
fraction

