#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 28
#SBATCH -C intel_cpu

#Load modules necessary for running NAMD
ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  OpenMPI/4.0.3
ml NAMD/2.14-mpi

# Running NAMD 
srun namd2 step4_equilibration.inp > output-mpi1.dat

# Running NAMD with Multi Time Stepping algorithm 
#srun namd2 step4_equilibration_mts.inp > output-mpi2.dat
