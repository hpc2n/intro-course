#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -n 4
#SBATCH -c 7

# It is always best to do a ml purge before loading other modules
ml purge

ml GCC/5.4.0-2.26  CUDA/8.0.61_375.26  impi/2017.3.196
ml GROMACS/2016.4

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

export OMP_NUM_THREADS=7
export MDRUN='gmx_mpi mdrun'

gmx tune_pme -mdrun "$MDRUN" -np $SLURM_NTASKS $mdargs -dlb yes -s npt.tpr -nocheck -nolaunch -steps 20000 -resetstep 5000 -ntpr 1 -r 3 # -npme all -rmax 3.0 -rmin 1.2 -ntpr 5
 
