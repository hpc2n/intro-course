#!/bin/bash 
# This job script is for running on 1 V100 GPU. 
# Remember to change this to your own project ID after the course! 
#SBATCH -A hpc2n2024-084
#SBATCH --time=00:05:00
#SBATCH --gpus=:v100:1

ml purge > /dev/null 2>&1
ml fosscuda/2020b

nvcc hello-world.cu -o hello
./hello
