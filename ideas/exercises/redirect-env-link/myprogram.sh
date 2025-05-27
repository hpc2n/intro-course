#!/bin/bash
mkdir myimages
find  ../piping-wc-cut/image type f -name "*.png" -exec cp {} myimages \;   
find myimages -type f -name "*er*" > someimagesfiles.txt
ls myimages | wc -l
