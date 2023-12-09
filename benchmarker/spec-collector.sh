#!/bin/bash
# This script collect and report system hardware and software configuration.
# If you are using this script, you can star this repo ;)

# Output file for the system inventory
inventory_file="system_inventory_$(date +%F).txt"

# Function to collect system information
collect_system_info() {
	echo "Collecting system inventory..."

	# System Information
	echo "System Information:" >"$inventory_file"
	echo "Hostname: $(hostname)" >>"$inventory_file"
	echo "Uptime: $(uptime -p)" >>"$inventory_file"
	echo "Operating System: $(lsb_release -d | cut -f2)" >>"$inventory_file"
	echo "Kernel Version: $(uname -r)" >>"$inventory_file"
	echo "" >>"$inventory_file"

	# CPU Information
	echo "CPU Information:" >>"$inventory_file"
	echo "$(lscpu | grep 'Model name')" >>"$inventory_file"
	echo "$(lscpu | grep 'Socket(s):')" >>"$inventory_file"
	echo "$(lscpu | grep 'Core(s) per socket:')" >>"$inventory_file"
	echo "$(lscpu | grep 'Thread(s) per core:')" >>"$inventory_file"
	echo "" >>"$inventory_file"

	# Memory Information
	echo "Memory Information:" >>"$inventory_file"
	echo "$(free -h)" >>"$inventory_file"
	echo "" >>"$inventory_file"

	# Disk Space Information
	echo "Disk Space Information:" >>"$inventory_file"
	echo "$(df -h --total | grep 'total')" >>"$inventory_file"
	echo "" >>"$inventory_file"

	# Network Information
	echo "Network Information:" >>"$inventory_file"
	echo "$(ip addr | grep 'inet ')" >>"$inventory_file"
	echo "" >>"$inventory_file"

	# Installed Packages
	echo "Installed Packages:" >>"$inventory_file"
	dpkg-query -l >>"$inventory_file"

	echo "System inventory collected in $inventory_file"
}

# Execute the function
collect_system_info
