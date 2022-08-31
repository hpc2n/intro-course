#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -c 7

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1

ml GCC/10.2.0  OpenMPI/4.0.5
ml GROMACS/2021

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MDRUN='gmx_mpi mdrun'
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
mpirun -np $SLURM_NTASKS $MDRUN $mdargs -dlb yes  -v -deffnm nvt

