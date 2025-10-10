# scripts/run_pipeline.py

from scripts.geo_downloader import GeoDownloader
from scripts.sample_extractor import SampleExtractor

if __name__ == "__main__":
    downloader = GeoDownloader()
    if downloader.download():
        extractor = SampleExtractor()
        extractor.extract_all()