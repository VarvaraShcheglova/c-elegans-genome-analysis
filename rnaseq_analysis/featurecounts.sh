#!/bin/bash

#Load necessary modules
module load subread

# Obtaining feature counts for each sample

srun -c8 -n1 --mem=40G featureCounts \
  -g Parent \
  -t exon \
  -M \
  -a Caenorhabditis_elegans.WBcel235.46.gff3 \
  -o count_matrix.txt \
  -p -s 1 -T 8 \
  pha4_1Aligned.out.bam \
  pha4_2Aligned.out.bam \
  ../GROUP2GENOME/data/end1_1Aligned.out.bam \
  ../GROUP2GENOME/data/end1_2Aligned.out.bam \
  ../GROUP1/cnd1_1Aligned.out.bam \
  ../GROUP1/cnd1_2Aligned.out.bam  
