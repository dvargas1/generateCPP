## Bash Script to Create C++ Source File from Header File

This Bash script generates a C++ source file from a header file by copying the empty function definitions of the header file to the source file. It also creates the class structures according to the "orthodox canonical class form"

### OCCF
In the orthodox canonical class form our class needs to have this methods
* default constructor 
* copy constructor
* destructor
* copy assignment operator

### Usage

To use the script, run the following command in a terminal:

```
./header-to-source.sh <header-file>
```

where *<header-file>* is the name of the header file for which you want to create the source file.

### Examples
Here are an example of usage:

```
./header-to-source.sh MyClass.hpp
```

This will generate a source file named **MyClass.cpp** in the same directory as the header file *MyClass.hpp*.

### Error Handling
The script displays an error message and exits with a status code of 1 if no arguments are provided, if the specified header file does not exist, or if the specified source file already exists.

### Alias
To create an alias for the **generatecpp.sh** script, open your *.zshrc* or *.bashrc* file and add the following line:
```
aliasname="path/to/generatecpp.sh"
```

Make sure to replace **aliasname** with your desired alias and **path/to/generatecpp.sh** with the correct path to the script.

Once the alias is set up, you can call the script from the command line using your chosen alias and the name of the header file:

```
aliasname MyClass.hpp
```

### Contributing
If you find a bug or want to contribute to the script, please create a pull request or file an issue on this repository
