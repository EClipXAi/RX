#!/usr/bin/env bash

# RX Project One-Click Installer & Launcher for Linux/RunPod

# Exit on any error
set -e

# --- Configuration ---
REPO_URL="https://github.com/EClipXAi/RX.git" # Ensure this is correct
REPO_DIR="RX"                                 # Directory name for the cloned repository
LAUNCH_COMMAND="bash gui.sh --listen=0.0.0.0 --share --noverify" # Command to launch your application
# --- End Configuration ---

echo "🚀 Starting RX Project installation and launch..."

# 1. Check for Git
if ! command -v git &> /dev/null; then
    echo "❌ ERROR: Git is not installed. Please install Git first."
    exit 1
fi
echo "✅ Git found."

# 2. Clone the repository
if [ -d "$REPO_DIR" ]; then
    echo "⚠️  Directory '$REPO_DIR' already exists. Assuming it's up-to-date or you'll manage updates manually."
    echo "   Skipping clone."
else
    echo "🔄 Cloning RX repository from $REPO_URL into './$REPO_DIR/'..."
    git clone "$REPO_URL" "$REPO_DIR"
    echo "✅ Repository cloned successfully."
fi

# 3. Navigate into the repository directory
cd "$REPO_DIR"
echo "📁 Changed directory to: $(pwd)"

# 4. Make the main setup script executable
if [ -f "setup.sh" ]; then
    echo "🔧 Making setup.sh executable..."
    chmod +x setup.sh
else
    echo "❌ ERROR: setup.sh not found in the repository directory '$(pwd)'!"
    exit 1
fi

# 5. Run the main setup script
echo "⚙️  Running setup.sh to install dependencies and configure the environment..."
./setup.sh

if [ $? -ne 0 ]; then
    echo "❌ ERROR: setup.sh reported an error. Please check its output above."
    exit 1
fi
echo "✅ setup.sh completed successfully."

# 6. Activate virtual environment and launch the application
VENV_PATH="venv/bin/activate"
if [ -f "$VENV_PATH" ]; then
    echo "🚀 Activating virtual environment and launching RX..."
    
    echo "   To run manually later: "
    echo "   cd $(pwd)"
    echo "   source $VENV_PATH"
    echo "   $LAUNCH_COMMAND"
    echo ""
    echo "   Launching now..."

    source "$VENV_PATH" && eval "$LAUNCH_COMMAND"
    
echo "👋 RX application has been launched. If it's a server, it's now running."
    echo "   Press Ctrl+C in this terminal if you need to stop it (if it's running in the foreground)."
else
    echo "❌ ERROR: Virtual environment activation script '$VENV_PATH' not found after setup."
    echo "   Cannot launch the application automatically."
    exit 1
fi

exit 0
