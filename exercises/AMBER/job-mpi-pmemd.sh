#!/bin/bash
# This is the job script to run a AMBER example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Amber
#SBATCH -t 00:10:00
#SBATCH -n 28    # nr. of MPI tasks

# It is a good idea to do a ml purge before loading other modules
ml purge > /dev/null 2>&1

ml GCC/11.3.0  OpenMPI/4.1.4
ml Amber/22.4-AmberTools-22.5-CUDA-11.7.0

#Tutorial can be found at: http://ambermd.org/tutorials/pengfei/index.php

#Production
export init="solvated_1fsc"
export pstep="02_Heat"
export istep="03_Prod"
srun pmemd.MPI -O -i ${istep}.in -p ${init}.top -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -x ${istep}.nc

