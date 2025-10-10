
## Pediatric Glioma Microenvironment Analysis Pipeline

This project provides a modular, reproducible pipeline for analyzing the tumor microenvironment in pediatric glioma using single-cell RNA sequencing (scRNA-seq) data. It focuses on comparing immune and stromal cell states across selected GSM samples from the GEO dataset GSE231860, with an emphasis on trajectory inference and cell state annotation.
The pipeline is designed for low-resource environments and follows best practices in software engineering, including object-oriented design, version control, and ethical data handling.
This repository is actively maintained and updated as part of an evolving pipeline for pediatric glioma microenvironment analysis. New modules, documentation, and enhancements are added regularly as the project progresses toward full trajectory modeling and cell state annotation.


📁 Folder Structure
pre><code>pediatric_glioma/├── data/│   ├── raw/           # Raw GEO files (.tar, .mtx, .tsv)│   └── processed/     # Cleaned and annotated data├── scripts/│   ├── config.py      # Centralized config for GSMs and paths│   ├── geo_downloader.py│   ├── sample_extractor.py│   └── run_pipeline.py├── notebooks/         # Exploratory analysis and visualization├── results/           # Figures, tables, and summary outputs├── logs/              # Optional logging output└── README.md</code></pre>


🚀 Getting Started
# Clone the repo
git clone https://github.com/Harmeet2504/pediatric_glioma.git
cd pediatric_glioma

# Run the pipeline
python -m scripts.run_pipeline


