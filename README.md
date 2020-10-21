# My CMEE Coursework Repository

## Description

This repository contains **codes**, **data files** and **generated results** of CMEE Coursework, including basic computing and data analysis and statistics based on [The Multilingual Quantitative Biologist](https://mhasoba.github.io/TheMulQuaBio/intro.html#) book; organize on weekly basis and update on daily basis.

## Languages

- [x] Bash;
- [x] Python;
- [ ] R

## Dependencies

For some scripts [imagemagick](https://imagemagick.org/index.php) installation is required.

```bash
sudo apt install imagemagick
```
[LaTeX](https://www.latex-project.org/) installation is required (which is a large installation):
```bash
sudo apt install texlive-full texlive-fonts-recommended texlive-pictures texlive-latex-extra imagemagick
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

<br/>

- [x] Week2

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

<br/>

- [ ] Week3

Biological Computing in **R**: 

<br/>

### Chapter 2: Data analysis and statistics

<br/>


## Author name and contact

Name: Danica Duan

Email: d.duan20@imperial.ac.uk