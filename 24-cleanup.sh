#!/bin/bash

# Check whether user passed source directory or not?
# Check source directory exists or not?
# find the .log files older than 14 days in the source directory.
# If found, delete the file and print the deleted file name on the screen

source_dir=$1
days=${2:-14} # Default value of days is 14 if not provided by user
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

usage(){
    echo -e "${R}USAGE:: $0 [SOURCE_DIR] [days(Optional, default to 14 days)]${N}"
    exit 1
}

# Check whether user passed source directory or not?

if [ -z "$source_dir" ]; then
  echo "ERROR:: Missing parameters. Please provide source directory path."
  usage
fi

# Check source directory exists or not?

if [ ! -d "$source_dir" ]; then
   echo -e "${R}ERROR:: $source_dir does not exist${N}"
fi

# find the .log files older than 14 days in the source directory.

echo "Scanning files older than $days in $source_dir"
files_to_delete=$(find $source_dir -name "*.log" -type f -mtime +$days)

if [ -z "$files_to_delete" ]; then
    echo "No log files found older than $days"
    exit 0
fi

while IFS= read -r line
do
    echo "File is going to be deleted: $line"
done <<< "$files_to_delete" # <<< means input as a variable