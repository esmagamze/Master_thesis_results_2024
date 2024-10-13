#!/bin/bash

# Check if the required arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <sample_list_file> <reference_file> <output_folder>"
    exit 1
fi

# Set the number of CPUs you want to use in parallel
num_cpus=60 # The number of samples made is entered.

# Input arguments
sample_list_file=$1
reference_file=$2
output_folder=$3

# Function to process a single sample
process_sample() {
    sample=$1
    reference=$2
    output_folder=$3
    target=$4
    iread.py "${sample}" "${reference}" -o "${output_folder}/output_${sample}" -t "${target}"
}

# Export the function so it's available to parallel
export -f process_sample

# Read sample names and corresponding target values from the input file and run the script in parallel
while read -r sample target; do
    parallel -j "${num_cpus}" process_sample "${sample}" "${reference_file}" "${output_folder}" "${target}" :::: <(echo "$sample $target")
done < "$sample_list_file"

