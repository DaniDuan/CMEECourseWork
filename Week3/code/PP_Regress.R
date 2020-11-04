library(ggplot2)

MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Type.of.feeding.interaction = as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location = as.factor(MyDF$Location)

pdf("../results/PP_Regress.pdf")
p = qplot(Prey.mass, Predator.mass, data=MyDF, facets = Type.of.feeding.interaction ~., colour = Predator.lifestage, log="xy", geom="point", shape=I(3), xlab = "Prey Mass in grams", ylab = "Predator Mass in grams") 
p + geom_smooth(method="lm", fullrange=T) +
  theme_bw() +
  theme(legend.position = "bottom") + 
  guides(col = guide_legend(nrow = 1))
graphics.off()

output = data.frame()
for(i in 1:length(unique(MyDF$Predator.lifestage))){
  life = subset(MyDF, Predator.lifestage == unique(Predator.lifestage)[i])
  for(n in 1: length(unique(life$Type.of.feeding.interaction))){
    feed = subset(life, Type.of.feeding.interaction == unique(Type.of.feeding.interaction)[n])
    if(nrow(feed)>2){
      Summ = summary(lm(log(Predator.mass)~log(Prey.mass), data = feed))
      dataframe = data.frame(
        unique(MyDF$Type.of.feeding.interaction)[n],
        unique(MyDF$Predator.lifestage)[i],
        r2 = Summ$r.squared,
        inter = Summ$coefficients[1],
        slope = Summ$coefficients[2],
        pvalue = Summ$coefficients[2,4],
        fvalue = as.numeric(Summ$fstatistic[1]))
      output = rbind(output, dataframe)
    }
  }
}
