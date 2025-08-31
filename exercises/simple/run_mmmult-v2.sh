#!/bin/bash
# Change to your own project ID! 
#SBATCH -A hpc2n2025-151
#SBATCH --time=00:20:00 # Asking for 20 minutes
#SBATCH -n 1 # Asking for 1 core

# Load any modules you need, here for Python 3.11.3 and compatible SciPy-bundle
module purge  > /dev/null 2>&1
module load GCC/12.3.0 OpenMPI/4.1.5 Python/3.11.3 SciPy-bundle/2023.07

# Run your Python script
python mmmult-v2.py

