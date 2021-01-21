#!/bin/bash
# This is the job script to run a AMBER example job 
# Remember to change the following to your own Project ID! 
#SBATCH -A Project_ID
#SBATCH -J Amber
#SBATCH -t 00:10:00
#SBATCH -N 1
#SBATCH -n 28

ml purge

ml GCC/8.3.0  OpenMPI/3.1.4
ml Amber/18-AmberTools-19-patchlevel-12-17-Python-2.7.16

#Tutorial can be found at: http://ambermd.org/tutorials/pengfei/index.php

#Production
export init="solvated_1fsc"
export pstep="02_Heat"
export istep="03_Prod"
srun pmemd.MPI -O -i ${istep}.in -p ${init}.top -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -x ${istep}.nc

