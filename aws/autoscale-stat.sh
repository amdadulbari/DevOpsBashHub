#!/bin/bash
# This script fetches and displays detailed information about AWS Auto-Scaling Groups
# If you are using this script, you can star this repo ;)

# Set AWS Region
AWS_REGION="ap-southeast-1" # Change this to your AWS region

# Get a list of all Auto-Scaling Groups
asg_list=$(aws autoscaling describe-auto-scaling-groups --region "$AWS_REGION" --query 'AutoScalingGroups[*].AutoScalingGroupName' --output text)

# Print column headers
printf "%-40s %-10s %-10s %-18s %-20s\n" "Auto-Scaling-Group-Name" "Min-Size" "Max-Size" "Desired-Capacity" "Running-Instances"

# Check each ASG status
for asg in $asg_list; do
	# Get ASG details including MinSize, MaxSize, DesiredCapacity, and number of InService instances
	details=$(aws autoscaling describe-auto-scaling-groups \
		--auto-scaling-group-names "$asg" \
		--region "$AWS_REGION" \
		--query 'AutoScalingGroups[*].[AutoScalingGroupName, MinSize, MaxSize, DesiredCapacity, Instances[?LifecycleState==`InService`].InstanceId | length(@)]' \
		--output text)

	# Use awk to format and align the output
	echo "$details" | awk '{printf "%-40s %-10s %-10s %-18s %-20s\n", $1, $2, $3, $4, $5}'
done

echo "Auto-Scaling Group Monitoring Complete."
