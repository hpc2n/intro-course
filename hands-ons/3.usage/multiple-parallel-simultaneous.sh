#!/bin/bash
#SBATCH -A SNIC2021-22-1017
# Since the files run simultaneously I need enough cores for all of them to run 
#SBATCH -n 56
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=02:00:00
 
module purge 
ml foss/2021b

srun -n 14 --exclusive ./mpi_hello &
srun -n 14 --exclusive ./mpi_greeting &
srun -n 14 --exclusive ./mpi_hi &
wait
