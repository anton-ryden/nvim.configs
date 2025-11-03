#!/bin/sh
SCRIPT_DIR="$(dirname "$0")"
SOURCE_DIR="$SCRIPT_DIR"
TARGET_DIR="$HOME/.config/nvim"

echo "Creating symlink from $SOURCE_DIR to $TARGET_DIR on Unix..."
ln -sfn "$SOURCE_DIR" "$TARGET_DIR"
if [ $? -eq 0 ]; then
    echo "Symlink created successfully."
else
    echo "Failed to create symlink."
    exit 1
fi
