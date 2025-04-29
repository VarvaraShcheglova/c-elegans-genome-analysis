# RNA-seq Analysis Pipeline

This folder contains scripts for processing *Caenorhabditis elegans* RNA-seq data as part of a genome analysis and gene expression study.

## Steps Included

1. **Genome Indexing and Read Mapping**
   - Script: `star_mapping.sh`
   - Tools: [STAR aligner](https://github.com/alexdobin/STAR)
   - Description: Aligns paired-end RNA-seq reads to the *C. elegans* reference genome (WBcel235).

2. **Feature Counting**
   - Script: `featurecounts.sh`
   - Tools: [Subread FeatureCounts](http://bioinf.wehi.edu.au/featureCounts/)
   - Description: Generates a count matrix of gene-level expression.

3. **Differential Gene Expression Analysis**
   - Script: `deseq2_analysis.R`
   - Tools: [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html), `pheatmap`
   - Description: normalization (VST/RLOG), sample clustering, PCA, and detection of differentially expressed genes.

## Notes

- Scripts assume a typical HPC environment with `srun`, `module load`, and SLURM job scheduling.
- Output data (e.g. BAM, count matrix) is not uploaded to this repository
- Final results include heatmaps, PCA plots, and lists of significantly upregulated genes across biological conditions.
