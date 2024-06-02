#!/bin/bash

# Activate Conda environment
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate viromescan
echo "Conda environment viromescan activated."

# Assign script arguments to variables
threads=$1
db=$2
file1=$3
file2=$4


# Run viromescan with the correct arguments
chmod +x /opt/conda/envs/viromescan/bin/viromescan
echo "permission given to viromescan"
bash viromescan -p "$threads" -m "$db" -d "$db" -1 "$file1" -2 "$file2" -o hello



echo "Viromescan completed successfully."
