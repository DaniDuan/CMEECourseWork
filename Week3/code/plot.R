require(tidyverse)
require(ggplot2)
require(reshape2)

MyDF = read.csv("../data/EcolArchives-E089-51-D1.csv")
dplyr::glimpse(MyDF)
MyDF$Type.of.feeding.interaction = as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location = as.factor(MyDF$Location)

plot(MyDF$Predator.mass, MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20,xlab = "Predator Mass(g)", ylab = "Prey Mass(g)")

hist(MyDF$Predator.mass)
hist(log10(MyDF$Predator.mass),xlab = "log10(Predator Mass(g)", ylab = "Count")
hist(log10(MyDF$Predator.mass),xlab="log10(Predator Mass(g)", ylab = "Count", col = "lightblue", border="pink")

par(mfcol=c(2,1)) #plot by column
par(mfg=c(1,1)) #plot in the first column
hist(log10(MyDF$Predator.mass),xlab = "log10(Predator Mass(g)", ylab = "Count", col="lightblue", border="pink", main="Predator")
par(mfg=c(2,1)) #plot in the second column
hist(log10(MyDF$Prey.mass),xlab = "log10(Prey Mass(g))", ylab = "Count", col="lightgreen", border="pink", main="Prey")

hist(log10(MyDF$Predator.mass),xlab = "log10(Body Mass(g))", ylab = "Count",col = rgb(1,0,0,0.5), main = "Predator-prey size Overlap")
hist(log10(MyDF$Prey.mass),col=rgb(0,0,1,0.5),add=T)
legend("topleft", c("Predators","Prey"), fill=c(rgb(1,0,0,0.5), rgb(0,0,1,0.5)))

boxplot(log10(MyDF$Predator.mass), xlab = "location", ylab= "log10(predator mass)", main= "Predator mass")
boxplot(log(MyDF$Predator.mass)~MyDF$Location, xlab="location", ylab="log10(predator mass)", main="predator mass by location")
boxplot(log(MyDF$Predator.mass)~MyDF$Type.of.feeding.interaction, xlab = "Location", ylab = "Predator Mass", main = "Predator mass by feeding interaction type")

par(fig=c(0,0.8,0,0.8))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab="predator mass", ylab = "prey mass")
par(fig=c(0,0.8,0.4,1),new=T)
boxplot(log(MyDF$Predator.mass), horizontal = T, axes= F)
par(fig=c(0.55,1,0,0.8),new=T)
boxplot(log(MyDF$Prey.mass),axes=F)
mtext("Fancy Predator-prey scatterplot", side=3, outer=T, line=-3)
#side: on which side of the plot (1=bottom, 2=left, 3=top, 4=right)
#outer: use outer margins if available.
#line: on which MARgin line, starting at 0 counting outwards.

pdf("../results/Pred_Prey_overlay.pdf",11.7,8.3)
hist(log(MyDF$Predator.mass),xlab = "body mass", ylab="count", col=rgb(1,0,0,0.5),main= "Predator_prey_overlap")
#rgb: This function creates colors corresponding to the given intensities (between 0 and max) of the red, green and blue primaries. 
hist(log(MyDF$Prey.mass),col = rgb(0,0,1,0.5),add=T)
legend("topleft",c("predator","prey"), col=c(rgb(1,0,0,0.5),rgb(0,0,1,0.5)))
graphics.off()



###########################################################
##Beautiful graphics in R
qplot(Prey.mass, Predator.mass, data = MyDF)
qplot(log(Prey.mass),log(Predator.mass),data=MyDF,color = Type.of.feeding.interaction, asp=1)
qplot(log(Prey.mass),log(Predator.mass),data=MyDF,shape = Type.of.feeding.interaction, asp=1)
qplot(log(Prey.mass),log(Predator.mass),data = MyDF, color="red")
qplot(log(Prey.mass),log(Predator.mass),data = MyDF, color=I("red"))
qplot(log(Prey.mass),log(Predator.mass),data = MyDF, size=I(3))
qplot(log(Prey.mass),log(Predator.mass),data = MyDF, shape=I(3))
qplot(log(Prey.mass),log(Predator.mass),data=MyDF,color = Type.of.feeding.interaction, alpha = I(.5)) #semi-transparent
qplot(log(Prey.mass),log(Predator.mass), data = MyDF, geom = c("point","smooth"))
qplot(log(Prey.mass),log(Predator.mass), data = MyDF, geom = c("point","smooth")) +geom_smooth(method = "lm")
qplot(log(Prey.mass),log(Predator.mass), data = MyDF, geom = c("point","smooth"), colour = Type.of.feeding.interaction) +geom_smooth(method = "lm")
qplot(log(Prey.mass),log(Predator.mass), data = MyDF, geom = c("point","smooth"), colour = Type.of.feeding.interaction) +geom_smooth(method = "lm", fullrange = T)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass),data = MyDF, geom = "jitter")
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass),data = MyDF, geom = "boxplot")
qplot(log(Prey.mass/Predator.mass),data = MyDF, geom = "histogram", fill = Type.of.feeding.interaction, binwidth = 1)
qplot(log(Prey.mass/Predator.mass),data = MyDF, geom = "density", fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass),data = MyDF, geom = "density", fill = Type.of.feeding.interaction, alpha=I(0.5))
qplot(log(Prey.mass/Predator.mass),facets = Type.of.feeding.interaction ~.,data = MyDF, geom = "density")
qplot(log(Prey.mass/Predator.mass),facets = .~ Type.of.feeding.interaction,data = MyDF, geom = "density")
qplot(Prey.mass, Predator.mass, data = MyDF, log = "xy")
qplot(Prey.mass, Predator.mass, data=MyDF, log = "xy", main = "Relation between predator and prey mass", xlab = "log(Prey mass)(g)", ylab = "log(Predator mass)(g)")
qplot(Prey.mass, Predator.mass, data=MyDF, log = "xy", main = "Relation between predator and prey mass", xlab = "log(Prey mass)(g)", ylab = "log(Predator mass)(g)") + theme_bw()

pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",main = "Relation between predator and prey mass",xlab = "log(Prey mass)(g)",ylab = "log(Predator mass)(g)")+theme_bw())
dev.off()

MyDF = as.data.frame(read.csv("../data/EcolArchives-E089-51-D1.csv"))
qplot(Predator.lifestage, data = MyDF, geom = "bar")
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "boxplot")
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "violin")
qplot(log(Predator.mass),data = MyDF, geom = "density")
qplot(log(Predator.mass),data = MyDF, geom = "histogram")
qplot(log(Predator.mass),log(Prey.mass),data = MyDF, geom = "point")
qplot(log(Predator.mass),log(Prey.mass),data = MyDF, geom = "smooth")
qplot(log(Predator.mass),log(Prey.mass),data = MyDF, geom = "smooth", method="lm")
p = ggplot(MyDF, aes(x=log(Predator.mass), y = log(Prey.mass), colour = Type.of.feeding.interaction))
p+geom_point()
p = ggplot(MyDF, aes(x=log(Predator.mass), y=log(Prey.mass), colour = Type.of.feeding.interaction))
q = p+ geom_point(size=I(2), shape=I(10)) +theme_bw()+theme(aspect.ratio = 1)
q+theme(legend.position = "none")+theme(aspect.ratio = 1)
p = ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass),fill=Type.of.feeding.interaction)) +geom_density(alpha=0.9)
p = ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass),fill=Type.of.feeding.interaction)) +geom_density()+ facet_wrap(.~Type.of.feeding.interaction)
p = ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass),fill=Type.of.feeding.interaction)) +geom_density()+ facet_wrap(.~Type.of.feeding.interaction, scales = "free")
p = ggplot(MyDF, aes(x=log(Prey.mass/Predator.mass)))+geom_density()+facet_wrap(.~Location, scales = "free")
p = ggplot(MyDF, aes(x=log(Prey.mass), y=log(Predator.mass)))+ geom_point()+ facet_wrap(.~Location, scales = "free")
p = ggplot(MyDF, aes(x=log(Prey.mass), y=log(Predator.mass)))+ geom_point()+ facet_wrap(.~Location+Type.of.feeding.interaction, scales = "free")
p = ggplot(MyDF, aes(x=log(Prey.mass), y=log(Predator.mass)))+ geom_point()+ facet_wrap(.~Type.of.feeding.interaction+Location, scales = "free")
p

require(reshape2)
GenerateMatrix  =function(N){
  M = matrix(runif(N*N),N,N)
  return(M)
}
M = GenerateMatrix(10)
Melt = melt(M)
p = ggplot(Melt, aes(Var1,Var2,fill=value))+geom_tile()+theme(aspect.ratio = 1)
p+geom_tile(colour = "black")+theme(aspect.ratio = 1)
p + theme(legend.position = "none")+theme(aspect.ratio = 1)
p + theme(legend.position = "none", panel.background = element_blank(), 
          axis.ticks = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.text.x = element_blank(),
          axis.title.x = element_blank(),
          axis.text = element_blank(),
          axis.title.y = element_blank())
p+scale_fill_continuous(low = "yellow", high = "darkgreen")
p+scale_fill_gradient2()
p+scale_fill_gradientn(colours = grey.colors(10))
p+scale_fill_gradientn(colours = rainbow(10))
p+scale_fill_gradientn(colours = c("red","white","blue"))

######################################################################
#ggthemes
install.packages("ggthemes")
library(ggthemes)
p = ggplot(MyDF, aes(x= log(Predator.mass), y= log(Prey.mass),colour = Type.of.feeding.interaction)) +geom_point(size = I(2), shape=I(10)) + theme_bw()
p + geom_rangeframe() + theme_tufte()
