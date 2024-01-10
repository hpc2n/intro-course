#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -N 1
#SBATCH -n 4
#SBATCH -c 7
# Asking for V100 GPU
#SBATCH --gres=gpu:v100:2
# Asking for A100 GPU comment previous line and uncomment the next two lines
##SBATCH -p amd_gpu
##SBATCH --gres=gpu:a100:2
#SBATCH --exclusive


if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    mdargs="-ntomp $SLURM_CPUS_PER_TASK"
else
    mdargs="-ntomp 1"
fi

#Information about GPUs
nvidia-smi
echo $CUDA_VISIBLE_DEVICES 

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1
# For V100 GPU
ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml GROMACS/2021
# For A100 GPU
#ml GCC/11.3.0  OpenMPI/4.1.4
#ml GROMACS/2023.1-CUDA-11.7.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
gmx grompp -f step4.1_equilibration.mdp -o step4.1_equilibration.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
sleep 10

#Three different ways to run this job:
#1. MPI version (Default)
mpirun -np $SLURM_NTASKS gmx_mpi mdrun $mdargs -dlb yes  -v -deffnm step4.1_equilibration
sleep 10

#2. MPI version (Offloading nb and pme to gpus)
mpirun -np $SLURM_NTASKS gmx_mpi mdrun -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration
sleep 10

#3. Threaded-MPI version (Offloading nb and pme to gpus)
gmx mdrun -ntmpi $SLURM_NTASKS -nb gpu -pme gpu -npme 1 $mdargs -dlb yes  -v -deffnm step4.1_equilibration
