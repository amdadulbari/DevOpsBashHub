#!/bin/bash
# This script monitor and log CPU and memory usage of Docker containers.
# If you are using this script, you can star this repo ;)

# Interval in seconds between checks
interval=60

# Log file for resource usage
log_file="docker_resource_usage.log"

# Function to log CPU and memory usage of all running containers
log_container_usage() {
	echo "Logging CPU and Memory usage of Docker containers every $interval seconds..."
	echo "Timestamp, Container ID, Container Name, CPU %, Memory Usage, Memory %, Network I/O, Block I/O" >"$log_file"

	while true; do
		# Get the current timestamp
		current_time=$(date '+%Y-%m-%d %H:%M:%S')

		# Fetch stats from all running containers and prepend the timestamp
		docker stats --no-stream --format "$current_time, {{.Container}}, {{.Name}}, {{.CPUPerc}}, {{.MemUsage}}, {{.MemPerc}}, {{.NetIO}}, {{.BlockIO}}" >>"$log_file"

		# Wait for the specified interval
		sleep "$interval"
	done
}

# Execute the function
log_container_usage
