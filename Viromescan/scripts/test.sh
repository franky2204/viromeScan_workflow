#!/bin/bash

# Path to the directory containing viromescan executable
viromescan_dir="/opt/conda/envs/viromescan/bin/"

# Check if the directory exists
if [ ! -d "$viromescan_dir" ]; then
    echo "Error: Viromescan directory not found: $viromescan_dir"
    exit 1
fi

# List all files in the directory and their permissions
echo "Permissions for files in $viromescan_dir:"
ls -l "$viromescan_dir"