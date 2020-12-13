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
  community[index[1]] = community[index[2]]
  return(community)
}

# Question 6
neutral_generation <- function(community = c(1,5,2,6,8,13,25)){
  for(i in 1:floor(length(community)/2)) community = neutral_step(community)
  return(community)
}

# Question 7
neutral_time_series <- function(community = init_community_max(7) , duration = 20)  {
  richness = c(species_richness(community))
  for(i in 1:duration){ 
    community = neutral_generation(community)
    richness = c(richness, species_richness(neutral_generation(community)))
  }
  return(richness)
}

# Question 8
question_8 <- function() {
  richness = neutral_time_series(community = init_community_max(100), duration = 200)
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
    community[index[1]] = max(community) + 1
  }else{
    community[index[1]] = community[index[2]]
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
    community = neutral_generation_speciation(community, speciation_rate)
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
  return(sort(as.data.frame(table(community))[,2],decreasing = T))
}

# Question 14
octaves <- function(abundance_vector = c(100,64,63,5,4,3,2,2,1,1,1,1)) {
  return(tabulate(floor(log2(abundance_vector))+1))
}

# Question 15
sum_vect <- function(x = c(1,3), y = c(1,0,5,2)) {
  if(length(x) < length(y)){
    x = c(x, rep(0, (length(y)-length(x))))
  }else{
    y = c(y, rep(0, (length(x)-length(y))))
  }
  return(x+y)
}

# Question 16 
question_16 <- function()  {
  octave_max = 0
  octave_min = 0
  community_max = init_community_max(100)
  community_min = init_community_min(100)
  for(i in 1:2200){ 
    community_max = neutral_generation_speciation(community = community_max, speciation_rate = 0.1)
    community_min = neutral_generation_speciation(community = community_min, speciation_rate = 0.1)
    if(i >= 200 & (i-200) %% 20 == 0){
      abundance_max = species_abundance(community_max)
      octave_max = sum_vect(octave_max, octaves(abundance_max))
      abundance_min = species_abundance(community_min)
      octave_min = sum_vect(octave_min, octaves(abundance_min))
    }
  }
  octave_max_mean = octave_max/101
  octave_min_mean = octave_min/101
  data = rbind(octave_max_mean,octave_min_mean)
  colnames(data) = c("1","2-3","4-7","8-15","16-31","32-64")
  graphics.off()# clear any existing graphs and plot your graph within the R window
  barplot(data, beside = T, ylab = "Number of Species", ylim = c(0,11), xlab = "Species Abundance", main = "Species Abundance Octave of Neutral Model Simulation",col = c(0,1))
  legend("topright", c("octave_max", "octave_min"), fill = c(0,1), bty = "n")
  return("Initial condition of the system does not matter, since this calculation was conducted after the system has already reached its dynamic equilibrium which is related to the speciation rate.")
}

# Question 17
cluster_run <- function(speciation_rate = 0.1, size=100, wall_time=0.25, interval_rich=1,
                        interval_oct=10, burn_in_generations=200,
                        output_file_name="my_test_file_1.rda")  {
  start_time = proc.time()[3]
  community_max = init_community_max(size)
  community_min = init_community_min(size)
  richness_max = c(species_richness(community_max))
  richness_min = c(species_richness(community_min))
  i = 0
  repeat{
    community_max = neutral_generation_speciation(community = community_max, speciation_rate = 0.1)
    community_min = neutral_generation_speciation(community = community_min, speciation_rate = 0.1)
    abundance_max = species_abundance(community_max)
    abundance_min = species_abundance(community_min)
    i = i + 1
    if(i <= burn_in_generations && (i - burn_in_generations) %% interval_rich == 0){
      richness_max = c(richness_max, species_richness(neutral_generation_speciation(community_max, speciation_rate)))
      richness_min = c(richness_min, species_richness(neutral_generation_speciation(community_min, speciation_rate)))
      octave_max = list(octaves(abundance_max))
      octave_min = list(octaves(abundance_min))
    }else{
      if((i - burn_in_generations) %% interval_oct == 0){
        octave_max[[(i - burn_in_generations)/interval_oct + 1]] = octaves(abundance_max)
        octave_min[[(i - burn_in_generations)/interval_oct + 1]] = octaves(abundance_min)
      }
    }
    if(proc.time()[3]-start_time >= 60*wall_time) {break}
  }
  time_spent = proc.time()[3]-start_time
  input_parameters = list(speciation_rate = 0.1, size=100, wall_time=10, interval_rich=1, interval_oct=10, burn_in_generations=200)
  save(richness_max, richness_min, octave_max, octave_min, community_max, community_min, time_spent, input_parameters,  file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  
}

plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    # load combined_results from your rda file
    # plot the graphs
    
    return(combined_results)
}

# Question 21
question_21 <- function(size = 8, width = 3)  {
    dimension = log(size)/log(width)
    explanation = "In order for the squares to be three times as wide, 8 times the amount of material is needed, and width^dimension = size"
    answer21 = list(dimension, explanation)
  return(answer21)
}

# Question 22
question_22 <- function(size = 20, width = 3)  {
  dimension = log(size)/log(width)
  explanation = "In this case, 20 times amount of material is needed for the squares to be 3 times as wide, therefore the dimension is calculated as log(20)/log(3)"
  answer22 = list(dimension, explanation)
  return(answer22)
}

# Question 23
chaos_game <- function(x = c(0,3,4), y = c(0,4,1), X = c(0,0), max_time = 15)  {
  start_time = proc.time()[3]
  graphics.off()# clear any existing graphs and plot your graph within the R window
  xy = data.frame(x,y)
  plot(xy, xlab = "", ylab = "")
  text(0,0.3,"A")
  text(3.2,4,"B")
  text(4,0.7, "C")
  points(X[1],X[2], pch = 19, cex = 0.001)
  repeat{
    a = sample(3,1)
    X = c((X[1]+xy[a,1])/2, (X[2]+xy[a,2])/2)
    points(X[1],X[2], pch = 19, cex = 0.001)
    if(proc.time()[3]-start_time >= max_time){break}}
  return("Given enough times of iteration, a Sierpinski Gasket triangle was generated, in which for every triangle pattern to be 2 times as wide, 3 times amount of the material is needed, therefore has a dimension of log(3)/log(2) = 1.584963.")
}

# Question 24
turtle <- function(start_position, direction, length)  {
    
  return() # you should return your endpoint here.
}

# Question 25
elbow <- function(start_position, direction, length)  {
  
}

# Question 26
spiral <- function(start_position, direction, length)  {
  
  return("type your written answer here")
}

# Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  
}

# Question 28
tree <- function(start_position, direction, length)  {
  
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 29
fern <- function(start_position, direction, length)  {
  
}

draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Question 30
fern2 <- function(start_position, direction, length)  {
  
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window

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


