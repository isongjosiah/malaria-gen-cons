# setup the fastq-dl conda environment
docker pull quay.io/biocontainers/fastq-dl:2.0.1--pyhdfd78af_0

conda create --name bioinfo
conda activate bioinfo
conda install bowtie2 samtools