#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -N 1
#SBATCH -c 8


ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0

R --no-save --no-restore -f doParallel_ML.R

