#!/bin/bash

# Target server to test latency
TARGET_SERVER="www.google.com" # Change this to your target server

# Interval in seconds between each ping test
INTERVAL=10

# Log file to store results
LOG_FILE="latency.txt"

# Function to perform ping and log latency
ping_server() {
	local date=$(date +"%Y-%m-%d %H:%M:%S")
	local latency=$(ping -c 1 $TARGET_SERVER | grep 'time=' | awk -F'=' '{ print $4 }' | awk '{ print $1 }')

	if [ -z "$latency" ]; then
		echo "$date: Failed to ping $TARGET_SERVER" >>"$LOG_FILE"
	else
		echo "$date: Latency to $TARGET_SERVER is $latency ms" >>"$LOG_FILE"
	fi
}

# Main loop
while true; do
	ping_server
	sleep $INTERVAL
done