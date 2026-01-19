#!/bin/bash
# Remember to change this to your own Project ID after the course! 
#SBATCH -A hpc2n2026-002
# Number of tasks - default is 1 core per task 
#SBATCH -n 14
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge > /dev/null 2>&1

ml add foss/2023b

srun ./mpi_greeting
