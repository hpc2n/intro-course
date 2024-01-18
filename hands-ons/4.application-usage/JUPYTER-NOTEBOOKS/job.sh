#!/bin/bash          
# Here you should put your own project id
#SBATCH -A Project_ID
# This example asks for 1 core
#SBATCH -n 1         
# Ask for a suitable amount of time. Remember, this is the time the Jupyter notebook will be available! HHH:MM:SS.
#SBATCH --time=00:10:00
# If you use the AMD GPU nodes uncomment the following lines
##SBATCH -p amd_gpu
##SBATCH --gres=gpu:a100:1

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1
# Load the module environment suitable for the job                                                                                       
module load GCCcore/12.3.0 JupyterLab/4.0.5
# Start JupyterLab
jupyter lab --no-browser --ip $(hostname)

