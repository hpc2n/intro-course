#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -J namd
#SBATCH -t 00:28:00
#SBATCH -o output_%j.out   # output file
#SBATCH -e error_%j.err    # error messages
# Choose the GPU Type
#SBATCH --gpus-per-node=mi100:1
 
ml purge > /dev/null 2>&1

echo "nr. cps on node" 
echo  $SLURM_CPUS_ON_NODE
# 1. NAMD with some computations offloaded to the GPUs
apptainer run /path-to-my-folder/namd3_3.0a9.sif namd3 step4_equilibration.inp +p$SLURM_CPUS_ON_NODE +setcpuaffinity  +devices 0 > output-amdgpu1.log

# 2. NAMD Resident mode where most of computations are offloaded to the GPUs
apptainer run /path-to-my-folder/namd3_3.0a9.sif namd3 step4_equilibration-amdgpu.inp +p$SLURM_CPUS_ON_NODE +setcpuaffinity  +devices 0 > output-amdgpu2.log

