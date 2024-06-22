Variables

-NR Number of records (lines)

-NF Number of fields (columns)

Examples in subfolders:

* Summation

Compute the average of a column data in a file using AWK:

awk 'BEGIN{sum=0}{sum=sum+$1}END{print sum/129}' file_pdb.txt

this process is easier than writing a code (Fortran in this
example read.f90)

* Working-Files

1.FNR Number of records in the current file 
    *Add the second column of two files
    awk '{a[FNR]=$1; s[FNR]+=$2} END{for (i=1; i<=FNR; i++) print s[i]}' file1.txt file2.txt

2.FS Field separator
    *Use a specified field separator
    awk -F ':' '{print $1}' field-separator.txt
    awk 'BEGIN{FS=":"}{print $1}' field-separator.txt

3.RS Record separator
    awk 'BEGIN{RS="."}{print $2}' record-separator.txt

4.Search for a pattern
    awk '/2/ {print $0}' file1.txt 

5.Pattern in a field
    awk '$1~/4/ {print $0}' file1.txt

6.OR pattern search
    awk '(/Peter/ || /John/) {print $0}' pattern.txt

7.Working with a PDB file:
7.1 Find all lines containing CA atoms:
    awk '/ CA / {print $0}' 1aki_proa.pdb 

7.2 Find the CM based on CA atoms:
   awk '/ CA / {x+=$6;y+=$7;z+=$8;s+=1.0}END{printf "%.3f %.3f %.6f", x/s,y/s,z/s}' 1aki_proa.pdb 

   7.3 Find the CM based on CA,N,C,O atoms:
   awk '/ CA / || / N / || / C / || / O / {x+=$6;y+=$7;z+=$8;s+=1.0}END{printf "%.3f %.3f %.6f", x/s,y/s,z/s}' 1aki_proa.pdb 

