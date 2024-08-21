#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -n 6
#SBATCH -C 'skylake'

export OMPI_MCA_mpi_warn_on_fork=0

ml purge > /dev/null 2>&1
ml GCC/10.2.0  OpenMPI/4.0.5
ml R/4.0.4

Rscript --no-save --no-restore Rmpi.R
