#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the file with commas
#
# Save the output into a .csv file
# Arguements: 1 -> tab delimited file
# Date: Oct.2020 

#Check whether a file is inputted
if [ -z "$1" ] #If user did not enter the file name with bash command
then
	echo "Please enter a file name with bash command"
else #If user entered the file name with bash command
	if [ -f "$1" ] # if the file exist
    then
#Check whether its already a csv file
	    if [ $1 == *.csv ] #If the input file is already a csv file
        then
	        echo "Already a csv file"
#Check whether the file is empty
        else #If the input file is not a csv file
			if [ -s "$1" ] #If the file is not empty
            then 
                echo "Creating a comma delimited version of $1"
                cat $1 | tr -s "\t" "," >> $1.csv
                echo "done!"
#Check whether the file is empty
            else #If the file is empty
                echo "File is empty!"
            fi
        fi
    else #If the input file does not exist
        echo "File does not exist"
    fi
fi
exit