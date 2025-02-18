#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -t 20:10:00
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --gpus-per-node=Type:1
#SBATCH --output=job_str.out
#SBATCH --error=job_str.err

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1
ml gaussian/16.C.02-AVX2

# For Gaussian 16 set the %Cpu parameter (and %GpuCpu if GPUs have been requested)
g16.set-cpu+gpu-list input.com

# Start Gaussian, example here is assuming Gaussian 16. Replace g16 with g09 for Gaussian 09.
g16 input.com
