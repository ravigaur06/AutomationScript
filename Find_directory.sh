#!/bin/bash
echo "Enter path name where you want to find number of directory : $1"

echo "Number of Directory present in $1 path is :" 

ls -l $1 | grep -E "^d"
