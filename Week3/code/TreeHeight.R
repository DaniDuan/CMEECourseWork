# This function calculates height of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUEMENTS
# degrees: The angle of elevation of tree
# distance The distance from base of tree (e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
MyData = read.csv("../data/trees.csv", header = T)
Distance.m = MyData$Distance.m
Angle.degrees = MyData$Angle.degrees
Species = MyData$Species

TreeHeight = function(degrees,distance){
  radians = degrees * pi / 100
  height = distance * tan(radians)
  print(paste("Tree height is:",height))
  
  return(height)
}

Tree.Height.m = TreeHeight(Angle.degrees,Distance.m)
TreeHts = data.frame(Species, Distance.m, Angle.degrees, Tree.Height.m)
names(TreeHts) = c("Species", "Distance.m", "Angle.degrees", "Tree.Height.m")
TreeHts

write.table(TreeHts, "../results/TreeHts.csv", row.names = F)
