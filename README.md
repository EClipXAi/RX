# RX Project by EClipXAi

Welcome to the RX Project! This repository provides tools and scripts for training Stable Diffusion models, a custom GUI for AI image generation, and more.

This project is based on the foundational work of Kohya's sd-scripts, with a focus on streamlined installation and usability.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
  - [Windows](#windows)
  - [Linux / RunPod (One-Click Installer)](#linux--runpod-one-click-installer)
  - [Linux / RunPod (Manual Setup)](#linux--runpod-manual-setup)
- [How to Run](#how-to-run)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)

## Features

*   Simplified installation for Windows, Linux, and RunPod.
*   Separate, optimized requirement files for each platform.
*   Custom GUI for AI image generation.

## Installation

Please choose the installation method appropriate for your operating system.

### Windows

1.  **Prerequisites:**
    *   Python 3.10.x installed and added to PATH.
    *   Git installed.
    *   NVIDIA GPU with CUDA drivers installed (CUDA Toolkit installation is generally handled by PyTorch if drivers are present).
2.  **Download the Installer:**
    Download the `install_windows.bat` script from this repository.
3.  **Run the Installer:**
    Place `install_windows.bat` in your desired project folder and run it. It will:
    *   Create a Python virtual environment (`venv`).
    *   Install all necessary dependencies from `requirements_windows.txt`, including PyTorch, Triton, and Xformers.
4.  For detailed steps, see `README_Windows.md`.

### Linux / RunPod (One-Click Installer)

This is the recommended method for a quick setup on Linux or a fresh RunPod instance.

1.  **Download the One-Click Installer:**
    Open your terminal and download the script:
    ```bash
    curl -LO https://raw.githubusercontent.com/EClipXAi/RX/main/install_rx_linux_oneclick.sh
    # Or using wget:
    # wget https://raw.githubusercontent.com/EClipXAi/RX/main/install_rx_linux_oneclick.sh
    ```
    *(Ensure the URL points to the raw file on your 'main' branch after you commit and push)*
2.  **Make it Executable:**
    ```bash
    chmod +x install_rx_linux_oneclick.sh
    ```
3.  **Run the Installer:**
    ```bash
    ./install_rx_linux_oneclick.sh
    ```
    This script will:
    *   Clone the RX repository.
    *   Run the `setup.sh` script to create a virtual environment and install dependencies from `requirements_linux.txt` or `requirements_runpod.txt`.
    *   Automatically launch the application (e.g., `gui.sh`) upon successful setup.

### Linux / RunPod (Manual Setup)

If you prefer a manual setup or want to install into an existing cloned repository:

1.  **Prerequisites:**
    *   Python 3.10.x installed.
    *   Git installed.
    *   `python3.10-venv` package (or equivalent for your distro) for creating virtual environments.
    *   NVIDIA GPU with CUDA drivers.
2.  **Clone the Repository (if you haven't already):**
    ```bash
    git clone https://github.com/EClipXAi/RX.git
    cd RX
    ```
3.  **Run Setup Script:**
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```
    This will guide you through setting up the Python environment and installing dependencies.
4.  For more details, particularly for RunPod specific considerations, see `README_RunPod.md`.

## How to Run

1.  **Activate the Virtual Environment:**
    *   **Windows:** Open a command prompt in the project directory and run: `.\venv\Scripts\activate.bat`
    *   **Linux/RunPod:** Open a terminal in the project directory and run: `source venv/bin/activate`
2.  **Launch the Application:**
    Once the environment is activated, run the main application script:
    ```bash
    bash gui.sh --listen=0.0.0.0 --share --noverify 
    ```
    *(Adjust this command if your launch script or parameters are different.)*

## Contributing

If you are open to contributions, please add information here on how to report bugs, suggest features, or submit pull requests.

## Acknowledgements

*   This project builds upon the excellent work of [Kohya-ss/sd-scripts](https://github.com/kohya-ss/sd-scripts).
*   Gratitude to all contributors to the original project and the broader open-source community.

---
*This README provides a general guide. For more detailed platform-specific instructions, please refer to the other README files in this repository.*
