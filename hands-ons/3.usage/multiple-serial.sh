#!/bin/bash
#SBATCH -A hpc2n2023-132
# Add enough cores that all jobs can run at the same time 
#SBATCH -n 5
# Make sure that the time is long enough that the longest job will have time to finish 
#SBATCH --time=00:05:00

module purge > /dev/null 2>&1
ml foss/2021b 

srun -n 1 --exclusive ./hello &
srun -n 1 --exclusive ./Greeting & 
srun -n 1 --exclusive ./Adding2 10 20 &
srun -n 1 --exclusive /bin/hostname & 
srun -n 1 --exclusive ./Mult2 10 2 
wait
