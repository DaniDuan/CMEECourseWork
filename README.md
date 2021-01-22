# My CMEE Coursework Repository

## Description

This repository contains **codes**, **data files** and **generated results** of CMEE Coursework, including basic computing and data analysis and statistics based on [The Multilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html#) book; organize on weekly basis and update on daily basis.

## Languages

- [x] Bash;
- [x] Python;
- [x] R

## Dependencies

For some scripts [imagemagick](https://imagemagick.org/index.php) installation is required.

```bash
sudo apt install imagemagick
```
[LaTeX](https://www.latex-project.org/) installation is required (which is a large installation):
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```

For some scripts in Week3 directory, R packages [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html), [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [maps](https://cran.r-project.org/web/packages/maps/index.html), [sqldf](https://cran.r-project.org/web/packages/sqldf/index.html) and [minpack.lm](https://cran.r-project.org/web/packages/minpack.lm/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("tidyverse", "ggplot2", "reshape2", "maps", "sqldf", "minpack.lm"))
```

## Installation

To use scripts in this repository, clone and run.

```bash
git clone https://github.com/DaniDuan/CMEECourseWork.git
```

## Project structure and Usage 

### Chapter 1: Computing
- [x] **Week1**

Shell scripts for courseworks in **shell scripting** and scientific documents with **LaTex** :

- **CompileLaTeX&#46;sh:** A bash script to compile latex with bibtex.

- **ConcatenateTwoFiles&#46;sh:** Concatenate the contents of two files.

- **countlines&#46;sh:** Count number of lines in a file.

- **csvtospace&#46;sh:** Converts a comma separated values (csv) file to a space separated values file (txt); or convert all csv files in the input directory to space separated txt files.

- **MyExampleScript&#46;sh:** A welcome message prints out Hello $User(user name).

- **tabtocsv&#46;sh:** Transform comma-separated files (csv) to tab-separated files. 

- **tiff2png&#46;sh:** Convert a .tif image into .png image; or convert all .tif images in the input directory to .png files.

- **variables&#46;sh**: Examples for usage of variables. 

- **UnixPrac1.txt:** UNIX shell commands with certain functions for reading .fasta files (in the data directory). 

<br>

- [x] **Week2**

Biological computing in **Python** :

- **align_seqs.py:** Aligns two DNA sequences, returns the best match, and count the “score” as total of number of bases matched.

- **cfexercises1&#46;py:** Creating easy functions for calculating square root, ranking numbers and calculating the factorial.

- **control_flow.py:** An example of a script that uses various control flow tools within a standard python program structure.

- **dictionary&#46;py:** Populating taxa_dic dictionary derived from taxa, maping order names to sets of taxa.

- **lc1&#46;py:** Creating lists from *birds* data upon requirements using comprehension and loops.

- **lc2&#46;py:** Creating lists from *rainfall* data upon requirements using comprehension and loops.

- **oaks_debugme.py**: Output taxa that are oak trees from a list of species, and debug the written function. 

- **oaks&#46;py:** Find taxa that are oak trees from a list of species.

- **scope&#46;py:** blocks of code illustrating variable scope.

- **test_ontrol_flow&#46;py:** Docstring debugging on control_flow.py.

- **tuple&#46;py:** Output block by species on tuple Birds. 

<br>

- [x] **Week3**

Biological Computing in **R**: 

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


<br>

- [x] **Week7**

- **blackbirds&#46;py:** Outputting bird's kingdom, phylum and species from dataset using regular expression.

- **fmr.R:** Plots log(field metabolic rate) against log(body mass) for the Nagy et al 1999 dataset to a file fmr.pdf.

- **LV1&#46;py:** Fitting the Lotka-Volterra model and generating population dynamics graphs.

- **LV2&#46;py:** Fitting the Lotka-Volterra model and generating population dynamics graphs with input values from the command line.

- **NC&#46;py:** Script for numerical computing in Python.

- **profileme&#46;py:** Script for using Python profiling to find out what is slowing down the code.

- **profileme2&#46;py:** Script for using Python profiling to find out what is slowing down the code - Converted the loop to a list comprehension, replaced .join with an explicit string concatenation. 

- **Regular_expressions&#46;py:** Script for explaining regular expressions.

- **run_fmr_R&#46;py:** Runs fmr.R to generate the desired result and print to the python screen whether the run was successful, and the contents of the R console output..

- **run_LV&#46;py:** Runs both LV1.py and LV2.py with appropriate arguments.

- **timeitme&#46;py:** Using timeit to test loops vs. list comprehensions: which is faster? 

- **using_os.py:** Use the subprocess.os module to get a list of files and directories from a certain path with or without a given condition.

- **vectorization&#46;py:** Showing the difference in runtime between a loop method and a vectorized method using numpy.

- **workflow&#46;py:** Using Python to build workflows.

<br>

### Chapter 2: Data analysis and statistics

- [x] **Week3**

Data Management and Visualization: 

- **DataWrang.R**: Data manipulation for PoundHillData with reshape2 package. 

- **DataWrangTidy.R:** Data manipulation for PoundHillData with functions from tidyr and dplyr packages instead of reshape2.

- **Girko.R:** Plotting the Girko’s law simulation.

- **GPDD_Data.R:** Mapping the Global Population Dynamics Database (GPDD).

- **MyBars.R:** Demonstration for plot annotation. 

- **plotLin.R:** Demonstration for mathematical annotation on a axis, and in the plot area.

- **PP_Dists.R:** Creating three figures, each containing subplots of distributions of predator mass, prey mass, and the size ratio of prey mass over predator mass by feeding interaction type. And calculating the mean and median log predator mass, prey mass, and predator-prey size ratio, by feeding type. 

- **PP_Regress.R:** Plotting analysis subsetted by the Predator.lifestage, and calculate the regression results corresponding to the lines fitted. 

### The Miniproject

- **Thermal.R:** the main script for running all model simulations and data analysis on four thermal performance models (cubic, quadratic, Briere and Schoolfield models).

- **Miniproject_report.tex**: the Latex file for the report. 

- **CompileLaTeX&#46;sh**: the shell script for generating the Latex report. 

- **run&#46;py**: the python script for running the entire project. 

## Author name and contact

Name: Danica Duan

Email: d.duan20@imperial.ac.uk