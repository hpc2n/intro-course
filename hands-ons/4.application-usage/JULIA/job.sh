#!/bin/bash
#SBATCH -A **FIXME**
#Asking for 10 min.
#SBATCH -t 00:08:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c **FIXME**
#Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

ml purge > /dev/null 2>&1
ml Julia/1.7.1-linux-x86_64

julia script.jl
