#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -t 00:03:00
#SBATCH -n 1

#Load modules necessary for running MATLAB
ml MATLAB/2021a

srun matlab -nodisplay -singleCompThread -r "funct(10000);exit" > out.log

exit 0
