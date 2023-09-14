#!/bin/bash
#SBATCH -A hpc2n2023-102
# Since the files are run sequentially I only need enough cores for the largest of them to run 
#SBATCH -c 28
# Remember to ask for enough time for all jobs to complete
#SBATCH --time=02:00:00
 
module purge 
ml foss/2021b

# Here 14 tasks with 2 cores per task. Output to file - not needed if your job creates output in a file directly 
# In this example I also copy the output somewhere else and then run another executable.

srun -n 14 -c 2 ./mpi_hello > myoutput1 2>&1
cp myoutput1 mydatadir
srun -n 14 -c 2 ./mpi_greeting > myoutput2 2>&1
cp myoutput2 mydatadir
srun -n 14 -c 2 ./mpi_hi > myoutput3 2>&1
cp myoutput3 mydatadir
