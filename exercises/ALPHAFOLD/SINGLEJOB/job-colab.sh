#!/bin/bash
#SBATCH -A Project_ID      # Your project ID
#SBATCH -J monomer         # Job name in the queue 
#SBATCH -t 15:00:00        # Wall time 
## lines starting with double ## are considered as comments
# MSA on CPUs
#SBATCH -c 14 
# Prediction on GPUs
##SBATCH --gpus-per-node=l40s:1

# Clean the environment from loaded modules
ml purge > /dev/null 2>&1

ml GCC/13.3.0  OpenMPI/5.0.3 ColabFold/1.5.2-CUDA-12.6.0

# MSA on CPU
colabfold_search my_fasta_sequence.fasta  /pfs/data/databases/ColabFold --db1 uniref30_2302_db  ./my-dir 
# Prediction on GPU
#colabfold_batch ./my-dir/0.a3m ./my-dir --max-msa "10:20" --num-recycle 1 --num-seeds 10

