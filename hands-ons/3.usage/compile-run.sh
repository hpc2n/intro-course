#!/bin/bash
# CHANGE THE PROJECT ID TO YOUR OWN PROJECT ID AFTER THE COURSE!
#SBATCH -A SNIC2022-22-642
#Name the job, for easier finding in the list
#SBATCH -J compiler-run
#SBATCH -t 00:10:00
#SBATCH -n 12

ml purge

ml foss/2021b 

mpicc mpi_hello.c -o mpi_hello 
mpirun ./mpi_hello
