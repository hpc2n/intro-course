#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -N 2          # Two nodes will be allocated
#SBATCH -n 8          # 8 MPI tasks will be run, 4 per node
#SBATCH -c 7          # 7 OpenMP threads per node will be used 
#SBATCH -t 00:15:00
#SBATCH --exclusive

# Running Gromacs by using the container
ml purge  > /dev/null 2>&1
export OMP_NUM_THREADS=7
ml GCC/9.3.0 OpenMPI/4.0.3 
srun apptainer exec Gromacs.sif /usr/bin/mdrun_mpi -ntomp 7 -s benchMEM.tpr -nsteps 10000 -resethway

# Running Gromacs that is module-installed
ml purge  > /dev/null 2>&1
export OMP_NUM_THREADS=7
ml GCC/8.3.0  OpenMPI/3.1.4 GROMACS/2019.4-PLUMED-2.5.4
srun gmx_mpi mdrun -ntomp 7 -s benchMEM.tpr -nsteps 10000 -resethway
