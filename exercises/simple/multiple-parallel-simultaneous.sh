#!/bin/bash
#SBATCH -A hpc2n2026-002
# Since the files run simultaneously I need enough cores for all of them to run 
#SBATCH -n 56
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=00:10:00
 
module purge > /dev/null 2>&1 
ml foss/2023b

srun -n 14 --exclusive ./mpi_hello &
srun -n 14 --exclusive ./mpi_greeting &
srun -n 14 --exclusive ./mpi_hi &
wait
