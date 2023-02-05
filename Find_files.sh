#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Please invoke this script with one command-line arguments."
else
	echo "Script to find files in path given is : $1"
	echo "Number of files present in $1 path is :"
	ls -l | grep "^-"
fi
