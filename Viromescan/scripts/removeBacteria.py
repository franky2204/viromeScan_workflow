import os
import sys
#open the file conatining the taxids of bacteria and check 
#if the taxid is in the file
def IsNotBacteria(taxid):
    with open(sys.argv[2], "r") as taxid_file:
        file_contents = taxid_file.read()
    if taxid in file_contents:
        return False
    else:
        return True

 
file_path = sys.argv[1]
with open(file_path, "r") as file:
    file_contents = file.readlines()
lines_starting_with_U = []

# If the line starts with "U" or "C" and the taxid is not in the file, 
# add it to the list
for line in file_contents:
    if line.startswith("U"):
        lines_starting_with_U.append(line)
    elif line.startswith("C"):
        taxid = line.split("\t")[2].split("taxid ")[1].split(")")[0]
        if IsNotBacteria(taxid):
            lines_starting_with_U.append(line)

# Create a new file called "output.txt" in write mode
with open("notBacteriaLines.txt", "w") as output_file:
    for line in lines_starting_with_U:
        output_file.write(line)
