#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -n 56

export OMPI_MCA_mpi_warn_on_fork=0

ml GCC/8.2.0-2.31.1  OpenMPI/3.1.3
ml R/3.6.0

mpirun -np 1 R CMD BATCH --no-save --no-restore Rmpi_3.R output.out
