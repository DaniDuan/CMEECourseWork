# CMEE 2020 HPC excercises R code HPC run code proforma

rm(list=ls()) # good practice 
graphics.off()
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
# iter = 1

source("DaniDuan_HPC_2020_main.R")

if(iter <= 25){size = 500
  }else if(iter > 25 && iter <= 50){size = 1000
  }else if(iter > 50 && iter <= 75){size = 2500
  }else{size = 5000}

set.seed(iter)
cluster_run(speciation_rate = 0.005413, size = size, wall_time=0.25, interval_rich=1,
            interval_oct=size/10, burn_in_generations=8*size,
            output_file_name= paste("Neutral_cluster_", iter, ".rda", sep = ""))
