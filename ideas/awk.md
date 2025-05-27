# Linux tools: awk

This is a very powerful command which finds patterns in a file and can perform arithmetic/string operations. You can use it to transform data files and produce formatted reports. 

It allows the user to use variables, numeric functions, string functions, and logical operators.

Things ``awk`` can do:

- Scan a file line by line
- Split each input line into fields
- Compare input line/fields to pattern
- Perform action(s) on matched lines

!!! note 

    - In fact, ``awk`` is a scripting language which can do a set of actions on streams of textual data. 
    - You can either run it directly on a file or use it as part of a pipeline (with the operator "pipe"). 
    - You can extract or transform text, and for instance produce formatted reports. 
    - Like ``sed`` and ``grep``, it is a filter, and it is a standard feature of most Unix-like operating systems. 
    - In short: it searches one (or more) files to find if they contain line(s) that match the pattern given and then it performs the action required. 

Awk is abbreviated from the names of the developers - Aho, Weinberger, and Kernighan. 

## Syntax

``awk options 'selection-criteria {action }' input-file > output-file``

Important options: 
- **-F** - Sets a custom field separator
- **-f** - Reads ``awk`` program from a file
- **'{}'** - Encloses action to take on match

### Built-in variables 

``awk`` has built-in variables, which includes the field variables: 

- **$1**
- **$2**
- **$3**
- etc. 

The field variable **$0** is the entire line. 

These field variables break a line of text into individual words or pieces called *fields*. 

Aside from the field-variables, ``awk`` also has other built-in variables: 

- **NR**: keeps a current count of the number of input records (usually lines). Awk command performs the pattern/action statements once for each record in a file. 
- **NF**: keeps a count of the number of fields within the current input record. 
- **FS**: contains the field separator character used to divide fields on the input line. Default is "white space" (space or tab). **FS** can be reassigned to another character (typically in BEGIN) to change the field separator. 
- **RS**: stores the current record separator character. Since, by default, an input line is the input record, the default record separator character is a newline. 
- **OFS**: stores the output field separator, which separates the fields when ``awk`` prints them. Default is a blank space. Whenever print has several parameters separated with commas, it will print the value of OFS in between each parameter. 
- **ORS**: stores the output record separator, which separates the output lines when ``awk`` prints them. The default is a newline character. Print automatically outputs the contents of **ORS** at the end of whatever it is given to print. 

## Examples 

!!! hint 

    Code along! 

    Good files for this exercise can be found in the "exercises" -> "awk-qol" directory. 

!!! note "Search lines for a keyword"

    ```bash
    $ awk '/carnivore/ {print}' file.dat
    ``` 

!!! note "Print only specific columns" 
    
    ```bash
    $ awk '{print $1,$4}' file.dat
    ``` 

!!! note "Search for the pattern ‘snow’ in the file 'myfile.txt' and print out the first column" 

    ```bash
    $ awk '/snow/ {print$1}' myfile.txt
    ```

!!! note "Print column 3 and 4 from file file.dat"

    ```bash
    $ awk '{print $3 "\t" $4}' file.dat
    ``` 

!!! note "Print column 2 and 3 from file 'file.dat', but only those rows that contain the letter ‘r’"

    ```bash
    $ awk '/r/ {print $2 "\t" $3}' file.dat
    ```

!!! note "Display line number" 

    ```bash
    $ awk '{print NR,$0}' file.dat
    ```

!!! note "Display first and last field, using NF" 

    ```bash
    $ awk '{print $1,$NF}' file.dat
    ```

!!! note "Display line from 2 to 5" 

    ```bash
    $ awk 'NR==3, NR==6 {print NR,$0}' file.dat
    ```

!!! note "Print the first field and the row number(NR) separated with ' - '" 

    ```bash 
    $ awk '{print NR " - " $1 }' file.dat
    ```
    
!!! note "Print third column/field" 

    ```bash
    $ awk '{print $3}' file.dat
    ```

!!! note "Print any empty line if such exists" 

    ```bash
    $ awk 'NF == 0 {print NR}' file.dat
    ```

!!! note "Finding the length of the longest line"   

    ```bash 
    $ awk '{ if (length($0) > max) max = length($0) } END { print max }' file.dat 
    ```

!!! note "Count the lines in file.dat" 

    ```bash 
    $ awk 'END { print NR }' file.dat
    ``` 

!!! note "Print all lines that has more than 20 characters" 

    ```bash 
    $ awk 'length($0) > 20' file.dat
    ``` 

!!! note "Check for a specific string in any specific column"

    ```bash 
    $ awk '{ if($3 == "fur") print $0;}' file.dat 
    ```

Some parts of this section was copied from <a href="https://www.geeksforgeeks.org/awk-command-unixlinux-examples/" target="_blank">https://www.geeksforgeeks.org/awk-command-unixlinux-examples/</a>. 

## Exercise 

Work with the files in the "exercises" - "awk-qol" directory. 

1. Search "myfile.txt" for the keyword "text". 
2. Print column 2 only, from "file.dat"
3. Display line numbers on "myfile.txt" 
4. Count the lines in "myfile.txt" 
5. Check for the string "carnivore" in column 1 of "file.dat"
6. Check for the string "carnivore" in column 2 of "file.dat" 

## Summary 

!!! note "Keypoints 

    - We learned about awk
    - We used awk to find a keyword
    - We used awk to count lines in a file
    - We used awk to look at specific columns  


