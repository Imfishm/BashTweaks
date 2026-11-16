#!/bin/bash

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/init_dir.sh"
SCRIPT_FILE="$HOME/.bash_init_dir"
BASHRC="$HOME/.bashrc"

cp -- "$SRC" "$SCRIPT_FILE" || exit 1

# Link ~/.bash_init_dir inside ~/.bashrc (only if not already linked)
SOURCE_LINE="[ -f \"$SCRIPT_FILE\" ] && . \"$SCRIPT_FILE\""

touch "$BASHRC"
if ! grep -Fxq "$SOURCE_LINE" "$BASHRC"; then
    printf '\n# Load initial directory tools\n%s\n' "$SOURCE_LINE" >> "$BASHRC"
    echo "Installed successfully! Open a new terminal (or run 'source ~/.bashrc')."
else
    echo "Updated existing installation! Open a new terminal (or run 'source ~/.bashrc')."
fi
