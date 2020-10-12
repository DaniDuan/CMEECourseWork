#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate the contents of two files
# Arguements: 1 + 2 -> 3
# Date: Oct.2020

#Check if the first file name is entered
if [ -z "$1" ] # If no first file name entered
then echo "Please enter both file names and a name for your output file, seperated by space"
elif [ -z "$2" ] # If no second file name entered
then echo "Please also include the second file name"
elif [ -z "$3" ] # If no output file name entered
then echo "Please also include a third name for your output file"
else # If all file names are entered 
	cat $1 > $3 #Import the first file into the concatenated file
	cat $2 >> $3 #Append the second file to the concatenated file
	echo "merged file is"
	cat $3 #Display the concatenated file
fi
exit