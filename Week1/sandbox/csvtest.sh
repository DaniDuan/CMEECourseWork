#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: csvtospace.sh
# Description: substitute the commas in the file with spaces
#
# Save the output into a a space separated .txt file
# Arguements: 1 -> txt delimited file
# Date: Oct.2020 


if [ -d "$1" ]
    for i in *.csv;
    do
        echo "Creating a space separated version of $i ..."
        cat $i | tr -s "," "\b" >> $i.txt
        echo "Done!"
    done


if [ -z "$1" ] #If user did not enter the file name with bash command
then
	n=0 #set a variable to determine whether or not exit the loop
	while [ $n = 0 ]
	do
		echo "please enter a file name"
		read FileName #Allow the user to enter a file name
		if [ -n "$FileName" ] #If file name is inputted
		then
			n=1 #Exit the loop
		else #If file name is still not inputted
			n=$n #return to enter a file name
		fi
	done
#Check whether the file exist
	if [ -f "$FileName" ] # if the input file exists
	then
#Check whether the input file is already a csv file
		if [ $FileName == *.csv ] #If the input file is already a csv file
		then
       			echo "Already a csv file"
#Check whether the file is empty
		else #If the input file is not a csv file
			if [ -s "$FileName" ] #If the file is not empty
			then 
				echo "Creating a space separated version of $FileName ..."
                cat $FileName | tr -s "," "\b" >> $FileName.txt
                echo "Done!"
			else #If the file is empty
 				echo "File is empty"
			fi
		fi
	else #If the input file does not exist
		echo "File does not exist"
	fi
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
				             echo "Creating a space separated version of $1 ..."
                             cat $1 | tr -s "," "\b" >> $1.txt
                             echo "Done!"
#Check whether the file is empty
                        else #If the file is empty
                                echo "File is empty!"
                        fi
                fi
        else #If the input file does not exist
                echo "File does not exist"
        fi
fi