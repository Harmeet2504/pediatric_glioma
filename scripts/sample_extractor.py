#scripts/sample_extractor.py

import os
import subprocess
from scripts.config import GSM_IDS, RAW_DIR, GEO_ACCESSION

print("[DEBUG] sample_extractor.py loaded")
class SampleExtractor:
    def __init__(self):
        self.tar_path = os.path.abspath(os.path.join(RAW_DIR, f"{GEO_ACCESSION}_RAW.tar"))

    def tar_exists(self):
        return os.path.exists(self.tar_path)
    
    def gsm_extractor(self, gsm_id):
        print(f"Extracting files for {gsm_id}...")
        try:
            # Provide the shell command to run and set the working directory for the command, if the command fails raise an error
            subprocess.run(['tar', '--wildcards', '-xvf', self.tar_path, f'*{gsm_id}*'], cwd = RAW_DIR, check=True)
            print(f'Extracted: {gsm_id}')
            return True
        except subprocess.CalledProcessError:
            print(f"Extraction failed for {gsm_id}")
            return False

    def extract_all(self):
        if not self.tar_exists():
            print(f"GEO file not found. Please run downloader first")
            return False
        
        success = True
        for gsm in GSM_IDS:
            result = self.gsm_extractor(gsm)
            success = success and result
        return success

