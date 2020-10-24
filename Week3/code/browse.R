Exponential = function(N0 = 1, r= 1, generations = 10){
  #Runs a simulation of exponential growth
  #Returns a vector of length generations
  N = rep(NA, generations) # creates a vector of NA
  N[1] = N0
  for(t in 2:generations){
    N[t] = N[t-1] * exp(r)
    #browser()  # A break point imported 
  }
  return(N)
}

plot(Exponential(), type = "l", main = "Exponential growth")


doit = function(x){
  temp_x = sample(x, replace = T)
  if(length(unique(temp_x))>30) {# Only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  }
  else{
    stop("Couldn't calculate mean: too few unique values")
  }
}

popn = rnorm(50)
hist(popn)

lapply(1:15, function(i) doit(popn))

result = lapply(1:15, function(i) try(doit(popn), F))
class(result)
result

result = vector("list", 15)  # Preallocate/Initialize
for(i in 1:15){
  result[[i]] = try(doit(popn), F)
}
