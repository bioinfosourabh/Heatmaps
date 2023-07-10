install.packages("tidyverse")
install.packages('pheatmap')
install.packages('matrixStats')
install.packages('dplyr')


library(RColorBrewer)
library(dplyr)
library(tidyverse)
library(matrixStats)
library(pheatmap)


group <- read.table("colData.txt")
df <- read.csv("Differentially_expressed_genes")
class(df)
class(group)
df %>% select(1:13) %>% column_to_rownames("Gene") -> heatmap_data
heatmap_data %>% pheatmap()
png("test.png",width=8,height=8,units="in",res=1500)
heatmap_data %>% pheatmap()
dev.off()

heatmap_data %>% log2() -> heatmap_data_log
heatmap_data_log %>% pheatmap()
png("test2.png",width=8,height=8,units="in",res=1500)
heatmap_data_log %>% pheatmap()
dev.off()

heatmap_data_log - rowMeans((heatmap_data_log)) -> heatmap_data_meanSubtract
heatmap_data_meanSubtract %>% pheatmap()
png("test3.png",width=8,height=8,units="in",res=1500)
heatmap_data_meanSubtract %>% pheatmap()
dev.off()

heatmap_data_meanSubtract/rowSds(as.matrix(heatmap_data_log)) -> heatmap_data_zscores
png("z_new_1.5.png",width=8,height=8,units="in",res=1500)
heatmap_data_zscores %>% pheatmap(color=colorRampPalette(rev(brewer.pal(n = 7, name ="RdYlBu")))(100), annotation_col = group, border_color = NA,show_rownames = F)
dev.off()

pheatmap(heatmap_data_zscores, annotation_col = group, main = "heatmap") 
rownames(group_data) <- colnames(heatmap_data_zscores)
rownames(group_data)

group %>% select(1:2) %>% column_to_rownames("") -> group_data

group_data

png("test5.png",width=8,height=8,units="in",res=1500)
heatmap_data_log %>% pheatmap(scale= "row")
dev.off()


heatmap_data_meanSubtract %>% dist() %>% hclust() -> heatmap_rowClusters
heatmap_data_meanSubtract %>% pheatmap(cluster_cols = F,
                                       cluster_rows = heatmap_rowClusters)
png("test6.png",width=8,height=8,units="in",res=1500)
heatmap_data_meanSubtract %>% pheatmap(cluster_cols = F,
                                       cluster_rows = heatmap_rowClusters)
dev.off()
