#!/bin/bash
#SBATCH -A Project_ID
#Asking for 12 min.
#SBATCH -t 00:12:00
#SBATCH --array=1-28
#SBATCH -c 1
#Writing output and error files
#SBATCH --output=Array_test.%A_%a.out
#SBATCH --error=Array_test.%A_%a.error


#Load modules necessary for running MATLAB
ml MATLAB/2021b

matlab -nodisplay -nojvm -r "funct($SLURM_ARRAY_TASK_ID);exit" 

exit 0
