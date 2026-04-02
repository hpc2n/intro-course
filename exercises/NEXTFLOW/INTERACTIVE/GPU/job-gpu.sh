#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --gpus-per-node=l40s:1
#SBATCH --time=01:00:00

ml Nextflow/25.10.0

#Home folder for Nextflow
export NXF_HOME=$PWD

nextflow run gpu.nf -c gpu.config -profile apptainer,gpu \
    --outdir $PWD \
    -resume

