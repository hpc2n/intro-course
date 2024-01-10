#!/bin/bash
# This is the job script to run a GROMACS example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Gromacs
#SBATCH -t 00:30:00
#SBATCH -n 1
#SBATCH -c 12
# Asking for 1 A100 GPU card
#SBATCH -p amd_gpu
#SBATCH --gres=gpu:a100:1


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
ml GCC/11.3.0  OpenMPI/4.1.4
ml GROMACS/2023.1-CUDA-11.7.0

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

#4. Running on AMD nodes
gmx grompp -f step4.1_equilibration-amd.mdp -o step4.1_equilibration-amd.tpr -c step4.0_minimization.gro -r step3_charmm2gmx.pdb -n index.ndx -p topol.top
gmx mdrun -nb gpu -pme gpu -bonded gpu -update gpu -ntomp 12 -ntmpi 1 -dlb yes  -v -deffnm step4.1_equilibration-amd
