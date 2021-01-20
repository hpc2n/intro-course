#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:02:00
#SBATCH -n 1
#Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0

R --no-save --no-restore -f serial.R

