import os
import sys

def IsNotBacteria(taxid):
    # Open the file taxid.txt in read mode
    with open(sys.argv[2], "r") as taxid_file:
        # Read the contents of the file
        file_contents = taxid_file.read()
    
    # Check if the taxid is present in the file
    if taxid in file_contents:
        return False
    else:
        return True

# Open the file in read mode
file_path = sys.argv[1]
with open(file_path, "r") as file:
    # Read the contents of the file line by line
    file_contents = file.readlines()
# Create an empty array to store lines starting with "U"
lines_starting_with_U = []

# Iterate over the lines in the file
for line in file_contents:
    # Check if the line starts with "U"
    if line.startswith("U"):
        # Add the line to the array
        lines_starting_with_U.append(line)
    elif line.startswith("C"):
        # Extract the taxid from the current line
        taxid = line.split("\t")[2].split("taxid ")[1].split(")")[0]
        if IsNotBacteria(taxid):
            lines_starting_with_U.append(line)

# Create a new file called "output.txt" in write mode
with open("notBacteriaLines.txt", "w") as output_file:
    # Write the lines starting with "U" to the file
    for line in lines_starting_with_U:
        output_file.write(line)
