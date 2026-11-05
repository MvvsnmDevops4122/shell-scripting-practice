#!/bin/bash

# Execute the df command to retrieve disk utilization details.
disk_usage=$(df -hT | grep -v Filesystem)

usage_threshold=20

#Read the command output line by line.
while IFS= read -r line; 
do
   usage=$(echo "$line" | awk '{print $6}' | cut -d'%' -f1) 
   partition=$(echo "$line" | awk '{print $7}')

   #Check whether the disk usage exceeds the 75% threshold.#If usage is greater than 75%, identify the partition.
   if [ "$usage" -ge "$usage_threshold" ]; then
      mesaage+="High disk usage on ${partition}: ${usage}\n"
   fi
done <<< "$disk_usage"




#If usage is greater than 75%, identify the partition.
#Send an email alert with the partition details and disk usage percentage.