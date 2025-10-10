# scripts/geo_downloader.py

import os
import subprocess
from scripts.config import GEO_URL, RAW_DIR, GEO_ACCESSION

class GeoDownloader:
    def __init__(self):
        self.tar_path = os.path.join(RAW_DIR, f"{GEO_ACCESSION}_RAW.tar")

    def file_exists(self):
        return os.path.exists(self.tar_path)

    def download(self):
        if self.file_exists():
            print(f"File already exists: {self.tar_path}")
            return True

        print(f"Downloading with wget: {GEO_URL}")
        try:
            subprocess.run([
                "wget", "--content-disposition", GEO_URL,
                "-P", RAW_DIR
            ], check=True)
            print(f"Download complete")
            return True
        except subprocess.CalledProcessError:
            print("Download failed.")
            return False
        
if __name__ == "__main__":
    #Create instance of the class and call the download() method
    downloader = GeoDownloader()
    downloader.download() 