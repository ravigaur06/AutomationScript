#!/bin/bash

if [ $# -eq 0 ]
then 
	echo "Please invoke this script with one command-line arguments."
else
	echo "Enter path name where you want to find number of directories : $1"
	echo "Number of Directory present in $1 path is :"
	ls -l $1 | grep -E "^d"
fi
