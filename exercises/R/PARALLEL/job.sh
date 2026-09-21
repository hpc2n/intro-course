#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -n 1
#Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

ml purge > /dev/null 2>&1
ml GCC/13.2.0
ml R/4.4.1

R --no-save --no-restore -f clusterapply.R
