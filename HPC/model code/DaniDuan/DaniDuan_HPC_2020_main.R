# CMEE 2020 HPC excercises R code main proforma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "Quqiming Duan"
preferred_name <- "Danica"
email <- "d.duan20@imperial.ac.uk"
username <- "DaniDuan"

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community = c(1,4,4,5,1,6,1)){
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size = 7){
  return(seq(from = 1, to = size, by = 1))
}

# Question 3
init_community_min <- function(size = 4){
  return(rep(1, times = size))
}

# Question 4
choose_two <- function(max_value = 4){
  return(sample(max_value,2, replace = F))
}

# Question 5
neutral_step <- function(community = c(10,5,13)){
  index = choose_two(length(community))
  community[index[1]] = community[index[2]] #Replacing the dead with reproduction
  return(community)
}

# Question 6
neutral_generation <- function(community = c(1,5,2,6,8,13,25)){
  # For x individuals, x/2 individual neutral steps for a complete generation
  for(i in 1:floor(length(community)/2)) community = neutral_step(community)
  return(community)
}

# Question 7
neutral_time_series <- function(community = init_community_max(7) , duration = 20)  {
  richness = c(species_richness(community))
  for(i in 1:duration){ 
    community = neutral_generation(community) # Current community
    richness = c(richness, species_richness(neutral_generation(community)))
  }
  return(richness)
}

# Question 8
question_8 <- function() {
  richness = neutral_time_series(community = init_community_max(100), duration = 200) # Running the simulation for 200 generations
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(richness, type = "l", frame.plot = F, ylab = "Diversity", xlab = "Generation", main = "Time Series Graph of a Neutral Model Simulation")
  abline(h = 1, lty = 3)
  text(x = 160, y = 17.5, "Converging to diversity = 1")
  return("If we wait long enough, the diversity will always converge to 1. Since in this system, all species are considered with same possibility for reproduction and replacement without speciation or new species being introduced, as one species' abundance increases, the probability of reproduction of that species would also increase, therefore the system will finally result in the homogeneity of species.")
}

# Question 9
neutral_step_speciation <- function(community = c(10,5,13), speciation_rate = 0.2)  {
  index = choose_two(length(community))
  rate = runif(1)
  if(rate < speciation_rate){
    community[index[1]] = max(community) + 1 # Replacing a dead individual with a new species
  }else{
    community[index[1]] = community[index[2]] #Replacing a dead individual with an offspring
  }
  return(community)
}

# Question 10
neutral_generation_speciation <- function(community = c(10,5,13), speciation_rate = 0.2)  {
  for(i in 1:floor(length(community)/2)) community = neutral_step_speciation(community, speciation_rate)
  return(community)
}

# Question 11
neutral_time_series_speciation <- function(community = init_community_max(100), speciation_rate = 0.1, duration = 500)  {
  richness = c(species_richness(community))
  for(i in 1:duration){ 
    community = neutral_generation_speciation(community, speciation_rate) #Current community
    richness = c(richness, species_richness(neutral_generation_speciation(community, speciation_rate)))
  }
  return(richness)
}

# Question 12
question_12 <- function()  {
  richness_max = neutral_time_series_speciation(community = init_community_max(100), speciation_rate = 0.1, duration = 200)
  richness_min = neutral_time_series_speciation(community = init_community_min(100), speciation_rate = 0.1, duration = 200)
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(richness_max, frame.plot = F, type = "l", pch = 1, cex = 0.75, col = 1, ylim = c(0,100), ylab = "Diversity", xlab = "Generation", main = "Time Series Graph of a Neutral Model Simulation")
  lines(richness_min, pch = 1, cex = 0.75, col = 2)
  legend('topright', c('richness_max','richness_min'), fill = c(1,2), bty = "n")
  return("Given time, the final convergence of diversity is determined by the speciation rate and the initial size of the community, but not related to the initial diversity of the system. Because when the rate of extinction is balanced by the rate of speciation, the diversity of this system will reach a dynamic equilibrium.")
}

# Question 13
species_abundance <- function(community = c(1,5,3,6,5,6,1,1))  {
  return(sort(as.data.frame(table(community))[,2],decreasing = T)) # Getting frequencies and sort in descending order
}

