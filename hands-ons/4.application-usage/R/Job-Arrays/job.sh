#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:12:00
#SBATCH --array=1-28
##Writing the output and error files
#SBATCH --output=Array_test.%A_%a.out
#SBATCH --error=Array_test.%A_%a.error

ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0

R --no-save --no-restore -f script.R

