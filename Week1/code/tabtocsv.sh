#!/bin/bash
# Author: Danica dd1820@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the file with commas
#
# Save the output into a .csv file
# Arguements: 1 -> tab delimited file
# Date: Oct.2020

echo "creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.txt
echo "done!"

exit
