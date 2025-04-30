#This script visualizes the top 10 genes sorted by p-value and log2 fold change
#The used data is from DESeq2 differential analysis (output.tsv and rldm.tsv)

library(pheatmap)

#Read differential expression results
data = read.table("output.tsv", header = TRUE, row.names = 1)
rldm = read.table("rldm.tsv", header = TRUE, row.names = 1)

#Top 10 by p-value
pval = data[order(data$pvalue), ]
pval_best = rownames(pval[1:10, ])
pheatmap(rldm[pval_best, ], scale = "row", trace = "none", cluster_rows = FALSE, cluster_cols = FALSE, key = TRUE)

#Top 10 by log2 fold change
change = data[order(data$log2FoldChange, decreasing = TRUE), ]
change_best = rownames(change[1:10, ])
pheatmap(rldm[change_best, ], scale = "row", trace = "none", cluster_rows = FALSE, cluster_cols = FALSE, key = TRUE)

#Transcript IDs can be searched in ENSEMBL for biological interpretation