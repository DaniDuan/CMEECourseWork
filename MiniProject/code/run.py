'''Running R script and compiling latex'''
__appname__ = "run.py"
__author__ = "Danica Duan (dd1820@ic.ac.uk)"
__version__ = "0.0.1"

import subprocess

subprocess.os.system("Rscript Thermal.R")
subprocess.os.system("bash CompileLaTeX.sh Miniproject_report")
