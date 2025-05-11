#!/bin/bash

# Define the directory name for the RX project
RX_PROJECT_DIR="RX"
# Define the parent directory where RX project will be cloned
PARENT_INSTALL_DIR="/workspace"

INSTALL_PATH="$PARENT_INSTALL_DIR/$RX_PROJECT_DIR"

echo "🚀 Starting RX Project installation and launch..."

# Clean up previous installation if it exists
if [ -d "$INSTALL_PATH" ]; then
  echo "🧹 Cleaning up existing directory: $INSTALL_PATH"
  rm -rf "$INSTALL_PATH"
fi
# Also clean up the old default location if it exists from previous runs of original setup.sh
if [ -d "$PARENT_INSTALL_DIR/kohya_ss" ]; then
  echo "🧹 Cleaning up legacy directory: $PARENT_INSTALL_DIR/kohya_ss"
  rm -rf "$PARENT_INSTALL_DIR/kohya_ss"
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
echo "⚙️  Making setup.sh and gui.sh executable..."
chmod +x setup.sh
chmod +x gui.sh # Ensured gui.sh is executable
if [ $? -ne 0 ]; then
  echo "❌ ERROR: Failed to make setup.sh or gui.sh executable. Aborting."
  exit 1
fi

# Run setup.sh, explicitly telling it to use the current directory for installation.
echo "🏃 Running setup.sh --dir=\"$PWD\" (this may take several minutes)..."
./setup.sh --dir="$PWD"

if [ $? -ne 0 ]; then
  echo "❌ ERROR: setup.sh reported an error. Please check its output above."
  echo "    The virtual environment might not have been created correctly in $INSTALL_PATH/venv"
  exit 1
fi

echo "✅ RX Project setup script finished successfully."

echo "🔍 Verifying venv directory structure in $INSTALL_PATH/venv..."
ls -la "$INSTALL_PATH/venv"
echo "🔍 Verifying venv/bin directory structure in $INSTALL_PATH/venv/bin..."
ls -la "$INSTALL_PATH/venv/bin"
echo "🔍 Checking for activate script: $INSTALL_PATH/venv/bin/activate"
if [ -f "$INSTALL_PATH/venv/bin/activate" ]; then
    echo "✅ Activation script found: $INSTALL_PATH/venv/bin/activate"
else
    echo "❌ ERROR: Activation script NOT found: $INSTALL_PATH/venv/bin/activate"
fi

echo "   Virtual environment should be in $INSTALL_PATH/venv"
echo "🚀 To launch the application, navigate to $INSTALL_PATH and run ./gui.sh"
echo "   Example:"
echo "   cd $INSTALL_PATH"
echo "   ./gui.sh"
echo "   For public URL (if on RunPod and supported by gui.sh): ./gui.sh --share"
