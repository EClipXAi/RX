#!/bin/bash

# Define the directory name for the RX project
RX_PROJECT_DIR="RX"
# Define the parent directory where RX project will be cloned
# Assumes the script is run from /workspace or a similar base directory on RunPod
PARENT_INSTALL_DIR="/workspace"

INSTALL_PATH="$PARENT_INSTALL_DIR/$RX_PROJECT_DIR"

echo "🚀 Starting RX Project installation and launch..."

# Clean up previous installation if it exists
if [ -d "$INSTALL_PATH" ]; then
  echo "🧹 Cleaning up existing directory: $INSTALL_PATH"
  rm -rf "$INSTALL_PATH"
fi

# Ensure the parent directory exists
if [ ! -d "$PARENT_INSTALL_DIR" ]; then
  echo "🛠️ Parent directory $PARENT_INSTALL_DIR does not exist. Creating it..."
  mkdir -p "$PARENT_INSTALL_DIR"
  if [ $? -ne 0 ]; then
    echo "❌ ERROR: Failed to create parent directory $PARENT_INSTALL_DIR. Aborting."
    exit 1
  fi
fi

cd "$PARENT_INSTALL_DIR" || { echo "❌ ERROR: Failed to change to directory $PARENT_INSTALL_DIR. Aborting."; exit 1; }

echo "Cloning EClipXAi/RX repository into $INSTALL_PATH..."
git clone https://github.com/EClipXAi/RX.git "$RX_PROJECT_DIR"
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Failed to clone repository. Aborting."
  exit 1
fi

cd "$RX_PROJECT_DIR" || { echo "❌ ERROR: Failed to change to directory $INSTALL_PATH. Aborting."; exit 1; }

echo "🔍 Current directory: $(pwd)"
echo "⚙️  Making setup.sh executable..."
chmod +x setup.sh
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Failed to make setup.sh executable. Aborting."
  exit 1
fi

# Run setup.sh, explicitly telling it to use the current directory for installation.
# $PWD will resolve to the absolute path of the current directory (e.g., /workspace/RX).
echo "🏃 Running setup.sh --dir=\"$PWD\" (this may take several minutes)..."
./setup.sh --dir="$PWD"

if [ $? -ne 0 ]; then
  echo "❌ ERROR: setup.sh reported an error. Please check its output above."
  echo "    The virtual environment might not have been created correctly in $INSTALL_PATH/venv"
  exit 1
fi

echo "✅ RX Project setup script finished successfully."
echo "   Virtual environment should be in $INSTALL_PATH/venv"
echo "🚀 To launch the application, navigate to $INSTALL_PATH and run ./gui.sh"
echo "   Example:"
echo "   cd $INSTALL_PATH"
echo "   ./gui.sh"
echo "   For public URL (if on RunPod and supported by gui.sh): ./gui.sh --share"
