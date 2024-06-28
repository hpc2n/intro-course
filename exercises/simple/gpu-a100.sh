#!/bin/bash 
# Remember to change this to your own project ID after the course! 
#SBATCH -A hpc2n2023-132
#SBATCH --time=00:05:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
# Remove one # from the line below to use the reservation. ONLY during the course
##SBATCH --reservation=intro-gpu
#SBATCH --gres=gpu:a100:1

ml purge > /dev/null 2>&1
ml CUDA/11.7.0

nvcc hello-world.cu -o hello
./hello
