#!/bin/bash
# Remember to change this to your own project ID after the course!
#SBATCH -A hpc2n2025-151
#SBATCH -t 00:15:00
#SBATCH -N 1
#SBATCH -n 24
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
#SBATCH --gpus=1
#SBATCH -C l40s
#SBATCH --exclusive

ml purge > /dev/null 2>&1
ml GCC/12.3.0 Python/3.11.3 OpenMPI/4.1.5 SciPy-bundle/2023.07 CUDA/12.1.1 numba/0.58.1

python integration2d_gpu.py
python integration2d_gpu_shared.py
