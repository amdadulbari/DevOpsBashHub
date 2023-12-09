#!/bin/bash

# A shell script for efficiently add specified users and add them in specified group 
# If you are using this script, you can star this repo ;)


# List of users to be added
user_list=("user1" "user2" "user3")

# Specify the group to which the users will be added
group_name="examplegroup"

# Loop through each user in the list
for user in "${user_list[@]}"; do
    echo "Adding user: $user"

    # Add the user
    useradd "$user"

    # Check if the user addition was successful
    if [[ $? -eq 0 ]]; then
        echo "User $user added successfully."

        # Add the user to the specified group
        usermod -a -G "$group_name" "$user"
        if [[ $? -eq 0 ]]; then
            echo "User $user added to group $group_name successfully."
        else
            echo "Failed to add user $user to group $group_name."
        fi
    else
        echo "Failed to add user $user."
    fi
done
