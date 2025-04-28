#!/bin/bash
module load conda
conda activate flye-2.9.5
flye -t 8 -o flye_asm --pacbio-hifi reads.fastq

