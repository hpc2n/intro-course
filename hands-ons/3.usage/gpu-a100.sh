#!/bin/bash 
# Remember to change this to your own project ID after the course! 
#SBATCH -A hpc2n2023-102
#SBATCH --time=00:05:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --gres=gpu:a100:1

ml purge
ml CUDA/11.7.0

nvcc hello-world.cu -o hello
./hello
