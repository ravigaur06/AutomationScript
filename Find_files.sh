#/bin/bash
echo "Script to find files in current directory."
ls -l | grep "^-"
echo "Number of files in current directory are : " | ls -l | grep "^-" | wc -l
