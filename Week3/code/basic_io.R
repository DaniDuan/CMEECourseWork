MyData = read.csv("../data/trees.csv", header = T)
write.csv(MyData, "../data/tree.csv")
write.table(MyData, "../results/MyData.csv",append = T)
write.csv(MyData, "../results/MyData.csv", row.names = T)
write.table(MyData, "../results/MyData.csv",col.names = F)