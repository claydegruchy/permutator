# Permutator

This script allows you to generate permutations from a template file and a set of configuration files. Each permutation will create a new folder with the output saved as a file inside it.

## Prerequisites

*   Bash shell (Unix-like environment)
- `jinja2-cli` [found here](https://github.com/mattrobenolt/jinja2-cli)

## Usage


### Running
Run the script from the command line with the following options:

*   `-d <config_directory>`: The directory containing your config files (required).
*   `-t <template_file>`: The path to the template file (required).
*   `-o <output_directory>` (optional): The directory where output folders will be created. If not provided, output folders will be created in the current directory.

`./create_permutations.sh -d /path/to/config_directory -t template.psc -o /path/to/output_directory`

### Writing the template
The template system using standard jinja2 templating style. So take whatever file you want and add `{{anything}}` to it. You can also take an existing file (such as a `.psc` file) and change out words or sections for `{{handlebars}}`. 
```
this is my script, there are many like it but this one is mine
```
could be changed to
```
this is my script, there are {{QUANTITY}} like it but this one is {{OWNER}}
```
then saved as `my_template.txt`

### Writing the configs
The configs are written in YAML. Just make a `.yaml` file for each permutation you'd like, then add corresponding variables matching the template (they gotta match! or it'll shit its pants)

From our example

`orginal.yaml`
```
OWNER: mine
QUANTITY: many
```

`variation1.yaml`
```
OWNER: yours
QUANTITY: few
```

And this would generate two folders, one called `variation1` and another called `orginal` which would contain (respectively):
- `this is my script, there are few like it but this one is yours`
- `this is my script, there are many like it but this one is mine`

## Output

For each configuration file in the specified directory, the script will:

1.  Create a new folder named after the configuration file (excluding the `.yaml` extension) in the output directory.
2.  Run your CLI tool with the template file and the current configuration file.
3.  Save the output as a file with the same name as the template file inside the corresponding folder.

## Example

Suppose you have the following directory structure:

    project/
    |-- create_permutations.sh
    |-- config_files/
    |   |-- config1.yaml
    |   |-- config2.yaml
    |   `-- config3.yaml
    `-- template.psc

You can generate permutations with the following command:

    `./create_permutations.sh -d config_files -t templates/template.psc -o output`

This will create the following output structure:

    project/
    |-- create_permutations.sh
    |-- config_files/
    |   |-- config1.yaml
    |   |-- config2.yaml
    |   `-- config3.yaml
    |-- template.psc
    `-- output/
        |-- config1/
        |   `-- template.psc
        |-- config2/
        |   `-- template.psc
        `-- config3/
            `-- template.psc

Each `template.psc` file in the output folders will contain the result of running your CLI tool with the corresponding configuration file.
