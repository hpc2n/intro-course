#!/bin/bash
find  $HOME/exercises/script/image -type f -name "*.png" -exec cp {} myimages \;   
find myimages -type f -name "*er*" > someimagesfiles.txt
