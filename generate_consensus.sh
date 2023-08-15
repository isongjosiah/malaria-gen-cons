while getopts r:c: flag
do
    case "${flag}" in
        r) accession_list=${OPTARG};;
        c) text=${OPTARG};;
    esac
done
echo "Accession List: $accession_list";

function individual_consensus() {
    # generate reference index file
    # bowtie2-build -f "reference/Pfalciparum.genome.fasta" pf.genome
    while read -r line;
    do
        docker run  --rm -u $(id -u):$(id -g) -v ${PWD}:/data quay.io/biocontainers/fastq-dl:2.0.1--pyhdfd78af_0 fastq-dl --accession $line --outdir ./data/$line --verbose
        bowtie2 -x pf.genome -1 ./$line/${line}_1.fastq.gz -2 ./$line/${line}_2.fastq.gz -S $line.sam
        samtools view -bS -o $line.bam
        samtools sort $line.bam -o $line.sorted.bam
        samtools index $line.sorted.bam
        samtools consensus -f fasta $line.bam -o ./consensus/$line.cons.fa
    done < $accession_list 

    cd consensus
    cat *.fa > ../consensus.fa
}

individual_consensus