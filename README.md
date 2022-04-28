# BS
The supreme Make template creator

Usage: `bs.py [command]`
Use `--help` to list commands

Currently, there is only one template, however there will be more being added, and you can contribute your own.
You can add bs.py to your path to use anywhere.

## Installation:

There are a few options for installation:
 1. Install the source code manually
 2. Use the PPA

### PPA Instructions

```bash
sudo add-apt-repository ppa:ml4438/bs
sudo apt-get update
```

## Making Templates

To make templates, there is a syntax that they must follow:

### Variables

BS variables should be denoted like this in any template:
```
$$MY_VAR
```
To break it down, they should:
 - Begin with two dollar signs ($$)
 - Use all caps
 - Use underscores (_) to seperate words

### Template Descriptor

Template descriptors should always be on the second line, and the **first character of the line is always ignored!!!**

They should use the same style as Python data types, and should be a dictionary containing all attributes. 

The following are the attributes currently used:
 - vars: Any variables that should be initialized when the user initializes the template.
 - targets: The Makefile targets that would be run most commonly
_Note: Targets are not fully supported yet, and can be ommitted, but are reserved for a future release._

The attributes should be preceded by a list containing strings, again with Python-style syntax.

This is an example of a good template descriptor: (taken from the `python` template, at the time of writing)
```
# {'vars': ['MAIN_FILE', 'PYTHON_EXECUTABLE', 'PYTHON_FLAGS', 'SCRIPT_FLAGS'], 'targets': ['all', 'run']}
```

### Adding Templates to BS

In order to add a template to BS, there are two steps:

 1. Move the file to its own directory inside `templates`, so it should look like `templates/my-template/Makefile`
 2. In `bs.py`, or whatever you may have renamed it to, edit the variable `language_choices` at the top of the file to reflect the name of the directory that it was placed in. In my example above, I would call it `my-template`

_If you compiled bs.py to an executable, you may need to rebuild it. This may be changed in a future release._

If you want it added to the global BS repo, create a pull request or send me an email: michael@lachut.com
