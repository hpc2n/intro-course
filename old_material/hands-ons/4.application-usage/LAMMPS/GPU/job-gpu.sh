#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -t 00:10:00
#SBATCH -c 1
#SBATCH -n 1
#SBATCH --gres=gpu:v100:x    # x = 1 or 2
##SBATCH --exclusive        # uncomment this line if x = 2 by removing one # symbol 

#Load modules necessary for running LAMMPS
ml purge > /dev/null 2>&1
ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread 
export OMP_PLACES=threads
srun lmp -in in_3.lj -k on g 1 -sf kk -pk kokkos cuda/aware off > output_gpu.dat

