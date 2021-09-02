#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -n 1
#Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

ml purge
ml GCC/10.2.0  OpenMPI/4.0.5
ml R/4.0.4

R --no-save --no-restore -f Rscript.R

