#!/bin/bash

# This Bash script monitors specified critical processes on a server
# and automatically attempts to restart them if they are not running
# If you are using this script, you can star this repo ;)

# Configuration: Add the names of the processes to monitor
# Format: "service_name:restart_command"
# Example: "apache2:service apache2 start"
PROCESSES_TO_MONITOR=("apache2:service apache2 start" "dockerd:service docker start")

# Function to check and restart the process if not running
check_and_restart_process() {
	local process_name=$1
	local restart_command=$2

	# Check if the process is running
	if ! pgrep -x "$process_name" >/dev/null; then
		echo "Process $process_name is not running. Attempting to restart."
		# Attempt to restart the process
		eval $restart_command

		# Check if restart was successful
		if ! pgrep -x "$process_name" >/dev/null; then
			echo "Failed to restart $process_name. Sending alert."
			# Send alert (to be implemented as per requirement)
		else
			echo "Successfully restarted $process_name."
		fi
	else
		echo "Process $process_name is running."
	fi
}

# Iterate through each process to monitor
for entry in "${PROCESSES_TO_MONITOR[@]}"; do
	IFS=":" read process_name restart_command <<<"$entry"
	check_and_restart_process "$process_name" "$restart_command"
done
