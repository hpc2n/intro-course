#!/bin/bash
#SBATCH -A SNIC2020-9-215
# Add enough cores that all jobs can run at the same time 
#SBATCH -n 5
# Make sure that the time is long enough that the longest job will have time to finish 
#SBATCH --time=00:15:00

module purge
ml foss/2019b 

srun -n 1 --exclusive ./hello &
srun -n 1 --exclusive ./Greeting & 
srun -n 1 --exclusive ./Adding2 10 20 &
srun -n 1 --exclusive /bin/hostname & 
srun -n 1 --exclusive ./Mult2 10 2 
wait
