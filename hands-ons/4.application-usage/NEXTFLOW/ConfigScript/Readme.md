# Load Nextflow
ml Nextflow/22.10.1

# Run Nextflow on the terminal
nextflow run wc.nf -c hpc2n.config --input file.txt.gz --project hpc2nQ-XYZ --clusterOptions "-t 00:05:00 -n 28" 
