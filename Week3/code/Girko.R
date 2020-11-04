install.packages("ggplot2")
require(ggplot2)

build_ellipse = function(hradius,vradius){
  npoints = 250
  a = seq(0,2*pi, length = npoints+1)
  x = hradius*cos(a)
  y = vradius*sin(a)
  return(data.frame(x=x,y=y))
}
N = 250
M = matrix(rnorm(N*N),N,N)
eigvals = eigen(M)$values
eigDF = data.frame("Real"=Re(eigvals), "Imaginary" = Im(eigvals))
my_radius = sqrt(N)
ellDF = build_ellipse(my_radius,my_radius)
names(ellDF) = c("Real","Imaginary")

pdf("../results/Girko.pdf")
p = ggplot(eigDF, aes(x=Real, y=Imaginary))
p = p+geom_point(shape = I(3)) + theme(legend.position = "none")
p = p+geom_hline(aes(yintercept = 0))
p = p+geom_vline(aes(xintercept = 0))
p = p+geom_polygon(data = ellDF, aes(x=Real, y=Imaginary, alpha=1/20, fill="red"))
p
graphics.off()