#!/bin/bash
module load conda
conda activate hifiasm
hifiasm -t 8 -o hifiasm_asm reads.fastq
