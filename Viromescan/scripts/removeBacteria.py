import sys

def IsNotBacteria(taxid, taxid_set):
    return taxid not in taxid_set

file_path = sys.argv[1]
taxid_file_path = sys.argv[2]


with open(taxid_file_path, "r") as taxid_file:
    taxid_set = set(taxid_file.read().splitlines())

lines_starting_with_U = []

with open(file_path, "r") as file:
    for line in file:
        if line.startswith("U"):
            lines_starting_with_U.append(line)
        elif line.startswith("C"):
            taxid = line.split("\t")[2].split("taxid ")[1].split(")")[0]
            if IsNotBacteria(taxid, taxid_set):
                lines_starting_with_U.append(line)

with open("notBacteriaLines.txt", "w") as output_file:
    for line in lines_starting_with_U:
        output_file.write(line)
