#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 28

#Load modules necessary for running NAMD
ml GCC/6.3.0-2.27  OpenMPI/2.0.2
ml NAMD/2.12-mpi

srun namd2 +setcpuaffinity step4_equilibration.inp > output_mpi.dat

exit 0
