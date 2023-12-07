#!/bin/bash

# This Bash script automates the rotation and compression of log files in a specified directory, archiving them as tar.gz files.
#It also manages log retention by deleting archives older than a configurable number of days, defaulting to 7 days.

# If you are using this script, you can star this repo ;)

# Define the log directory and archive directory
LOG_DIR="/path/to/log/directory"
ARCHIVE_DIR="/path/to/archive/directory"
# Number of days to keep the log archives
DAYS_RETENTION=7

# Ensure the archive directory exists
mkdir -p "$ARCHIVE_DIR"

# Get the current date in YYYYMMDD format
CURRENT_DATE=$(date +"%Y%m%d")

# Rotate and compress logs
for log in "$LOG_DIR"/*.log; do
	[ -e "$log" ] || continue
	tar -czf "${ARCHIVE_DIR}/$(basename "$log" .log)_${CURRENT_DATE}.tar.gz" -C "$LOG_DIR" "$(basename "$log")"

	# Clear the original log file
	echo >"$log"
done

# Delete archives older than the specified number of days
find "$ARCHIVE_DIR" -type f -name '*.tar.gz' -mtime +$DAYS_RETENTION -exec rm {} \;

echo "Log rotation and archival complete."
