# Regexp File Renamer

Console Ruby script for rename files and directories using regular expressions.

## Installation

Clone the repository

```
git clone https://github.com/bsielski/regex_file_renamer.git
```

Rename "renamer_configuration.yaml.example" to "renamer_configuration.yaml".

## Using

Edit renamer_configuration.yaml file. This file has 3 values:

- **directory:** path to directory of entries to rename.
- **names:** filter entries by name. No filter means that all entries can be renamed.
- **replacements:** made of two parts: "from" and "to". This is the core of the renaming.

Run the script from the project's main directory

```
ruby renamer.rb
```