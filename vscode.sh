#!/bin/bash

# VSCode User settings directory for Homebrew macOS install
VSCODE_SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
EXTENSIONS_DIR="$HOME/.vscode/extensions"
EXPORT_DIR="vscode-backup"

export_vscode() {
  echo "Exporting VSCode extensions and settings..."

  # Create export directory
  mkdir -p "$EXPORT_DIR/extensions"
  mkdir -p "$EXPORT_DIR/settings"

  # Copy extensions directory
  echo "Copying extensions..."
  cp -r "$EXTENSIONS_DIR/"* "$EXPORT_DIR/extensions/"

  # Copy key settings files and snippets folder
  echo "Copying settings files..."
  cp "$VSCODE_SETTINGS_DIR/settings.json" "$EXPORT_DIR/settings/" 2>/dev/null
  cp -r "$VSCODE_SETTINGS_DIR/snippets" "$EXPORT_DIR/settings/" 2>/dev/null

  echo "Export completed to $EXPORT_DIR"
}

import_vscode() {
  echo "Importing VSCode extensions and settings..."

  # Copy extensions back
  echo "Copying extensions..."
  cp -r "$EXPORT_DIR/extensions/"* "$EXTENSIONS_DIR/"

  # Copy settings files
  echo "Copying settings files..."
  cp "$EXPORT_DIR/settings/settings.json" "$VSCODE_SETTINGS_DIR/" 2>/dev/null
  cp -r "$EXPORT_DIR/settings/snippets" "$VSCODE_SETTINGS_DIR/" 2>/dev/null

  echo "Import completed."
}

export_vscode
import_vscode
