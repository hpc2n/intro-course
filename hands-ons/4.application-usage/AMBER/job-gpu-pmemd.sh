#!/bin/bash
# This is the job script to run a AMBER example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Amber
#SBATCH -t 00:10:00
#SBATCH -N 1
#SBATCH -n 4
# Asking for 2 GPUs
#SBATCH --gres=gpu:k80:2
#SBATCH --exclusive

# It is always best to do a ml purge before loading other modules
ml purge

#ml GCC/8.3.0  CUDA/10.1.243  OpenMPI/3.1.4
#ml Amber/18-AmberTools-19-patchlevel-12-17-Python-2.7.16

ml GCC/7.3.0-2.30  CUDA/9.2.88  OpenMPI/3.1.1
ml Amber/18-AmberTools-18-patchlevel-10-8

#Tutorial can be found at: http://ambermd.org/tutorials/pengfei/index.php
#Production
export init="solvated_1fsc"
export pstep="02_Heat"
export istep="03_Prod"
#mpirun -np 4 pmemd.cuda.MPI -O -i ${istep}.in -p ${init}.top -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -x ${istep}.nc
srun pmemd.cuda.MPI -O -i ${istep}.in -p ${init}.top -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -x ${istep}.nc

