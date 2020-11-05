require(ggplot2)
x = seq(0,100, by=0.1)
y =-4. + 0.25*x + rnorm(length(x),mean=0.,sd=2.5)
my_data = data.frame(x=x, y=y)
my_lm = summary(lm(y~x,data=my_data))

pdf("../results/MyLinReg.pdf")
p = ggplot(my_data, aes(x=x,y=y,colour = abs(my_lm$residuals)))+ geom_point() +scale_colour_gradient(low="black", high = "red")+theme(legend.position = "none")+scale_x_continuous(expression(alpha^2*pi/beta*sqrt(Theta)))
p = p+ geom_abline(intercept = my_lm$coefficients[1][1],slope = my_lm$coefficients[2][1] ,colour = "red")
p = p+geom_text(aes(x=60,y=0,label = "sqrt(alpha)*2*pi"),parse = T, size=6, colour="blue")
p
graphics.off()
