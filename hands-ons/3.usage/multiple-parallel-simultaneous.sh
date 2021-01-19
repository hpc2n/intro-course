#!/bin/bash
#SBATCH -A SNIC2020-9-215
# Since the files run simultaneously I need enough cores for all of them to run 
#SBATCH -n 56
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=02:00:00
 
module purge 
ml foss/2019b

srun -n 14 --exclusive ./mpi_hello &
srun -n 14 --exclusive ./mpi_greeting &
srun -n 14 --exclusive ./mpi_hi &
wait
