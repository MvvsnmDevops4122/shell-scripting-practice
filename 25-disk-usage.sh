#!/bin/bash

disk_usage=$(df -hT | grep -v Filesystem)


# Execute the df command to retrieve disk utilization details.
while IFS= read -r line; 
do
   usage=$(echo "$line" | awk '{print $6}' | cut -d'%' -f1) 
done <<< "$disk_usage"

#Read the command output line by line.
#Check whether the disk usage exceeds the 75% threshold.
#If usage is greater than 75%, identify the partition.
#Send an email alert with the partition details and disk usage percentage.