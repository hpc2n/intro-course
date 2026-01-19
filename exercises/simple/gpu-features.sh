#!/bin/bash
# Remember to change this to your own project ID after the course!
#SBATCH -A hpc2n2026-002
#SBATCH --time=00:05:00
#SBATCH --gpus=1
#SBATCH -C ''zen3|zen4'&GPU_AI'

ml purge > /dev/null 2>&1
ml CUDA/12.9.1

nvcc hello-world.cu -o hello
./hello