# Question 14
octaves <- function(abundance_vector = c(100,64,63,5,4,3,2,2,1,1,1,1)) {
  return(tabulate(floor(log2(abundance_vector))+1)) #Binning abundances into frequencies in 2^n
}

# Question 15
sum_vect <- function(x = c(1,3), y = c(1,0,5,2)) {
  if(length(x) < length(y)){ # If x is shorter, add 0s to the end of x
    x = c(x, rep(0, (length(y)-length(x))))
  }else{ # If y is shorter, add 0s to the end of y
    y = c(y, rep(0, (length(x)-length(y))))
  }
  return(x+y)
}

# Question 16 
question_16 <- function()  {
  octave_max = 0
  octave_min = 0
  community_max = init_community_max(100) # Community with 100 individuals
  community_min = init_community_min(100)
  for(i in 1:2200){ 
    community_max = neutral_generation_speciation(community = community_max, speciation_rate = 0.1) #Current community
    community_min = neutral_generation_speciation(community = community_min, speciation_rate = 0.1)
    if(i >= 200 & (i-200) %% 20 == 0){
      abundance_max = species_abundance(community_max)
      octave_max = sum_vect(octave_max, octaves(abundance_max)) # Sum up all the octaves since the end of burn-in
      abundance_min = species_abundance(community_min)
      octave_min = sum_vect(octave_min, octaves(abundance_min))
    }
  }
  octave_max_mean = octave_max/101 # Calculating the average of all octaves
  octave_min_mean = octave_min/101
  data = rbind(octave_max_mean,octave_min_mean)
  colnames(data) = c("1","2-3","4-7","8-15","16-31","32-64")
  graphics.off()# clear any existing graphs and plot your graph within the R window
  barplot(data, beside = T, ylab = "Number of Species", ylim = c(0,11), xlab = "Species Abundance", main = "Species Abundance Octave of Neutral Model Simulation",col = c(0,1))
  legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n")
  return("Initial condition of the system does not matter, since this calculation was conducted after the system has already reached its dynamic equilibrium which is related to the speciation rate.")
}

