#!/bin/bash
#SBATCH -A staff
#Asking for 10 min.
#SBATCH -t 00:10:00
#Number of nodes
#SBATCH -N 1
#Ask for 28 processes
#SBATCH -n 14
#SBATCH -c 2
#SBATCH --exclusive

#Load modules necessary for running LAMMPS
module load icc/2017.1.132-GCC-6.3.0-2.27 ifort/2017.1.132-GCC-6.3.0-2.27  impi/2017.1.132
module load LAMMPS/31Mar17

export OMP_NUM_THREADS=2

#Execute LAMMPS
#srun lmp_intel_cpu -in step4.0_minimization.inp 
srun lmp_intel_cpu -in step4.1_equilibration.inp
