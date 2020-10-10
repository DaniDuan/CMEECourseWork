#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the file with commas
#
# Save the output into a .csv file
# Arguements: 1 -> tab delimited file
# Date: Oct.2020

echo "Creating a comma delimited version of $1 ..."

if [ -z "$1" ]
then
	echo "Please input a txt file"

elif [ $1 == *.csv ]
then
        	echo "Already a csv file"

elif [ -s "$1" ]
then 
	cat $1 | tr -s "\t" "," >> $1.csv
        echo "done!"

else 
    	echo "File is empty"

fi
