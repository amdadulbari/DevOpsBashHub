#!/bin/bash

# Function to log a message with a timestamp similar to Spring Boot format
log_message() {
	local log_level=$1
	local log_message=$2
	local log_file=$3
	local timestamp=$(date +"%Y-%m-%d %H:%M:%S.%3N")
	local process_id=$$

	# Format: [Timestamp]  LOG_LEVEL [ProcessID --- : Log Message
	echo "$timestamp  $log_level $process_id : $log_message" >>"$log_file"
}