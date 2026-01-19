#!/bin/bash
# Project id - change to your own after the course!
#SBATCH -A hpc2n2026-002
# Asking for 1 core
#SBATCH -n 1
# Asking for a walltime of 1 min
#SBATCH --time=00:01:00
 
# Purge modules before loading new ones in a script.
ml purge  > /dev/null 2>&1
ml foss/2023b

./hello
