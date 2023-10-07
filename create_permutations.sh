#!/bin/bash

# Initialize variables with default values
config_directory=""
template_file=""
output_directory=""
cli_tool="jinja2"

# Function to create a new directory for each permutation
create_output_directory() {
    mkdir -p "$1"
}

# Function to run the CLI tool and save the output
run_cli_tool_and_save_output() {
    $cli_tool "$template_file" "$config_file" > "$output_file"
}

# Parse command-line arguments
while getopts "d:t:o:" opt; do
    case "$opt" in
        d) config_directory="$OPTARG";;
        t) template_file="$OPTARG";;
        o) output_directory="$OPTARG";;
        \?) echo "Usage: $0 -d <config_directory> -t <template_file> [-o <output_directory>]"; exit 1;;
    esac
done

# Check if both directory and template file are provided
if [ -z "$config_directory" ] || [ -z "$template_file" ]; then
    echo "Usage: $0 -d <config_directory> -t <template_file> [-o <output_directory>]"
    exit 1
fi

# Use the current directory as the output directory if not provided
if [ -z "$output_directory" ]; then
    output_directory="."
fi

# Iterate over each config file in the directory
for config_file in "$config_directory"/*.yaml; do
    # Check if the file exists
    if [ -e "$config_file" ]; then
        # Create a new directory for each permutation
        permutation_output_dir="$output_directory/$(basename "$config_file" .yaml)"
        create_output_directory "$permutation_output_dir"

        # Run the CLI tool and save the output
        output_file="$permutation_output_dir/$(basename "$template_file")"
        run_cli_tool_and_save_output
    fi
done
