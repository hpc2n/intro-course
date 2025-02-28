#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:28:00
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
# Choose the GPU Type
#SBATCH --gpus-per-node=Type:1

echo $CUDA_VISIBLE_DEVICES

#Load modules necessary for running NAMD
ml purge  > /dev/null 2>&1 
ml GCC/11.3.0  OpenMPI/4.1.4
ml NAMD/2.14-CUDA-11.7.0

# GPU info
nvidia-smi
echo "nr. cps on node" 
echo  $SLURM_CPUS_ON_NODE
namd2 +p$SLURM_CPUS_ON_NODE +setcpuaffinity +idlepoll +devices $CUDA_VISIBLE_DEVICES step4_equilibration.inp > output-nvidia.dat

