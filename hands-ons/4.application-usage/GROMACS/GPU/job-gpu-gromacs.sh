#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:10:00
#SBATCH -n 4
#SBATCH -c 7
# Asking for 2 GPUs
#SBATCH --gres=gpu:k80:2
#SBATCH --exclusive


if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

#Information about GPUs
nvidia-smi
echo $CUDA_VISIBLE_DEVICES 

# It is always best to do a ml purge before loading other modules
ml purge
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml GROMACS/2019.4-PLUMED-2.5.4

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top

#MPI version (Default)
mpirun -np $SLURM_NTASKS gmx_mpi mdrun $mdargs -dlb yes  -v -deffnm step4.1_equilibration

#MPI version (Offloading nb and pme to gpus)
mpirun -np $SLURM_NTASKS gmx_mpi mdrun -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration

#Threaded-MPI version
gmx mdrun -ntmpi $SLURM_NTASKS -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration

#More information on GROMACS performance 
#  https://manual.gromacs.org/2019.4/user-guide/mdrun-performance.html