# Question 17
cluster_run <- function(speciation_rate = 0.005413, size=5000, wall_time=1, interval_rich=1,
                        interval_oct=10, burn_in_generations=2000,
                        output_file_name="my_test_file_1.rda")  {
  start_time = proc.time()[3]
  community_max = init_community_max(size)# Community with 100 individuals
  community_min = init_community_min(size)
  richness_max = c(species_richness(community_max))
  richness_min = c(species_richness(community_min))
  i = 0
  repeat{
    community_max = neutral_generation_speciation(community = community_max, speciation_rate = speciation_rate)
    community_min = neutral_generation_speciation(community = community_min, speciation_rate = speciation_rate)
    abundance_max = species_abundance(community_max)
    abundance_min = species_abundance(community_min)
    i = i + 1
    if(i <= burn_in_generations){ # inside the burn-in
      if(i %% interval_rich == 0){ # Recording richness with interval_rich
      richness_max = c(richness_max, species_richness(neutral_generation_speciation(community_max, speciation_rate)))
      richness_min = c(richness_min, species_richness(neutral_generation_speciation(community_min, speciation_rate)))
      octave_max = list(octaves(abundance_max)) # Record the last octave of burn-in
      octave_min = list(octaves(abundance_min))}
    }else{ # after burn-in 
      if((i - burn_in_generations) %% interval_oct == 0){ # Recording octaves with interval_oct
        octave_max[[(i - burn_in_generations)/interval_oct + 1]] = octaves(abundance_max)
        octave_min[[(i - burn_in_generations)/interval_oct + 1]] = octaves(abundance_min)
      }
    }
    if(proc.time()[3]-start_time >= 60*wall_time) {break} # STOP at given time
  }
  time_spent = proc.time()[3]-start_time
  input_parameters = list(speciation_rate = 0.1, size=100, wall_time=10, interval_rich=1, interval_oct=10, burn_in_generations=200)
  save(richness_max, richness_min, octave_max, octave_min, community_max, community_min, time_spent, input_parameters,  file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  # Setting everything to 0, preparing for calculations
  sum_500_min = 0; sum_500_max = 0
  sum_1000_min = 0; sum_1000_max = 0
  sum_2500_min = 0; sum_2500_max = 0
  sum_5000_min = 0; sum_5000_max = 0

  sum_max = c(); sum_min = c()
  for(i in 1:25){ # Size 500
    load(paste("Neutral_cluster_", i, ".rda", sep = ""))
    for (j in 1:length(octave_max)) {
      sum_max = sum_vect(sum_max, octave_max[[j]])
      sum_min = sum_vect(sum_min, octave_min[[j]])
    }
    av_500_max = sum_max / length(octave_max)
    av_500_min = sum_min / length(octave_max)
    sum_max = c() # Remeber to return these two sums to 0 before next round
    sum_min = c()
    sum_500_max = sum_vect(sum_500_max, av_500_max)
    sum_500_min = sum_vect(sum_500_min, av_500_max)
  }
  av_500_max = sum_500_max / 25 # Average oct of all 25 "i"s
  av_500_min = sum_500_min / 25

  sum_max = c(); sum_min = c()
  for(i in 26:50){ # Size 1000
    load(paste("Neutral_cluster_", i, ".rda", sep = ""))
    for (j in 1:length(octave_max)) {
      sum_max = sum_vect(sum_max, octave_max[[j]])
      sum_min = sum_vect(sum_min, octave_min[[j]])
    }
    av_1000_max = sum_max / length(octave_max) # Average oct of every i
    av_1000_min = sum_min / length(octave_max)
    sum_max = c() # Remeber to return these two sums to 0 before next round
    sum_min = c()
    sum_1000_max = sum_vect(sum_1000_max, av_1000_max)
    sum_1000_min = sum_vect(sum_1000_min, av_1000_max)
  }
  av_1000_max = sum_1000_max / 25 # Average oct of all 25 "i"s
  av_1000_min = sum_1000_min / 25
  
  sum_max = c(); sum_min = c()
  for(i in 51:75){ # Size 2500
    load(paste("Neutral_cluster_", i, ".rda", sep = ""))
    for (j in 1:length(octave_max)) {
      sum_max = sum_vect(sum_max, octave_max[[j]])
      sum_min = sum_vect(sum_min, octave_min[[j]])
    }
    av_2500_max = sum_max / length(octave_max) # Average oct of every i
    av_2500_min = sum_min / length(octave_max)
    sum_max = c() # Remeber to return these two sums to 0 before next round
    sum_min = c()
    sum_2500_max = sum_vect(sum_2500_max, av_2500_max)
    sum_2500_min = sum_vect(sum_2500_min, av_2500_max)
  }
  av_2500_max = sum_2500_max / 25 # Average oct of all 25 "i"s
  av_2500_min = sum_2500_min / 25
  
  sum_max = c(); sum_min = c()
  for(i in 76:100){ # Size 5000
    load(paste("Neutral_cluster_", i, ".rda", sep = ""))
    for (j in 1:length(octave_max)) {
      sum_max = sum_vect(sum_max, octave_max[[j]])
      sum_min = sum_vect(sum_min, octave_min[[j]])
    }
    av_5000_max = sum_max / length(octave_max) # Average oct of every i
    av_5000_min = sum_min / length(octave_max)
    sum_max = c() # Remeber to return these two sums to 0 before next round
    sum_min = c()
    sum_5000_max = sum_vect(sum_5000_max, av_5000_max)
    sum_5000_min = sum_vect(sum_5000_min, av_5000_max)
  }
  av_5000_max = sum_5000_max / 25 # Average oct of all 25 "i"s
  av_5000_min = sum_5000_min / 25
  
  combined_results <- list(av_500_max, av_500_min, av_1000_max, av_1000_min, av_2500_max, av_2500_min, av_5000_max, av_5000_min) #create your list output here to return
  save(combined_results, file = "process_cluster_results.rda")# save results to an .rda file
}

plot_cluster_results <- function()  {
    graphics.off()# clear any existing graphs and plot your graph within the R window
    load("process_cluster_results.rda")# load combined_results from your rda file
    # plot the graphs
    par(mfrow = c(2,2))
    data = rbind(combined_results[[1]],combined_results[[2]]) # Size 500
    colnames(data) = c("1","2-3","4-7","8-15","16-31","32-63", "64-127", "128-255", "256-512")
    barplot(data, beside = T, ylab = "Number of Species", xlab = "Species Abundance", col = c(0,1), ylim = c(0,3), sub = "(Simulation size = 500)", cex.names = 0.75, cex.axis = 0.75) 
    legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n", y.intersp=0.7, cex = 0.8)
    
    data = rbind(combined_results[[3]],combined_results[[4]]) # Size 1000
    colnames(data) = c("1","2-3","4-7","8-15","16-31","32-63", "64-127", "128-255", "256-511", "512-1024")
    barplot(data, beside = T, ylab = "Number of Species", xlab = "Species Abundance", col = c(0,1), ylim = c(0,6), sub = "(Simulation size = 1000)", cex.names = 0.75, cex.axis = 0.75) 
    legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n", y.intersp=0.7, cex = 0.8)
    
    data = rbind(combined_results[[5]],combined_results[[6]]) # Size 2500
    colnames(data) = c("1","2-3","4-7","8-15","16-31","32-63", "64-127", "128-255", "256-511", "512-1024")
    barplot(data, beside = T, ylab = "Number of Species", xlab = "Species Abundance", col = c(0,1), sub = "(Simulation size = 2500)", cex.names = 0.75, cex.axis = 0.75) 
    legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n", y.intersp=0.7, cex = 0.8)
    
    data = rbind(combined_results[[7]],combined_results[[8]]) # Size 5000
    colnames(data) = c("1","2-3","4-7","8-15","16-31","32-63", "64-127", "128-255", "256-511", "512-1024")
    barplot(data, beside = T, ylab = "Number of Species", xlab = "Species Abundance", col = c(0,1), ylim = c(0,30), sub = "(Simulation size = 5000)", cex.names = 0.75, cex.axis = 0.75) 
    legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n", y.intersp=0.7, cex = 0.8)
    
    title("Species Abundance Octave of Neutral Model Simulation", outer = T, line = -1.5) 
    return(combined_results)
}

# Question 21
question_21 <- function(size = 8, width = 3)  {
  dimension = log(size)/log(width)
  explanation = "In order for the squares to be three times as wide, 8 times the amount of material is needed, and width^dimension = size"
  answer21 = list(dimension, explanation) # Returning two values as a list
  return(answer21)
}

# Question 22
question_22 <- function(size = 20, width = 3)  {
  dimension = log(size)/log(width)
  explanation = "In this case, 20 times amount of material is needed for the squares to be 3 times as wide, therefore the dimension is calculated as log(20)/log(3)"
  answer22 = list(dimension, explanation) # Returning two values as a list
  return(answer22)
}

# Question 23
chaos_game <- function(x = c(0,3,4), y = c(0,4,1), X = c(0,0), max_time = 15)  {
  start_time = proc.time()[3]
  graphics.off()# clear any existing graphs and plot your graph within the R window
  xy = data.frame(x,y) # Saving the locations of the three points into a dataframe
  plot(xy, xlab = "", ylab = "")
  text(0,0.3,"A") # Labeling the three points
  text(3.2,4,"B")
  text(4,0.7, "C")
  points(X[1],X[2], pch = 19, cex = 0.001) # The start of point vector X
  repeat{
    a = sample(3,1) # picking a point
    X = c((X[1]+xy[a,1])/2, (X[2]+xy[a,2])/2) # Moving X
    points(X[1],X[2], pch = 19, cex = 0.001)
    if(proc.time()[3]-start_time >= max_time){break}} # Repeating chaos game within given time limit
  return("Given enough times of iteration, a Sierpinski Gasket triangle was generated, in which for every triangle pattern to be 2 times as wide, 3 times amount of the material is needed, therefore has a dimension of log(3)/log(2) = 1.584963.")
}

# Question 24
turtle <- function(start_position = c(0,0), direction = pi/2, length = 1)  {
  x = start_position[1]+length*cos(direction) # moving the point according to the given direction
  y = start_position[2]+length*sin(direction)
  endpoint = c(x,y)
  lines(c(start_position[1],x),c(start_position[2],y))
  return(endpoint) # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position = c(0,0), direction = pi/2, length = 1)  {
  endpoint = turtle(start_position, direction, length) #start at the end
  turtle(start_position = endpoint, direction = direction - pi/4, length = 0.95*length) # pi/4 radiant to the right and 0.95 times the length
}

# Question 26
spiral <- function(start_position = c(0,0), direction = pi/2, length = 1)  {
  endpoint = turtle(start_position, direction, length) # start at the end
  if(length >= 0.0001){ # giving length limitation
    spiral(start_position = endpoint, direction = direction - pi/4, length = 0.95*length)}
  return("Error: C stack usage 7969348 is too close to the limit. Because the lines became too short (infinitely approaching 0) after certain amount of iterations, therefore requires a limitation on length. ")
}

# Question 27
draw_spiral <- function()  {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-2.5, 2.5), ylim=c(-2.5, 2.5)) # initiating an empty plot
  spiral(start_position = c(0,0), direction = pi/4, length = 1)
}

