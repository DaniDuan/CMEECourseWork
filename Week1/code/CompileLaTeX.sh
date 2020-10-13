#!/bin/bash
x=${1%.tex}
pdflatex $x.tex
pdflatex $x.tex
bibtex $x.bib
pdflatex $x.tex
pdflatex $x.tex
evince $x.pdf &

## Cleanup
rm *~
rm *.aux
rm *.dvi
rm *.log
rm *.nav
rm *.out
rm *.snm
rm *.toc