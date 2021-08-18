#!/bin/bash
# Remember to change this to your own Project ID after the course! 
#SBATCH -A SNIC2021-22-514
# Number of tasks - default is 1 core per task 
#SBATCH -n 14
#SBATCH --time=00:05:00
# Remove the below out-commenting if you are running this during 
# the course and wish to use the reservation 
##SBATCH --reservation=intro-hpc

# It is always a good idea to do ml purge before loading other modules 
ml purge

ml add foss/2019b

srun mpi_hi