# Question 28
tree <- function(start_position = c(0,0), direction = pi/2, length = 1)  {
  endpoint = turtle(start_position, direction, length)
  if(length >= 0.001){
    tree(start_position = endpoint, direction = direction - pi/4, length = 0.65 * length) # to the right
    tree(start_position = endpoint, direction = direction + pi/4, length = 0.65 * length)} # to the left
}

draw_tree <- function()  {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-2, 2), ylim=c(0, 3)) # initiating an empty plot
  tree(start_position = c(0,0), direction = pi/2, length = 1)
}

# Question 29
fern <- function(start_position = c(0,0), direction = pi/2, length = 1)  {
  endpoint = turtle(start_position, direction, length) #start at the end
  if(length >= 0.01){
    fern(start_position = endpoint, direction = direction, length = 0.87 * length) # straight up
    fern(start_position = endpoint, direction = direction + pi/4, length = 0.38 * length)} # to the left
}

draw_fern <- function()  {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-2, 2), ylim=c(0, 8)) # initiating an empty plot
  fern(start_position = c(0,0), direction = pi/2, length = 1)
}

# Question 30
fern2 <- function(start_position = c(0,0), direction = pi/2, length = 1, dir =1 )  {
  endpoint = turtle(start_position, direction, length)
  if(length >= 0.01){
    fern2(start_position = endpoint, direction = direction, length = 0.87 * length, dir = -dir)
    fern2(start_position = endpoint, direction = direction + dir * pi/4, length = 0.38 * length, dir = dir)}
}

