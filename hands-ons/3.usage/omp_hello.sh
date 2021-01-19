#!/bin/bash
#SBATCH -A SNIC2020-9-215
# Number of cores per task 
#SBATCH -c 28
#SBATCH --time=00:05:00

# It is always a good idea to do ml purge before loading other modules 
ml purge

ml add foss/2019b

# Set OMP_NUM_THREADS to the same value as -c with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

./omp_hello

