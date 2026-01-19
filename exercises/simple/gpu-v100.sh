#!/bin/bash 
# This job script is for running on 1 V100 GPU. 
# Remember to change this to your own project ID after the course! 
#SBATCH -A hpc2n2026-002
#SBATCH --time=00:05:00
#SBATCH --gpus=1
#SBATCH -C v100

ml purge > /dev/null 2>&1
ml foss/2023b
ml CUDA/12.9.1

nvcc hello-world.cu -o hello
./hello
