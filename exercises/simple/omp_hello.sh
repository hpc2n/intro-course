#!/bin/bash
# Project id - change to your own after the workshop!
#SBATCH -A hpc2n2025-151
# Number of cores per tasks
#SBATCH -c 8 
# Asking for a walltime of 5 min
#SBATCH --time=00:05:00

# Load a compiler toolchain so we can run an OpenMPI C program
module load foss/2023b

# Compile the OpenMP program omp_hello.c for ease
gcc -fopenmp omp_hello.c -o omp_hello

# Set OMP_NUM_THREADS to the same value as -c with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads

./omp_hello
