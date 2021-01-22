# Coursework for CMEE: Miniproject

## Description

This Miniproject directory contains R, Python scripts for running model simulations and analysis.

## Languages

R, Python, Shell

## Dependencies

or some scripts in this directory, packages [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html) and [minpack.lm](https://cran.r-project.org/web/packages/minpack.lm/index.html) are required. 
Please run the following script in **R/RStudio** for package installation: 
```R
install.packages(c("ggplot2", "reshape2", "minpack.lm"))
```

[LaTeX](https://www.latex-project.org/) installation is required. Please run following **bash** script in Linux Terminal for installation:
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```
## Installation

To use scripts in this directory clone the repository and run.

```bash
git clone https://github.com/DaniDuan/CMEECourseWork.git
```

## Project structure and Usage
- **Thermal.R:** the main script for running all model simulations and data analysis on four thermal performance models (cubic, quadratic, Briere and Schoolfield models).

- **Miniproject_report.tex**: the Latex file for the report. 

- **CompileLaTeX&#46;sh**: the shell script for generating the Latex report. 

- **run&#46;py**: the python script for running the entire project. 

## Author name and contact

Name: Danica Duan

Email: d.duan20@imperial.ac.uk