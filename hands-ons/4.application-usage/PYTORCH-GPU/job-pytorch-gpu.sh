#!/bin/bash 
# Remember to change this to your own project ID! 
#SBATCH -A Project_ID
#SBATCH --time=00:05:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --gres=gpu:v100:x   # x = 1 or 2
##SBATCH --exclusive        # uncomment this line if x = 2 by removing one # symbol 

ml purge  > /dev/null 2>&1

ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml matplotlib/3.3.3
ml PyTorch/1.7.1 
ml torchvision 

srun python pytorch_gpu.py
