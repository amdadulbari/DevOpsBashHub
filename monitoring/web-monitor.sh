#!/bin/bash

# This shell script monitors a list of websites for availability by checking their HTTP status codes
# and triggers an alert if any site is down or returns a non-200 status code.
# If you are using this script, you can star this repo ;)

# Declare an associative array for site names and their URLs
declare -A SITES
SITES["Example Site"]="http://example.com"
SITES["Another Site"]="http://example.org"
SITES["More Site"]="http://example.net"

for site_name in "${!SITES[@]}"; do
	site_url=${SITES[$site_name]}

	# Get the HTTP status code
	status_code=$(curl -o /dev/null -s -w "%{http_code}\n" "$site_url")

	# Check if the status code is not 200
	if [ "$status_code" -ne 200 ]; then
		echo "Alert: '$site_name' ($site_url) is down or not returning HTTP 200. Status code: $status_code"
		# Add any alert mechanism here, e.g., send an email or trigger a notification
	fi
done
