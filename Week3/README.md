# Coursework for CMEE: Week 3

## Description

This Week3 directory contains R scripts and programs for coursework in **Biological Computing in R** section of the Computing Chapter and **Data Management and Visualization** section of Basic Data Analysis and Statistics Chapter of [The Multilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html) book.

## Languages

R

## Dependencies

For some scripts in this directory, packages [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [maps](https://cran.r-project.org/web/packages/maps/index.html), and [sqldf](https://cran.r-project.org/web/packages/sqldf/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("tidyverse", "ggplot2", "reshape2", "maps", "sqldf"))
```

[LaTeX](https://www.latex-project.org/) installation is also required. Please run following **bash** script in Linux Terminal for installation:
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```
## Installation

To use scripts in this directory clone the repository and run.

```bash
git clone https://github.com/DaniDuan/CMEECourseWork.git
```

## Project structure and Usage 

### Biological Computing in R:

- **basic_io.R:** A simple script to illustrate R input-output.

- **boilerplate.R:** A boilerplate R script for demonstrating R functions.

- **break.R:** R loop demonstration.

- **TAutoCorr.R:** Calculation and plot for Practical: Autocorrelation in weather. 

- **Autocorrelation.tex:** Source code for results and interpretation for Practical: Autocorrelation in weather.

- **Autocorrelation.pdf:** Results and interpretation for Practical: Autocorrelation in weather.

- **control_flow.R:** Demonstrating control flow tools.

- **Ricker.R:** Runs a simulation of the Ricker model

- **sample.R:** An example of vectorization involving lapply and sapply

- **TreeHeight.R:** Calculating heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula.

- **Vectorize2.R:** Runs the stochastic Ricker equation with Gaussian fluctuations. 

<br/>

### Data Management and Visualization: 

- **DataWrang.R**: Data manipulation for PoundHillData with reshape2 package. 

- **DataWrangTidy.R:** Data manipulation for PoundHillData with functions from tidyr and dplyr packages instead of reshape2.

- **Girko.R:** Plotting the Girko’s law simulation.

- **GPDD_Data.R:** Mapping the Global Population Dynamics Database (GPDD).

- **MyBars.R:** Demonstration for plot annotation. 

- **plotLin.R:** Demonstration for mathematical annotation on a axis, and in the plot area.

- **PP_Dists.R:** Creating three figures, each containing subplots of distributions of predator mass, prey mass, and the size ratio of prey mass over predator mass by feeding interaction type. And calculating the mean and median log predator mass, prey mass, and predator-prey size ratio, by feeding type. 

- **PP_Regress.R:** Plotting analysis subsetted by the Predator.lifestage, and calculate the regression results corresponding to the lines fitted. 


## Author name and contact

Name: Danica Duan

Email: d.duan20@imperial.ac.uk