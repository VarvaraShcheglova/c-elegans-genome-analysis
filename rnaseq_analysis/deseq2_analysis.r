#Load necessary libraries
library("DESeq2")
library("pheatmap")

#Load count_matrix.txt with gene counts
data = read.table("count_matrix.txt", header = TRUE, row.names = 1)

#Retain only count columns
counts = data[, -c(1,2,3,4,5)]

#Define samples
samples = cbind(colnames(counts), c("pha4", "pha4", "end1", "end1", "cnd1", "cnd1"))
colnames(samples) = c("Sample", "Celltype")

#Create DESeq2 object
dsdata = DESeqDataSetFromMatrix(countData = counts, colData = samples, design = ~ Celltype)

#Normalization to avoid outliers
rld = rlog(dsdata, blind = FALSE)
vst_data = vst(dsdata, blind = FALSE)

#Quality checks
#Distance matrix heatmap 
sampleDists = dist(t(assay(vst_data)))
sampleDistMatrix = as.matrix(sampleDists)
pheatmap(sampleDistMatrix, clustering_distance_rows = sampleDists,
         clustering_distance_cols = sampleDists)

#PCA plots
plotPCA(rld, intgroup = c("Sample", "Celltype"))
plotPCA(DESeqTransform(dsdata), intgroup = c("Sample", "Celltype"))

#Differential Expression Analysis
dds = DESeq(dsdata)

#Compare pha4 vs end1
res = results(dds, contrast = c("Celltype", "pha4", "end1"))
plotMA(res, ylim = c(-2, 2))

#Get the most significant genes
resSig = subset(res, res$padj <= 0.05 & res$log2FoldChange > 0)
sigm = assay(rld)[rownames(resSig), ]
pheatmap(sigm, scale = "row", trace = "none", show_rownames = FALSE, key = TRUE)
write.table(as.data.frame(resSig), file = "output_pha4_vs_end1.tsv", sep = "\t", quote = FALSE)

#Compare pha4 vs cnd1
res1 = results(dds, contrast = c("Celltype", "pha4", "cnd1"))
plotMA(res1, ylim = c(-2, 2))

#Significant genes for second comparison
resSig1 = subset(res1, res1$padj <= 0.05 & res1$log2FoldChange > 0)

#Find common upregulated genes
unique_pha4 = intersect(rownames(resSig), rownames(resSig1))
sigm_unique = assay(rld)[unique_pha4, ]
pheatmap(sigm_unique, scale = "row", trace = "none", show_rownames = FALSE, key = TRUE)

#Select highly significant genes (p-value < 1e-7)
very_significant_genes = subset(res, padj <= 1e-7)
high_sig_names = rownames(very_significant_genes)
print(high_sig_names)

#Save normalized counts
rldm = assay(rld)
write.table(as.data.frame(rldm), file = "rldm.tsv", sep = "\t", quote = FALSE)