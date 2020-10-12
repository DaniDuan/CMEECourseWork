#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: countlines.sh
# Description: Count lines in a file
# Arguements: none
# Date: Oct.2020

#Check whether a file is inputted
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
	Numlines=`wc -l < $FileName` #Set a variable for lines counting in a file
	echo "The file $FileName has $NumLines lines"
	echo
else #If user entered the file name with bash command
	Numlines=`wc -l < $1` #Set a variable for lines counting in a file
	echo "The file $1 has $Numlines lines"
fi
