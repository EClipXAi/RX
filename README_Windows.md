# RX Project - Windows Installation Guide

This guide provides detailed instructions for installing the RX Project on a Windows system using the provided `install_windows.bat` script.

## Prerequisites

Before you begin, ensure you have the following installed on your Windows system:

1.  **Python 3.10.x:**
    *   Download and install Python 3.10.x from [python.org](https://www.python.org/downloads/windows/).
    *   **Crucial:** During installation, make sure to check the box that says "Add Python 3.10 to PATH".
    *   You can verify the installation by opening a Command Prompt and typing `python --version`.

2.  **Git:**
    *   Download and install Git for Windows from [git-scm.com](https://git-scm.com/download/win).
    *   Default installation options are usually fine.
    *   You can verify the installation by opening a Command Prompt and typing `git --version`.

3.  **NVIDIA GPU Drivers:**
    *   Ensure you have the latest NVIDIA drivers installed for your GPU. You can download them from the [NVIDIA website](https://www.nvidia.com/Download/index.aspx).
    *   The PyTorch installation (handled by the script) typically includes the necessary CUDA runtime components if the drivers are up-to-date. A separate CUDA Toolkit installation is often not required for running PyTorch.

## Installation Steps

1.  **Download the Installer Script:**
    *   Download the `install_windows.bat` file from the main RX Project GitHub repository.
    *   You can find it here: [https://github.com/EClipXAi/RX/blob/main/install_windows.bat](https://github.com/EClipXAi/RX/blob/main/install_windows.bat) (Click "Raw", then right-click and "Save as...").

2.  **Prepare Your Project Folder:**
    *   Create a new folder where you want to install the RX Project (e.g., `C:\Projects\RX`).
    *   Place the downloaded `install_windows.bat` file into this folder.

3.  **Run the Installer Script:**
    *   Double-click `install_windows.bat` to run it.
    *   Alternatively, open a Command Prompt, navigate to your project folder (`cd C:\Projects\RX`), and run `install_windows.bat`.
    *   The script will perform the following actions:
        *   Create a Python virtual environment named `venv` in the project folder.
        *   Activate the virtual environment.
        *   Install all necessary Python packages from `requirements_windows.txt`, including PyTorch, Triton (if applicable for your GPU), and Xformers. This step might take some time depending on your internet speed.

4.  **Wait for Completion:**
    *   Allow the script to complete all installations. You'll see progress messages in the command prompt window.
    *   If the script encounters errors, they will be displayed in the console. Common issues often relate to Python/Git not being in PATH, or network problems.

## How to Launch the Application

Once the installation is complete:

1.  **Open a Command Prompt:**
    *   Navigate to your RX project folder (e.g., `cd C:\Projects\RX`).

2.  **Activate the Virtual Environment:**
    *   Run the following command:
      ```batch
      .\venv\Scripts\activate.bat
      ```
    *   You should see `(venv)` appear at the beginning of your command prompt line, indicating the virtual environment is active.

3.  **Launch the GUI:**
    *   Run the main application script (assuming it's `gui.sh` and accessible via `bash` if you have WSL or Git Bash installed, or if there's a `gui.bat` for Windows):
      ```bash
      bash gui.sh --listen=0.0.0.0 --share --noverify
      ```
      *   _Developer Note: Adjust this launch command if a different script or parameters are used for Windows._
      *   If you have a Windows-specific launcher like `gui.bat`, the command might be:
        ```batch
        gui.bat --listen=0.0.0.0 --share --noverify
        ```

    *   The application should start, and you'll typically see a URL (like `http://127.0.0.1:7860` or a public Gradio URL if `--share` is used) in the console. Open this URL in your web browser.

## Troubleshooting

*   **`python` or `git` not recognized:** Ensure Python and Git were added to your system's PATH during their installation. You might need to reinstall them and ensure the "Add to PATH" option is checked.
*   **Installation errors for packages:**
    *   Ensure your internet connection is stable.
    *   Some packages might have specific build requirements. Check the error messages for clues.
    *   Consider running Command Prompt as an Administrator if you suspect permission issues, though this is generally not required for pip installs into a virtual environment.
*   **CUDA / PyTorch issues:**
    *   Ensure your NVIDIA drivers are up to date.
    *   The `requirements_windows.txt` file specifies a PyTorch version compatible with CUDA 12.1. If you have a very different CUDA version installed system-wide, it might lead to issues, but PyTorch's self-contained CUDA runtime usually handles this.

---
For general project information, refer to the main [README.md](../../README.md).
