#Rename files if necessary before calling this function.
#Filenames must match Seurat's expectations:
#       - barcodes.tsv.gz
#       - features.tsv.gz
#       - matrix.mtx.gz
#Notes:
#Check if the data downloaded is filtered or raw. Check the name of the folder or file name
setwd("//wsl.localhost/Ubuntu/home/linux/projects/pediatric_glioma")
getwd()
list.files()

library(Seurat)
library(tidyverse)

#Read the files from directories
gsm60 = Read10X(data.dir = '//wsl.localhost/Ubuntu/home/linux/projects/pediatric_glioma/data/raw/GSM7305260')
gsm78 = Read10X(data.dir = '//wsl.localhost/Ubuntu/home/linux/projects/pediatric_glioma/data/raw/GSM7305278')

#Read10X returns a class dgCMatrix, a double-precision, general, compressed sparse column matrix where only non-zero values are stored. Every . is a 0
#Visualize the data
gsm78[1:10,1:18]

#Create seurat object for both samples (GSM7305260, GSM7305278) and save to avoid overwhelming RAM when merging
seurat_ob60 = CreateSeuratObject(counts = gsm60, project = 'gsm60', min.cells = 3,
                                 min.features = 200)
#SaveSeuratRds(seurat_ob60, "ob60_seurat.rds")
seurat_ob78 = CreateSeuratObject(counts = gsm78, project = 'gsm78', min.cells = 3,
                                 min.features = 200)
#SaveSeuratRds(seurat_ob78, "ob78_seurat.rds")
#Create a merged object for the 2 samples
seurat_ob60 = LoadSeuratRds("ob60_seurat.rds")
merged_ob = merge(x = seurat_ob60,y = seurat_ob78,add.cell.id = c("gsm60", "gsm78"))
SaveSeuratRds(merged_ob, "Merged_ob.rds")
#View
seurat_ob60
seurat_ob78

#Check primary slots using glimpse or use @
glimpse(merged_ob)

#Check layers(counts = raw count, data = normalized data, scaled.data = z-scored/variance-stabilized data)
Layers(merged_ob)

#Assess the specific count layer
merged_ob[["RNA"]]$counts.gsm78 |> head()
#or
seurat_ob60@assays$RNA$counts 
#check version of seurat
seurat_ob60@version
#check commands and params used to generate results. This info is useful to document our results
seurat_ob60@commands  #Currently no work has been done on the object so an empty list is seen
head(pbmc_small@commands, 1)
#Examine metadata
head(merged_ob@meta.data)
tail(merged_ob@meta.data)
#orig.ident - defaults to the project labels
#nCount_RNA - number of UMIs per cell
#nFeature_RNA - number of genes / features per cell
#Accessing a single column
head(seurat_ob60[["orig.ident"]])
#Access multiple columns and rows
seurat_ob60[[c("orig.ident", "nCount_RNA")]][1:3,]
#Access column names
head(colnames(seurat_ob60))
#Return feature or gene names
head(Features(seurat_ob60))
head(row.names(seurat_ob60))
#to return row by column information
dim(seurat_ob60)
## Visualize the number of cell counts per sample (useful when different conditions are merged)
library(ggplot2)
merged_ob@meta.data %>% 
  ggplot(aes(x=orig.ident, fill=orig.ident)) + 
  geom_bar(color="black") +
  stat_count(geom = "text", colour = "black", size = 3.5, 
             aes(label = ..count..),
             position=position_stack(vjust=0.5))+
  theme_classic() +
  theme(plot.title = element_text(hjust=0.5, face="bold")) +
  ggtitle("Number of Cells per Sample")

#Doubts??
#Do we have to downsample ob60 for comparison, it has 18614 features from 2639 samples? vs 14033 across 223 samples.


####################QC of the merged object#################################
#1.Add percent mitochondrial
# Detect mitochondrial gene prefix (MT for human and mt for non-human)
mt_prefix <- if (any(grepl("^MT-", rownames(merged_ob)))) {
  "^MT-"
} else if (any(grepl("^mt-", rownames(merged_ob)))) {
  "^mt-"
} else {
  stop("No mitochondrial gene prefix found.")
}

#Calculate percent.mt using the detected prefix and visualize
merged_ob[['percent.mt']] = PercentageFeatureSet(merged_ob, pattern = mt_prefix)

VlnPlot(merged_ob, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), group.by = "orig.ident")

#merged <- subset(merged, subset = nFeature_RNA > 200 & percent.mt < 10)

