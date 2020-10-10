#!/bin/bash

if [-z "$1"]
then echo "Please input the first file"
elif [-z "$2"]
then echo "Please input the second file"
else  
	cat $1 > $3
	cat $2 >> $3
	echo "merged file is"
	cat $3
fi
