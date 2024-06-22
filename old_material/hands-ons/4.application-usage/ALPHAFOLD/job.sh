#!/bin/bash
#SBATCH -A Project_ID      # Your project ID
#SBATCH -J multimer        # Job name in the queue 
#SBATCH -t 35:00:00        # Wall time 
# For a whole node, 2 GPU cards, (could be useful depending on the 
# length of the sequence and number nmers
#SBATCH -c 28
#SBATCH --gres=gpu:v100:2
#SBATCH --exclusive
# For short sequences and monomers half node, 1 GPU card, would work 
# (comment previous three lines and uncomment the following two by removing one #)
##SBATCH -c 14 
##SBATCH --gres=gpu:v100:1

# Clean the environment from loaded modules
ml purge > /dev/null 2>&1

# Load AlphaFold
ml GCC/10.3.0  OpenMPI/4.1.1
ml AlphaFold/2.2.2-CUDA-11.3.1

# Comment or uncomment the following exporting variables depending on whether
# you want to use a whole node or half or the node
# For a whole node as suggested above
export ALPHAFOLD_HHBLITS_N_CPU=28
# For a half node as suggested above
#export ALPHAFOLD_HHBLITS_N_CPU=14

# This works for the multimer
alphafold --fasta_paths=my-fasta-sequence.fasta --max_template_date=2023-11-20 --model_preset=multimer --output_dir=$PWD
# This works for the monomer
#alphafold --fasta_paths=my-fasta-sequence.fasta --max_template_date=2023-11-20 --model_preset=monomer --output_dir=$PWD
