# Coursework for CMEE: Week 1

## Description

This Week1 directory contains shell scripts for coursework in **shell scripting** and scientific documents with **LaTex** sections of the Computing Chapter of [The Multilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html) book.

## Languages

Bash

## Dependencies

For some scripts in this directory [imagemagick](https://imagemagick.org/index.php) installation is required.

```bash
sudo apt install imagemagick
```
[LaTeX](https://www.latex-project.org/) installation is required:
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
```


## Installation

To use scripts in this directory clone the repository and run.

```bash
git clone https://github.com/DaniDuan/CMEECourseWork.git
```

## Project structure and Usage 

- **CompileLaTeX&#46;sh:** A bash script to compile latex with bibtex.

- **ConcatenateTwoFiles&#46;sh:** Concatenate the contents of two files.

- **countlines&#46;sh:** Count number of lines in a file.

- **csvtospace&#46;sh:** Converts a comma separated values (csv) file to a space separated values file (txt); or convert all csv files in the input directory to space separated txt files.

- **MyExampleScript&#46;sh:** A welcome message prints out Hello $User(user name).

- **tabtocsv&#46;sh:** Transform comma-separated files (csv) to tab-separated files. 

- **tiff2png&#46;sh:** Convert a .tif image into .png image; or convert all .tif images in the input directory to .png files.

- **variables&#46;sh**: Examples for usage of variables. 

- **UnixPrac1.txt:** UNIX shell commands with certain functions for reading .fasta files (in the data directory). 

## Author name and contact

Name: Danica Duan

Email: d.duan20@imperial.ac.uk