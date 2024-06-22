#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#Number of nodes
#SBATCH -N 1
#Ask for 28 processes
#SBATCH -n 14
#SBATCH -c 2

#Purge and load modules necessary for running LAMMPS
ml purge > /dev/null 2>&1
ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos 
export OMP_NUM_THREADS=2

#Execute LAMMPS
srun lmp -in step4.1_equilibration.inp
