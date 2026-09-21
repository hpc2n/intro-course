#!/bin/bash
#SBATCH -A Project_ID      # Your project ID
#SBATCH -J ml-job          # Job name in the queue 
#SBATCH -t 00:05:00        # Wall time 
## lines starting with double ## are considered as comments
# For short sequences and monomers half node, 1 GPU card, would work 
#SBATCH --gpus-per-node=l40s:1

# Clean the environment from loaded modules
ml purge > /dev/null 2>&1

# Load module Tensorflow
ml GCC/12.3.0  OpenMPI/4.1.5
ml TensorFlow/2.15.1-CUDA-12.1.1

python ml.py
