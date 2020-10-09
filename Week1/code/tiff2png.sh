#!/bin/bash

for f in *.tif;
do 
echo "converting $f";
convert "$f"	"$(basename "$f".tif).jpg";
done
