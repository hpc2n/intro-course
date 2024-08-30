#!/bin/bash
#SBATCH -A Project_ID      # Your project ID
#SBATCH -J monomer         # Job name in the queue 
#SBATCH -t 02:00:00        # Wall time 
## lines starting with double ## are considered as comments
# For a whole node, 2 GPU cards, (could be useful depending on the 
# length of the sequence and number nmers
##SBATCH -c 28
##SBATCH --gres=gpu:Type:2
##SBATCH --exclusive
# For short sequences and monomers half node, 1 GPU card, would work 
#SBATCH -c 14 
#SBATCH --gres=gpu:Type:1

# Clean the environment from loaded modules
ml purge > /dev/null 2>&1

# Load AlphaFold
ml GCC/12.3.0  OpenMPI/4.1.5
ml AlphaFold/2.3.2-CUDA-12.1.1

# Comment or uncomment the following exporting variables depending on whether
# you want to use a whole node or half or the node
# For a whole node as suggested above
#export ALPHAFOLD_HHBLITS_N_CPU=28
# For a half node as suggested above
export ALPHAFOLD_HHBLITS_N_CPU=14

alphafold --fasta_paths=my_fasta_sequence.fasta --max_template_date=2024-01-10 --model_preset=monomer  --output_dir=$PWD 
