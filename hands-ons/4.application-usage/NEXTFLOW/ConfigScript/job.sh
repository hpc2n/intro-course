#!/bin/bash
#SBATCH -A hpc2n202Q-XYZ        
#SBATCH -n 28
#SBATCH -t 00:05:00
#SBATCH --output=JobOutput.out
#SBATCH --error=JobError.err

ml Nextflow/22.10.1

nextflow run wc.nf --input file.txt.gz
