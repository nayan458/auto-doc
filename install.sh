#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin"
REPO_URL="https://github.com/nayan458/auto-doc.git"

echo "📦 Installing auto-doc..."
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Clone or update repository
if [ -d "$HOME/.auto-doc" ]; then
    echo "Updating existing installation..."
    cd "$HOME/.auto-doc"
    git pull
else
    echo "Installing auto-doc..."
    git clone "$REPO_URL" "$HOME/.auto-doc"
fi

# Link the command
ln -sf "$HOME/.auto-doc/auto-doc" "$INSTALL_DIR/auto-doc"
chmod +x "$INSTALL_DIR/auto-doc"

# Check if directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage: git autodoc"
echo ""