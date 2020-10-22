###### Functions #######

## A function to take a sample of size n from a population "popn" and return its mean
myexperiment = function(popn,n){
  pop_sample = sample(popn,n,replace = F)
  return(mean(pop_sample))
}

## Calculate means using a for loop without preallocation:
loopy_sample1 = function(popn, n, num){
  result1 = vector()
  for(i in 1:num){
    result1 = c(result1,myexperiment(popn, n))
  }
  return(result1)
}

## To run "num" iteration of the experiment using a for loop on a vector with preallocation
loopy_sample2 = function(popn, n, num){
  result2 = vector(,num) #preallocate expected size 
  for(i in 1:num){
    result2[i] = myexperiment(popn,n)
  }
  return(result2)
}

## To run "num" iterations of the experiment using vectorization with lapply:
loopy_sample3 = function(popn,n,num){
  result3 = vector("list", num)
  for(i in 1:num){
    result3[[i]] = myexperiment(popn,n)
  }
  return(result3)
}

## To run "num" iterations of the experiment using vectorization with lapply
lapply_sample = function(popn,n,num){
  result4 = lapply(1:num,function(i) myexperiment(popn, n))
  return(result4)
}

## To run "num" iterations of the experiment using vectorization with lapply
sapply_sample = function(popn,n,num){
  result5 = sapply(1:num, function(i) myexperiment(popn,n))
  return(result5)
}


popn = rnorm(1000)
hist(popn)


n = 20
num = 1000

print("the loopy, non_preallocation approach takes:")
print(system.time(loopy_sample1(popn, n, num)))

print("the loopy, but with preallocation approach takes:")
print(system.time(loopy_sample2(popn, n, num)))

print("the loopy, non-preallocation approach on a list takes:")
print(system.time(loopy_sample3(popn, n, num)))

print("the vectorized sapply approach takes:")
print(system.time(sapply_sample(popn,n,num)))

print("the vectorized lapply approach takes:")
print(system.time(lapply_sample(popn,n,num)))


x = 1:20
y = factor(rep(letters[1:5], each = 4))
tapply(x, y, sum)


attach(iris)
iris
by(iris[,1:2], iris$Species, colMeans)
by(iris[,1:2], iris$Petal.Width, colMeans)


replicate(10, runif(5))