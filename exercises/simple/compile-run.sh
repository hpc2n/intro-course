#!/bin/bash
# CHANGE THE PROJECT ID TO YOUR OWN PROJECT ID AFTER THE COURSE!
#SBATCH -A hpc2n2023-132
#Name the job, for easier finding in the list
#SBATCH -J compiler-run
#SBATCH -t 00:10:00
#SBATCH -n 12

ml purge > /dev/null 2>&1

ml foss/2021b 

mpicc mpi_hello.c -o mpi_hello 
mpirun ./mpi_hello
