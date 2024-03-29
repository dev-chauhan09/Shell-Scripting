#!/bin/bash

*************

# About : This script is used to find out number of users having read access to certain Repo and takes Two CMD args


# Owner : Dev chauhan ------ Get in touch in case of any doubt

# Special Thanks To : Abhishek Veermalla



*************
# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2



# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}
 : '
function helper{
# Define the number of required arguments
  local required_args="$2"
  

  # Get the actual number of arguments passed
  local actual_args="$#"

  # Check if actual arguments are less than required arguments
  if [[ $actual_args -lt $required_args ]]; then
    # Print usage message and exit
    echo "Usage: $0 <arg1> <arg2> ..." >&2
    echo "  This script requires $required_args arguments." >&2
    exit 1
  fi
}
 comment'

# Main script

echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
