#!/bin/bash 
# Remember to change this to your own project ID! 
#SBATCH -A Project_ID
#SBATCH --time=00:03:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --gres=gpu:k80:1

ml purge
module add GCC/8.2.0-2.31.1
module add Python/3.7.2
module add CUDA/10.1.105
module add OpenMPI/3.1.3
module add PyTorch/1.2.0-Python-3.7.2
module add matplotlib/3.0.3-Python-3.7.2
module add torchvision/0.3.0-Python-3.7.2

srun python pytorch_gpu.py