draw_fern2 <- function()  {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlab="", ylab="", xlim=c(-2, 2), ylim=c(0, 8)) # initiating an empty plot
  fern2(start_position = c(0,0), direction = pi/2, length = 1, dir = 1)
}


# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  speciation_rate = 0.1
  richness_max_df = as.data.frame(matrix(NaN, nr = 50, nc = 201)) #Creating a dataframe for saving all richness values
  richness_min_df = as.data.frame(matrix(NaN, nr = 50, nc = 201))
  for(i in 1:50){
    set.seed(i)
    community_max = init_community_max(100) # Community with 100 individuals
    community_min = init_community_min(100)
    richness_max = species_richness(community_max)
    richness_min = species_richness(community_min)
    for(j in 1:200){
      community_max = neutral_generation_speciation(community = community_max, speciation_rate = speciation_rate)
      community_min = neutral_generation_speciation(community = community_min, speciation_rate = speciation_rate)
      richness_max = c(richness_max, species_richness(neutral_generation_speciation(community_max, speciation_rate)))
      richness_min = c(richness_min, species_richness(neutral_generation_speciation(community_min, speciation_rate)))
    }
    richness_max_df[i,] = richness_max
    richness_min_df[i,] = richness_min
  }
  richness_max_mean = colMeans(richness_max_df) # Calculating mean values
  richness_min_mean = colMeans(richness_min_df)
  richness_max_sd = apply(richness_max_df,2,sd) # Calculating standard deviations
  richness_min_sd = apply(richness_min_df,2,sd)
  richness_max_ci = qnorm(0.972)*richness_max_sd/sqrt(50) # Calculating confidence intervals
  richness_min_ci = qnorm(0.972)*richness_min_sd/sqrt(50)
  
  richness_max_upper = richness_max_mean + richness_max_ci
  richness_max_lower = richness_max_mean - richness_max_ci
  richness_min_upper = richness_min_mean + richness_min_ci
  richness_min_lower = richness_min_mean - richness_min_ci
  plot(richness_max_mean, frame.plot = F, type = "l", pch = 1, cex = 0.75, col = 1, ylim = c(0,100), ylab = "Diversity", xlab = "Generation", main = "Time Series Graph of a Neutral Model Simulation")
  lines(richness_min_mean, pch = 1, cex = 0.75, col = 2)
  suppressWarnings(for(i in 1:201){
    # Plotting confidence intervals
    arrows(x0 = i, y0 = as.numeric(richness_max_lower[i]), x1 = i, y1 = as.numeric(richness_max_upper[i]), code = 3, length = 0.01, col = 1)
    arrows(x0 = i, y0 = as.numeric(richness_min_lower[i]), x1 = i, y1 = as.numeric(richness_min_upper[i]), code = 3, length = 0.01, col = 2)
    # Using a t-test to look for the start of dynamic equilibrium (high p-value, no significant difference)
    diff = try(t.test(richness_max_df[,i], richness_min_df[,i])$p.value, silent = T)
    if(class(diff) != "try-error" && diff > 0.05){
      print(i)
    }
  })
  abline(v = 37)
  text("Reaching dynamic equilibrium\nat the 37th generation", x = 80, y = 80)
  legend('topright', c('richness_max','richness_min'), fill = c(1,2), bty = "n")
  
}

