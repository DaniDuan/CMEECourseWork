rm(list=ls())
install.packages("maps")
require(maps)
require(ggplot2)

load("../data/GPDDFiltered.RData")

world_map = map_data("world")
p = ggplot() + coord_fixed() + xlab("") + ylab("")
world = p + borders("world", colour = "grey 55", fill = "grey 99") +
  theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  geom_point(data = gpdd, aes(x = long, y = lat), color = "black", shape = I(3), alpha = I(0.8))

world

#The locations were not evenly distributed. More locations were located at seaside, 
#therefore less terrestrial and freshwater habitats are considered. 