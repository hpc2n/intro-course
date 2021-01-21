#!/bin/bash
#SBATCH -A SNIC2020-5-235  
#SBATCH -t 00:03:00
#SBATCH -n 1

#Load modules necessary for running MATLAB
ml MATLAB/2019b.Update2

srun matlab -nodisplay -singleCompThread -r "funct(10000);exit" > out.log

exit 0
