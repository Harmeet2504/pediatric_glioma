
## Pediatric Glioma Microenvironment Analysis Pipeline

This repository is actively maintained and updated as part of an evolving pipeline for pediatric glioma microenvironment analysis.The aim is to provide a modular, reproducible pipeline for analyzing the tumor microenvironment in pediatric glioma using single-cell RNA sequencing (scRNA-seq) data. It focuses on comparing immune and stromal cell states across selected GSM samples from the GEO dataset GSE231860, with an emphasis on trajectory inference and cell state annotation. The pipeline is designed for low-resource environments and follows best practices in software engineering, including object-oriented design, version control, and ethical data handling. New modules, documentation, and enhancements are added regularly as the project progresses toward full trajectory modeling and cell state annotation.

## Qulaity Control analysis
Single‑cell data are inherently sparse and sensitive to issues such as empty droplets, doublets, stressed cells, and ambient RNA contamination, so early filtering is essential for removal of technical artifacts.

**Key QC Metrics**
- 	nCount_RNA — total UMIs per cell
Captures sequencing depth and total RNA content. Extremely low values often indicate empty droplets; extremely high values may signal doublets.
- 	nFeature_RNA — number of detected genes per cell
Reflects transcriptome complexity. Low values suggest poor‑quality or dying cells; unusually high values may indicate multiplets.
- 	log10GenesPerUMI — gene complexity normalized by UMI count
Measures gene diversity relative to sequencing depth. Low values point to low‑complexity cells or ambient RNA contamination.

QC Steps
- 	Visualize distributions of nCount_RNA, nFeature_RNA, and log10GenesPerUMI.
- 	Remove cells with extremely low gene counts or complexity.
- 	Trim high‑UMI outliers to reduce doublets.
- 	Optionally filter based on mitochondrial or ribosomal gene percentages.
- 	Generate QC plots (violin plots, scatter plots, and joint distributions) to validate thresholds.

🚀 Getting Started
## Run the pipeline
```
git clone https://github.com/Harmeet2504/pediatric_glioma.git <br>
cd pediatric_glioma  <br>
python -m scripts.run_pipeline  <br>


