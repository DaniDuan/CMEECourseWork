#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: tiff2png.sh
# Description: Convert tiff to png
# Arguements: none
# Date: Oct.2020


for f in *.tif;
do 
	echo "converting $f";
	convert "$f" "$(basename "$f" .tif).png";
done
