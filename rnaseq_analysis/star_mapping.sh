#!/bin/bash

# Load necessary modules
module load star
module load samtools

# Genome indexing from the reference genome (WBcel235)
srun -c4 -n1 --mem=40G STAR --runMode genomeGenerate \
  --genomeDir star_index \
  --genomeFastaFiles Caenorhabditis_elegans.WBcel235.dna.toplevel.fa

# Alignment of RNA-seq reads

# For pha-4 condition (pharynx differentiation)
srun -c8 -n1 --mem=40G STAR --runMode alignReads --genomeDir star_index --runThreadN 8 \
  --outSAMtype BAM Unsorted \
  --readFilesIn ../TRANSCRIPTOME1/pha4_rep1_left.fastq ../TRANSCRIPTOME1/pha4_rep1_right.fastq \
  --outFileNamePrefix pha4_1_

srun -c8 -n1 --mem=40G STAR --runMode alignReads --genomeDir star_index --runThreadN 8 \
  --outSAMtype BAM Unsorted \
  --readFilesIn ../TRANSCRIPTOME1/pha4_rep2_left.fastq ../TRANSCRIPTOME1/pha4_rep2_right.fastq \
  --outFileNamePrefix pha4_2_

#For cnd-1 condition (neuronal lineage commitment)
srun -c8 -n1 --mem=40G STAR --runMode alignReads --genomeDir star_index --runThreadN 8 \
  --outSAMtype BAM Unsorted \
  --readFilesIn ../group5transcriptome/cnd1_rep1_left.fastq ../group5transcriptome/cnd1_rep1_right.fastq \
  --outFileNamePrefix cnd1_1_

srun -c8 -n1 --mem=40G STAR --runMode alignReads --genomeDir star_index --runThreadN 8 \
  --outSAMtype BAM Unsorted \
  --readFilesIn ../group5transcriptome/cnd1_rep2_left.fastq ../group5transcriptome/cnd1_rep2_right.fastq \
  --outFileNamePrefix cnd1_2_

#Check mapping quality (mapping rates)
samtools flagstat pha4_1Aligned.out.bam
samtools flagstat pha4_2Aligned.out.bam
samtools flagstat cnd1_1Aligned.out.bam
samtools flagstat cnd1_2Aligned.out.bam
