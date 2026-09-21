#!/bin/bash
#SBATCH -A Project_ID
#Asking for 10 min.
#SBATCH -t 00:10:00
#SBATCH -n 4
#SBATCH --gpus-per-node=l40s:1
#Writing output and error files
#SBATCH --output=output%J.out
#SBATCH --error=error%J.error

ml purge > /dev/null 2>&1
#R version 4.4.1 is the only one compiled for CUDA
ml GCC/13.2.0 R/4.4.1
ml Python/3.11.5
ml CUDA/12.6.0
ml OpenSSL/3

R --no-save --no-restore -f ML-GPU.R
