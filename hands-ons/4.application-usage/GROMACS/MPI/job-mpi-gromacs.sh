#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n #*FIXME*
#SBATCH -c #*FIXME*
# For AMD nodes uncomment the following line
##SBATCH -p amd

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1

ml GCC/10.2.0  OpenMPI/4.0.5
ml GROMACS/2021
# For AMD CPUs uncomment the following two lines and comment out the previous two
#ml GCC/11.3.0  OpenMPI/4.1.4
#ml GROMACS/2023.1

if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MDRUN='gmx_mpi mdrun'
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
mpirun -np $SLURM_NTASKS $MDRUN $mdargs -dlb yes  -v -deffnm step4.1_equilibration

