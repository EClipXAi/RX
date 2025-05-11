from huggingface_hub import snapshot_download
import os
import argparse

def download_models(target_dir=None):
    """
    Download models from HuggingFace Hub to a specified directory using snapshot_download.
    Enables resumable and parallel downloads via hf_transfer (if available).
    
    Args:
        target_dir (str, optional): Directory to save the models.
                                    Defaults to current working directory.
    """
    # Set your HuggingFace repo ID
    repo_id = "RougeX/FluxTrain"
    
    # Determine download directory
    download_dir = target_dir if target_dir else os.getcwd()
    
    # Create the target directory if it doesn't exist
    os.makedirs(download_dir, exist_ok=True)
    
    try:
        # Use snapshot_download with resumable download enabled
        # hf_transfer will be used if the environment variable is set AND the package is installed
        snapshot_download(
            local_dir=download_dir,
            repo_id=repo_id,
            resume_download=True
        )
        print(f"\n✅ DOWNLOAD COMPLETED to: {download_dir}")
        print("ℹ️ Check the folder for downloaded model files.")
        
    except Exception as e:
        print(f"❌ Error occurred during download: {str(e)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download models from HuggingFace Hub')
    parser.add_argument('--dir', type=str, help='Target directory for downloads', default=None)
    
    args = parser.parse_args()
    download_models(args.dir)
