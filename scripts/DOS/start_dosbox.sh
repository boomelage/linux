#!/bin/bash

# Define the working directory to mount
WORKING_DIR="$(pwd)"

# Check if the working directory exists
if [ ! -d "$WORKING_DIR" ]; then
    echo "Error: Working directory does not exist!"
    exit 1
fi

# Start DOSBox Staging with the mount command
dosbox-staging -c "mount C $WORKING_DIR" -c "C:" -c "DIR"   # You can replace "DIR" with a program or command to run automatically

