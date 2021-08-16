#!/bin/bash 
# Remember to change this to your own Project ID after the course! 
#SBATCH -A SNIC2021-22-514  
#SBATCH -n 8 
#SBATCH --time=00:05:00
# Putting the output in a separate output file and the errors in an 
# error file instead of putting it all in slurm-<jobid>.out 
# Note the environment variable %J, which contains the jobid. It is handy to avoid naming the files the same for different runs, and thus overwriting them.  
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
# This reservation is only valid during the course and so has been commented out! Remove the out-commenting if you are running this during the course and wish to use the reservation.  
##SBATCH --reservation intro-course-hpc

ml purge
ml foss/2019b

mpirun ./mpi_hello 
