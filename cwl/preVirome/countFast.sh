#!/bin/bash

file1=$1
file2=$2
output_file=$3


lines_file1=$(wc -l < "$file1")
lines_file2=$(wc -l < "$file2")

echo "$file1: $lines_file1" >> "$output_file"
echo "$file2: $lines_file2" >> "$output_file"
