#!/bin/bash 
# Remember to change this to your own project ID after the course! 
#SBATCH -A SNIC2022-22-642
#SBATCH --time=00:05:00
#SBATCH --error=job.%J.err
#SBATCH --output=job.%J.out
#SBATCH --gres=gpu:k80:1
# The reservation is only valid during the course and has been commented out here! Remove the out-commenting if you are at the course and wish to use the reservation
##SBATCH --reservation=intro-gpu

ml purge
ml fosscuda/2020b

nvcc hello-world.cu -o hello
./hello
