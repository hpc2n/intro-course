#!/bin/bash 
# This job script is for running on 1 V100 GPU. Remember that we do not
# have a reservation for that, so you cannot use the reservation in
# this script
# Remember to change this to your own project ID after the course! 
#SBATCH -A hpc2n2023-132
#SBATCH --time=00:05:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --gres=gpu:v100:1

ml purge > /dev/null 2>&1
ml fosscuda/2020b

nvcc hello-world.cu -o hello
./hello
