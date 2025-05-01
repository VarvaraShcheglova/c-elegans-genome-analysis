# Genome Assembly and Differential Expression Analysis of *C. elegans*

This project demonstrates a full genome assembly and RNA-seq analysis pipeline, performed in an HPC environment.

---

## Project Goals

- Assemble the *C. elegans* genome using raw long-read sequencing data (PacBio HiFi).
- Compare two assemblers: **Flye** and **Hifiasm**.
- Evaluate assembly quality using **BUSCO** and **QUAST**.
- Perform **RNA-seq analysis** to identify differentially expressed genes between developmental tissues (pha-4, end-1, cnd-1).
- Visualize expression data using **PCA**, **heatmaps**, and **MA plots**.
- Select top gene candidates for downstream biological interpretation.

---

## Tools & Technologies

- **Genome assembly**: Flye v2.9.5, Hifiasm
- **Quality control**: FastQC, QUAST, BUSCO
- **RNA-seq pipeline**:
  - Alignment: STAR
  - Quantification: FeatureCounts
  - Analysis: DESeq2
- **Languages & Environment**:  
  - R (DESeq2, pheatmap)  
  - Shell scripts (SLURM HPC)  
  - Python/Unix commands

---
## Key Results

- Flye assembly outperformed Hifiasm in BUSCO completeness (Flye: **96.8%** vs Hifiasm: **94.4%**).
- RNA-seq mapping rates were **>70%**, confirming pipeline reliability.
- **167 genes** were significantly upregulated in pha-4 vs both other tissues.
- From these, **25 genes (p < 1e-7)** were selected as top candidates.
- Visualized using PCA plots, MA plots, and clustered heatmaps.
- Final **top 10** pha-4-specific genes were selected based on known involvement in pharynx development, muscle structure, and neuronal signaling.
