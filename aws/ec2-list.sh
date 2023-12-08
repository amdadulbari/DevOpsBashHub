#!/bin/bash

# This script fetches and displays details of running EC2 instances, 
# including their names, private and public IP addresses, and instance types in a formatted table using aws cli.
# If you are using this script, you can star this repo ;)


# Check if AWS CLI is installed
if ! command -v aws &>/dev/null; then
	echo "AWS CLI is not installed. Please install it and configure it."
	exit 1
fi

# Fetch details of running EC2 instances
aws ec2 describe-instances \
	--query 'Reservations[*].Instances[?State.Name==`running`].[Tags[?Key==`Name`].Value | [0], PrivateIpAddress, PublicIpAddress, InstanceType]' \
	--output text |
	tr '\t' '|' |
	awk -F '|' 'BEGIN { 
        print "+--------------------------------+----------------+----------------+----------------+";
        print "| Instance Name                  | Private IP     | Public IP      | Instance Type  |";
        print "+--------------------------------+----------------+----------------+----------------+";
     }
     {
        printf("| %-30s | %-14s | %-14s | %-14s |\n", $1, $2, $3, $4);
     }
     END {
        print "+--------------------------------+----------------+----------------+----------------+";
     }'
