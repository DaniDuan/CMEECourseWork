NoPreallocFun = function(x){
  a = vector()
  for (i in 1:x){
    a = c(a,i)
    print(a)
    print(object.size(a))
  }
}
system.time(NoPreallocFun(10))


PreallocFun = function(x){
  a = rep(NA,x) #empty vector
  for (i in 1:x) {
    a[i] = i
    print(a)
    print(object.size(a))
  }
}
system.time(PreallocFun(10))