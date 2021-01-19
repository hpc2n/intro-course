#!/bin/bash
# Remember to change this to your own Project ID after the course! 
#SBATCH -A SNIC2020-9-215
# Number of tasks - default is 1 core per task 
#SBATCH -n 14
#SBATCH --time=00:05:00
##SBATCH --reservation=intro-hpc

# It is always a good idea to do ml purge before loading other modules 
ml purge

ml add foss/2019b

srun mpi_hello
