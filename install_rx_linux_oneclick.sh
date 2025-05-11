#!/bin/bash
set -e # Exit on any error

INSTALL_PARENT_DIR="/workspace"
REPO_DIR_NAME="RX"
INSTALL_PATH="$INSTALL_PARENT_DIR/$REPO_DIR_NAME"

echo "🚀 Starting RX Project simplified installation (v2)..."

# 1. System maintenance and package installation
echo "⚙️ Updating apt and installing system packages (python3.10-tk, psmisc, curl)..."
sudo apt-get update -y
sudo apt-get install -y python3.10-tk psmisc curl git # Ensure git and curl are present

# 2. Clean up previous installation & Clone repository
echo "🧹 Cleaning up existing directory: $INSTALL_PATH (if any)..."
rm -rf "$INSTALL_PATH"
if [ -d "$INSTALL_PARENT_DIR/kohya_ss" ]; then
  echo "🧹 Cleaning up legacy directory: $INSTALL_PARENT_DIR/kohya_ss"
  rm -rf "$INSTALL_PARENT_DIR/kohya_ss"
fi

cd "$INSTALL_PARENT_DIR" || { echo "❌ ERROR: Failed to change to $INSTALL_PARENT_DIR. Aborting."; exit 1; }
echo "Cloning EClipXAi/RX repository into $REPO_DIR_NAME..."
git clone https://github.com/EClipXAi/RX.git "$REPO_DIR_NAME"
cd "$INSTALL_PATH" || { echo "❌ ERROR: Failed to change to $INSTALL_PATH. Aborting."; exit 1; }
echo "🔍 Current directory: $(pwd)"

# 3. Create and activate Python virtual environment
echo "🐍 Creating Python virtual environment in $INSTALL_PATH/venv..."
python3 -m venv venv
echo " sourcing venv/bin/activate ..."
source venv/bin/activate
echo "✅ Virtual environment activated for this script session."

# 4. Install/Upgrade pip, setuptools, wheel
echo "📦 Installing/upgrading pip, setuptools, wheel in venv..."
pip install --upgrade pip setuptools wheel

# 5. Install Python dependencies
REQUIREMENTS_FILE="requirements_linux.txt" # Default
if [[ -n "${RUNPOD_POD_ID}" || -n "${RUNPOD_API_KEY}" ]]; then
  echo "💡 RunPod environment detected. Attempting to use requirements_runpod.txt"
  if [ -f "requirements_runpod.txt" ]; then
    REQUIREMENTS_FILE="requirements_runpod.txt"
  else
    echo "⚠️ WARNING: requirements_runpod.txt not found. Falling back to requirements_linux.txt"
  fi
else
  echo "💡 Non-RunPod Linux environment assumed. Using requirements_linux.txt"
fi
echo "📦 Installing Python dependencies from $REQUIREMENTS_FILE..."
pip install -r "$REQUIREMENTS_FILE"

# 6. Make core scripts executable
echo "🔧 Making setup.sh and gui.sh executable..."
chmod +x setup.sh
chmod +x gui.sh

# 7. Run setup.sh with --no-git-update (-n)
# This should use the venv we created. It may configure accelerate and check packages.
echo "🏃 Running ./setup.sh -n (skipping git updates, may configure accelerate)..."
./setup.sh -n

echo "✅ RX Project setup steps completed via one-click script."

# 8. Diagnostic: Verify venv (after setup.sh might have interacted with it)
echo "🔍 Verifying venv state post setup.sh execution..."
if [ -d "$INSTALL_PATH/venv/bin" ]; then
    echo "✅ venv/bin directory exists."
    ls -la "$INSTALL_PATH/venv/bin"
    if [ -f "$INSTALL_PATH/venv/bin/activate" ]; then
        echo "✅ Activation script found: $INSTALL_PATH/venv/bin/activate"
    else
        echo "❌ ERROR: Activation script NOT found: $INSTALL_PATH/venv/bin/activate"
    fi
else
    echo "❌ ERROR: venv/bin directory NOT found!"
fi
echo "🐍 Python version in venv (expected): $(venv/bin/python --version)"
echo "🐍 pip version in venv (expected): $(venv/bin/pip --version)"
echo "🐍 which python (after source): $(which python)"

echo "🚀 Launching GUI with --share..."
echo "   If this step hangs or fails, try running it manually after script finishes:"
echo "   cd $INSTALL_PATH"
echo "   source venv/bin/activate"
echo "   ./gui.sh --share"

./gui.sh --share

echo "🏁 install_rx_linux_oneclick.sh finished."
