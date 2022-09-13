#!/bin/bash
# Project id - change to your own after the course!
#SBATCH -A SNIC2021-22-642
# Asking for 1 core
#SBATCH -n 1
# Asking for a walltime of 1 min
#SBATCH --time=00:01:00
 
# Purge modules before loading new ones in a script.
ml purge
ml foss/2021b

./hello
