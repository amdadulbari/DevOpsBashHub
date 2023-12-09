#!/bin/bash
# This script generate a comprehensive audit report of user accounts, detailing their 
# login, password status, activity, and group memberships.

# If you are using this script, you can star this repo ;)


# Output file for the audit report
audit_report="user_audit_report_$(date +%F).txt"

# Function to generate audit report
generate_audit_report() {
	echo "Generating User Account Audit Report..."
	echo "Username, Existence, Last Login, Password Age, Account Status, Groups" >"$audit_report"

	# Loop through all users in /etc/passwd
	while IFS=: read -r username _ _ _ _ _ home shell; do
		# Check if the user exists
		existence="Exists"

		# Get the last login time
		last_login=$(last -FRn 1 "$username" | head -1 | awk '{print $5, $6, $7, $8, $9}')
		[ -z "$last_login" ] && last_login="Never"

		# Get password age
		password_age=$(chage -l "$username" | grep '^Last password change' | cut -d: -f2)

		# Check account status
		account_status="Active"
		if [ ! -e "$home" ] || [ "$shell" == "/bin/false" ] || [ "$shell" == "/usr/sbin/nologin" ]; then
			account_status="Inactive"
		fi

		# Get groups
		groups=$(id -nG "$username" | tr ' ' ',')

		# Write to report
		echo "$username, $existence, $last_login, $password_age, $account_status, $groups" >>"$audit_report"
	done </etc/passwd

	echo "Audit Report Generated: $audit_report"
}

# Execute the function
generate_audit_report
