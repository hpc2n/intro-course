#!/bin/bash
# Remember to change this to your own project ID after the course!
#SBATCH -A hpc2n2025-014
#SBATCH --time=00:05:00
#SBATCH --gpus=1
#SBATCH -C ''zen3|zen4'&GPU_AI'

ml purge > /dev/null 2>&1
ml CUDA/11.7.0

nvcc hello-world.cu -o hello
./hello
