#!/bin/bash
#SBATCH -A Project_ID      # Your project ID
#SBATCH -J multimer        # Job name in the queue 
#SBATCH -t 00:05:00        # Wall time 
#SBATCH --array=0-7                   # Array range 
## lines starting with double ## are considered as comments
# For a whole node, 2 GPU cards, (could be useful depending on the 
# length of the sequence and number nmers
##SBATCH -c 28
##SBATCH --gpus-per-node=l40s:2
# For short sequences and monomers half node, 1 GPU card, would work 
#SBATCH -c 14 
#SBATCH --gpus-per-node=l40s:1

# Clean the environment from loaded modules
ml purge > /dev/null 2>&1

# Load AlphaFold
ml GCC/12.3.0  OpenMPI/4.1.5
ml AlphaFold/2.3.2-CUDA-12.1.1

nvidia-smi

# Comment or uncomment the following exporting variables depending on whether
# you want to use a whole node or half or the node
# For a whole node as suggested above
#export ALPHAFOLD_HHBLITS_N_CPU=28
# For a half node as suggested above
export ALPHAFOLD_HHBLITS_N_CPU=14

file=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" list_sequences.txt)
alphafold --fasta_paths="$file" --max_template_date=2024-01-10 --model_preset=multimer  --output_dir=$PWD 
