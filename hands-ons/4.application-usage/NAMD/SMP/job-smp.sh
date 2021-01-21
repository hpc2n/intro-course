#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 28

#Load modules necessary for running NAMD
ml icc/2017.1.132-GCC-6.3.0-2.27 impi/2017.1.132
ml NAMD/2.12-nompi

namd2 +p 28 +setcpuaffinity step4_equilibration.inp > output_smp.dat

exit 0
