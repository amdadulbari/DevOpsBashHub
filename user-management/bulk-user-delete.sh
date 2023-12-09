#!/bin/bash
# A shell script for efficiently removing specified users and their home directories 
# If you are using this script, you can star this repo ;)

# List of users to be deleted
user_list=("user1" "user2" "user3")

# Loop through each user in the list
for user in "${user_list[@]}"; do
    echo "Deleting user: $user"
    # Delete the user along with their home directory
    userdel -r "$user"

    # Check if the user deletion was successful
    if [[ $? -eq 0 ]]; then
        echo "User $user deleted successfully."
    else
        echo "Failed to delete user $user."
    fi
done