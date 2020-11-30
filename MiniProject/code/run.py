import subprocess


subprocess.Popen(["Rscript", "Thermal.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)



subprocess.os.system("pdflatex yourlatexdoc.tex")