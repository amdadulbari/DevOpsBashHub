#!/bin/bash

# This script monitors specified mount points for disk usage in a Linux system, checking if the usage exceeds a predefined threshold (90%).
# If you are using this script, you can star this repo ;)

# Configuration: Add your mount points here
MOUNT_POINTS=("/" "/home" "/var")

# Threshold for alert (90% in this case)
THRESHOLD=90

for mount in "${MOUNT_POINTS[@]}"; do
	# Get the current usage percentage of the mount point
	usage=$(df -h | awk '$NF=="'"$mount"'" { print $5 }' | sed 's/%//g')

	# Check if usage is a number and greater than or equal to the threshold
	if [[ "$usage" =~ ^[0-9]+$ ]] && [ "$usage" -ge "$THRESHOLD" ]; then
		echo "Alert: Storage usage on mount point $mount is at $usage%"
		# Add any alert mechanism here, e.g., send an email or trigger a notification
	fi
done
