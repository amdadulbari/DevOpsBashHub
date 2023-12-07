#!/bin/bash

#This Bash script checks the expiration dates of SSL certificates for specified domains and
# alerts if any are expiring within 30 days.
# If you are using this script, you can star this repo ;)

# Configuration: Add your domain names here
DOMAINS=("example.com" "example.org")

# Number of days to check for expiration
DAYS_THRESHOLD=30

# Current date in seconds
CURRENT_DATE=$(date +%s)

# Function to check SSL certificate expiration
check_ssl_expiry() {
	local domain=$1
	local expiration_date

	# Get the expiration date of the SSL certificate
	expiration_date=$(echo | openssl s_client -servername $domain -connect $domain:443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f 2)

	# Convert expiration date to seconds
	if ! expiration_date_sec=$(date -d "$expiration_date" +%s); then
		echo "Error: Failed to parse expiration date for $domain"
		return
	fi

	# Calculate the difference in days
	local diff_in_days=$((($expiration_date_sec - $CURRENT_DATE) / 86400))
	echo $diff_in_days
	# Check if the difference is less than threshold
	if [ $diff_in_days -le $DAYS_THRESHOLD ]; then
		echo "Alert: SSL certificate for '$domain' is expiring in $diff_in_days days."
		# Add alert mechanism here, e.g., send an email or trigger a notification
	fi
}

# Check each domain
for domain in "${DOMAINS[@]}"; do
	check_ssl_expiry "$domain"
done
