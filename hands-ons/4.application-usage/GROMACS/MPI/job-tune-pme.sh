#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -n 4
#SBATCH -c 7

# It is a good idea to do a ml purge before loading other modules
ml purge

ml GCC/10.2.0  OpenMPI/4.0.5
ml GROMACS/2021

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MDRUN='gmx_mpi mdrun'
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top

gmx tune_pme -mdrun "$MDRUN" -np $SLURM_NTASKS $mdargs -dlb yes -s step4.1_equilibration.tpr -nocheck -nolaunch -steps 2000 -resetstep 1000 -ntpr 4 -r 2 -min 0.0 -max 0.5 
 
