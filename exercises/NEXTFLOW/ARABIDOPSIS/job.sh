#!/bin/bash
#SBATCH -A Project_ID
#SBATCH -N 1
#SBATCH -n 14
#SBATCH --output=Chip_seq_analysis.out
#SBATCH --error=Chip_seq_analysis.err
#SBATCH --time=02:50:00

ml Nextflow/24.04.2

#Variable for Java
export NXF_OPTS='-Xms1g -Xmx4g'
#Cache dir for singularity image storage
export NXF_SINGULARITY_CACHEDIR=$PWD/sing-img
#Home folder for Nextflow
export NXF_HOME=$PWD/home-nextflow

nextflow run nf-core/rnaseq \
    -profile singularity \
    --input design_test.csv \
    --genome 'TAIR10' \
    --max_cpus '14' \
    --max_memory '60GB' \
    --outdir $PWD \
    -resume

