#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: tiff2png.sh
# Description: Convert tiff to png
# Arguements: none
# Date: Oct.2020

#Check if something is entered with bash command
if [ -z "$1" ] 
then
	echo "Please enter an image name or a directory with bash command!"
else
#Check if the user entered a directory, change all tif in the directory
	if [ -d "$1" ]
	then
    	for f in $1/*.tif;
		do 
			echo "converting $f";
			convert "$f" "${f%tif}png" ;
			echo "Done!"
		done
	elif [ -f "$1" ]
    then
#Check if the entered file is an image		
		if identify $1 &> /dev/null #With ImageMagick
		then
			echo "converting $1";
			convert "$1" "${1%tif}png" ;
			echo "Done!"
		else
			echo "Input is not an image"
		fi
	else 
        echo "File does not exist"
    fi
fi
#exit