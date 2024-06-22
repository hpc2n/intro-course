#!/bin/bash
#SBATCH -A hpc2n2023-132
# Since the files run sequentially I only need enough cores for the largest of them to run 
#SBATCH -n 14
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=00:10:00
 
module purge > /dev/null 2>&1
ml foss/2021b

# Here 14 tasks with 2 cores per task. Output to file - not needed if your job creates output in a file directly 
# In this example I also copy the output somewhere else and then run another executable.

srun -n 14 -c 2 ./mpi_hello > myoutput1 2>&1
cp myoutput1 mydatadir
srun -n 14 -c 2 ./mpi_greeting > myoutput2 2>&1
cp myoutput2 mydatadir
srun -n 14 -c 2 ./mpi_hi > myoutput3 2>&1
cp myoutput3 mydatadir
