#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:28:00
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
# Choose the GPU Type
#SBATCH --gpus-per-node=a100:1

echo $CUDA_VISIBLE_DEVICES

#Load modules necessary for running NAMD
ml purge  > /dev/null 2>&1 
ml GCC/13.3.0  OpenMPI/5.0.3 NAMD/3.0.1-CUDA-12.6.0

namd3 +p1 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output-nvidia.dat


