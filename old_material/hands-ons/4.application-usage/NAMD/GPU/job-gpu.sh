#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:68:00
##SBATCH -N 1
#SBATCH -c 14
##SBATCH --exclusive        # uncomment this line if x = 2 by removing one # symbol 
#SBATCH --gpus-per-node=h100:1
#SBATCH -p newbatch
##SBATCH --gres=gpu:v100:1   # x = 1 or 2
##SBATCH -p skylake

echo $CUDA_VISIBLE_DEVICES

#Load modules necessary for running NAMD (skylake nodes)
ml purge  > /dev/null 2>&1 
#ml GCC/9.3.0  CUDA/11.0.2  OpenMPI/4.0.3
#ml NAMD/2.14-nompi 

#Load modules necessary for running NAMD (AMD nodes)
ml GCC/11.3.0  OpenMPI/4.1.4 NAMD/2.14-CUDA-11.7.0

namd2 +p14 +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output_prod.dat

