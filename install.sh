#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin"
REPO_URL="https://github.com/YOUR_USERNAME/git-autodoc.git"

echo "📦 Installing git-autodoc..."
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Clone or update repository
if [ -d "$HOME/.git-autodoc" ]; then
    echo "Updating existing installation..."
    cd "$HOME/.git-autodoc"
    git pull
else
    echo "Installing git-autodoc..."
    git clone "$REPO_URL" "$HOME/.git-autodoc"
fi

# Link the command
ln -sf "$HOME/.git-autodoc/git-autodoc" "$INSTALL_DIR/git-autodoc"
chmod +x "$INSTALL_DIR/git-autodoc"

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