#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:08:00
#SBATCH -N 1
#SBATCH -n 28
#SBATCH --gres=gpu:v100:x   # x = 1 or 2
##SBATCH --exclusive        # uncomment this line if x = 2 by removing one # symbol 

echo $CUDA_VISIBLE_DEVICES

#Load modules necessary for running NAMD
ml purge  > /dev/null 2>&1 
ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
ml NAMD/2.14-nompi 

namd2 +p28 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output_prod.dat

