################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################
detach("package:reshape2", unload =T) # unload the reshape2 package
############# Load the dataset ###############
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")
MyMetaData
############# Inspect the dataset ###############
head(MyData)
dim(MyData)
str(MyData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

############# Replace species absences with zeros ###############
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

############# Convert from wide to long format  ###############

#MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

#tidyr gather
MyWrangledData2=gather(TempData,key = "Species", value = "Count", 5:ncol(TempData))

#dplyr mutate
MyWrangledData2 = MyWrangledData2 %>% mutate(Cultivation = as.factor(Cultivation), Block=as.factor(Block), Plot=as.factor(Plot), Quadrat=as.factor(Quadrat), Count= as.numeric(Count))

str(MyWrangledData2)
head(MyWrangledData2)
dim(MyWrangledData2)


############# Exploring the data (extend the script below)  ###############

require(tidyverse)
tidyverse_packages(include_self = T)
tibble::as_tibble(MyWrangledData)
dplyr::glimpse(MyWrangledData)
dplyr::filter(MyWrangledData, Count>100)
dplyr::slice(MyWrangledData,10:15)