# Challenge question B
Challenge_B <- function() {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  plot(1, type="n", xlim=c(0, 201), ylim=c(0, 100), frame.plot = F, ylab = "Diversity", xlab = "Generation", main = "Time Series Graph of a Neutral Model Simulation") # initiating an empty plot
  richness_df = as.data.frame(matrix(NaN, nr = 50, nc = 201))
  for(i in 1:11){
    for(j in 1:50){
      community = c()
      set.seed(j)
      community_init = seq((i-1)*10)
      if(length(community_init)<100){
        community = c(community_init, sample(community_init, 100- length(community_init), replace = T))
      }else{
        community = community_init
      }
      richness = neutral_time_series_speciation(community = community, speciation_rate = 0.1, duration = 200)
      richness_df[j,] = richness
      }
    richness_mean = colMeans(richness_df)
    lines(richness_mean, pch = 1, cex = 0.75, col = i)
  }
  legend('topright', as.character(c(2, seq(10,100,10))), fill = 1:11, bty = "n", cex = 0.75, title = "Initial diversity")
}

# Challenge question C

mean_rich_cal <- function(i_start = 1, i_end = 25){
  if(i_end == 25) size = 500
  if(i_end == 50) size = 1000
  if(i_end == 75) size = 2500
  if(i_end == 100) size = 5000
  richness_df_min = 0; richness_df_max = 0
  for(i in i_start:i_end){
    load(paste("Neutral_cluster_", i, ".rda", sep = ""))
    richness_df_min = sum_vect(richness_df_min, richness_min)
    richness_df_max = sum_vect(richness_df_max, richness_max)
  }
  richness_mean_min = richness_df_min/25
  richness_mean_max = richness_df_max/25
  plot(1, type="n", xlim = c(0,length(richness_df_max)), ylim=c(0, size), frame.plot = F, ylab = "Diversity", xlab = "Generation", sub = paste("(Simulation size = ",size, ")"))
  lines(richness_mean_min, pch = 1, cex = 0.75, col = 1)
  lines(richness_mean_max, pch = 1, cex = 0.75, col = 2)
  legend('topright', c('richness_min','richness_max'), fill = c(1,2), bty = "n", y.intersp=0.7)
}

Challenge_C <- function() {
  graphics.off()# clear any existing graphs and plot your graph within the R window
  par(mfrow = c(2,2))
  mean_rich_cal(1,25)
  mean_rich_cal(26,50)
  mean_rich_cal(51,75)
  mean_rich_cal(76,100)
  title("Time Series Graph of a Neutral Model Simulation", outer = T, line = -1.5)
}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


