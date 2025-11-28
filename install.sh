#!/bin/bash

set -e

echo "Building note..."
cargo build --release

# Determine install location
if [ -w "/usr/local/bin" ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
fi

echo "Installing to $INSTALL_DIR..."
cp target/release/note "$INSTALL_DIR/note"
chmod +x "$INSTALL_DIR/note"

echo "Installing wrapper scripts..."
cp note-wrapper.sh "$INSTALL_DIR/note-wrapper.sh"
chmod +x "$INSTALL_DIR/note-wrapper.sh"
cp note-search-wrapper.sh "$INSTALL_DIR/note-search-wrapper.sh"
chmod +x "$INSTALL_DIR/note-search-wrapper.sh"

echo "Installing desktop files..."
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"
cp note.desktop "$DESKTOP_DIR/note.desktop"
chmod +x "$DESKTOP_DIR/note.desktop"
cp note-search.desktop "$DESKTOP_DIR/note-search.desktop"
chmod +x "$DESKTOP_DIR/note-search.desktop"

echo "✓ Successfully installed note to $INSTALL_DIR/note"
echo "✓ Successfully installed wrapper scripts to $INSTALL_DIR/"
echo "✓ Successfully installed desktop files to $DESKTOP_DIR/"

# Check if install directory is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "⚠ Warning: $INSTALL_DIR is not in your PATH"
    echo "Add this line to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"$INSTALL_DIR:\$PATH\""
fi

echo ""
echo "Usage:"
echo "  CLI: note 'your note text here'"
echo "  CLI: note list"
echo "  Rofi: Launch 'Quick Note' to add a note"
echo "  Rofi: Launch 'Search Notes' to browse and search notes"
