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
	n=0 #set a variable to determine whether or not exit the loop
	while [ $n = 0 ]
	do
		echo "please enter the name of your file or directory, to exit use Ctrl+C"
		read Name #Allow the user to enter a file/directory
		if [ -n "$Name" ] #If file/directory is inputted
		then
			n=1 #Exit the loop
		else #If file/directory is still not inputted
			n=$n #return to enter a file/directory
		fi
	done
#Check if the user entered a directory, change all files in the directory
	if [ -d "$Name" ] #If a directory is entered
	then
    	for i in *.csv;
    	do
        	echo "Creating a space separated version of $i ..."
        	cat $i | tr -s "," "\b" >> $i.txt
        	echo "Done!"
    	done
#Check whether the file exist
	elif [ -f "$Name" ] # if the input file exists
	then
#Check whether the file is empty
		if [ -s "$Name" ] #If the file is not empty
		then 
			echo "Creating a space separated version of $FileName ..."
            cat $Name | tr -s "," "\b" >> $Name.txt
            echo "Done!"
		else #If the file is empty
 			echo "Creating a space separated version of $FileName ..."
            cat $Name | tr -s "," "\b" >> $Name.txt
            echo "Done!"
			echo "Warning: File is empty"
		fi
	else #If the input file does not exist
		echo "File does not exist"
	fi
else #If user entered a name with bash command
#Check if the user entered a directory, change all files in the directory
	if [ -d "$1" ] #If a directory is entered
	then
    	for i in *.csv;
    	do
        	echo "Creating a space separated version of $i ..."
        	cat $i | tr -s "," "\b" >> $i.txt
        	echo "Done!"
    	done
	elif [ -f "$1" ] # if the file exist
    then
#Check whether the file is empty
		if [ -s "$1" ] #If the file is not empty
        then 
			echo "Creating a space separated version of $1 ..."
            cat $1 | tr -s "," "\b" >> $1.txt
            echo "Done!"
        else #If the file is empty
			echo "Creating a space separated version of $1 ..."
            cat $1 | tr -s "," "\b" >> $1.txt
            echo "Done!"
            echo "Warning: File is empty!"
        fi
    else #If the input file does not exist
        echo "File does not exist"
    fi
fi