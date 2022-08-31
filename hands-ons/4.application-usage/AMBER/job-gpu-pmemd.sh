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

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1

ml GCC/10.2.0  CUDA/11.1.1  OpenMPI/4.0.5
ml Amber/20.11-AmberTools-21.3 

#Tutorial can be found at: http://ambermd.org/tutorials/pengfei/index.php

#Production
export init="solvated_1fsc"
export pstep="02_Heat"
export istep="03_Prod"
srun pmemd.cuda_SPFP.MPI -O -i ${istep}.in -p ${init}.top -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo_2 -x ${istep}.nc

