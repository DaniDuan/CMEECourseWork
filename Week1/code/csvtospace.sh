#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the file with spaces
#
# Save the output into a a space separated .txt file
# Arguements: 1 -> txt delimited file
# Date: Oct.2020 



if [ -z "$1" ] #If user did not enter the file name with bash command
then
	echo "Please enter a file name or a directory with bash command!"
else #If user entered a name with bash command
#Check if the user entered a directory, change all files in the directory
	if [ -d "$1" ] #If a directory is entered
	then
    	for i in $1/*.csv;
    	do
        	echo "Creating a space separated version of $i ..."
        	output="${i%csv}txt"
			cat $i | tr -s "," "\b" >> $output
        	echo "Done!"
    	done
	elif [ -f "$1" ] # if the file exist
    then
		#Check whether the file is empty
		if [ -s "$1" ] #If the file is not empty
        then 
			echo "Creating a space separated version of $1 ..."
			output="${1%csv}txt"
            cat $1 | tr -s "," "\b" >> $output
            echo "Done!"
        else #If the file is empty
			echo "Creating a space separated version of $1 ..."
			output="${1%csv}txt"
            cat $1 | tr -s "," "\b" >> $output
            echo "Done!"
            echo "Warning: File is empty!"
        fi
    else #If the input file does not exist
        echo "File does not exist"
    fi
fi
exit
