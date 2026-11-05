#!/bin/bash

# Execute the df command to retrieve disk utilization details.
disk_usage=$(df -hT | grep -v Filesystem)
server_ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
usage_threshold=20

# Read the command output line by line.
while IFS= read -r line;
do
   usage=$(echo "$line" | awk '{print $6}' | cut -d'%' -f1)
   partition=$(echo "$line" | awk '{print $7}')

   # Check whether the disk usage exceeds the threshold.
   # If usage is greater than the threshold, identify the partition.
   if [ "$usage" -ge "$usage_threshold" ]; then
      message+="High disk usage on ${partition}: ${usage}\n"
   fi
done <<< "$disk_usage"

#echo -e "$message"

# Send an email alert with the partition details and disk usage percentage.
sh 26-mail.sh "DevOps Team" "$server_ip" "High Disk Usage" "$message" "satyamolleti4599@gmail.com" "WARNING: High Disk Usage Alert"

