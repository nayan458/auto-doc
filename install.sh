#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/bin"
REPO_URL="https://github.com/nayan458/auto-doc.git"
COMMAND_NAME="auto-doc"

echo "📦 Installing $COMMAND_NAME..."
echo ""

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Clone or update repository
if [ -d "$HOME/.$COMMAND_NAME" ]; then
    echo "Updating existing installation..."
    cd "$HOME/.$COMMAND_NAME"
    git pull
else
    echo "Installing $COMMAND_NAME..."
    git clone "$REPO_URL" "$HOME/.$COMMAND_NAME"
fi

# Remove old symlink if it exists (even if dangling)
if [ -L "$INSTALL_DIR/$COMMAND_NAME" ] || [ -e "$INSTALL_DIR/$COMMAND_NAME" ]; then
    rm -f "$INSTALL_DIR/$COMMAND_NAME"
fi

# Make the script executable
chmod +x "$HOME/.$COMMAND_NAME/$COMMAND_NAME"

# Create new symlink
ln -sf "$HOME/.$COMMAND_NAME/$COMMAND_NAME" "$INSTALL_DIR/$COMMAND_NAME"

echo ""
echo "Verifying installation..."
if [ -x "$INSTALL_DIR/$COMMAND_NAME" ]; then
    echo "✅ Command is executable"
else
    echo "⚠️  Making command executable..."
    chmod +x "$INSTALL_DIR/$COMMAND_NAME"
fi

# Check if directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠️  $INSTALL_DIR is not in your PATH"
    echo ""
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
    echo "Then run: source ~/.bashrc  (or source ~/.zshrc)"
else
    echo "✅ $INSTALL_DIR is in your PATH"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "Usage: git $COMMAND_NAME"
echo "   or: $COMMAND_NAME"
echo ""
echo "Test it: cd /path/to/your/repo && git $COMMAND_NAME"
echo ""