#!/bin/bash
# Source this file from ~/.bashrc (installer.sh does that for you).

INIT_DIR_CONFIG="$HOME/.saved_init_dir"

# siti = set-initial-to-input directory (saved across terminal sessions)
siti() {
    local target_dir
    if [[ -z "$1" ]]; then
        echo "Usage: siti <directory>"
        return 1
    fi
    target_dir=$(realpath -m -- "$1" 2>/dev/null)

    if [[ -d "$target_dir" ]]; then
        printf '%s\n' "$target_dir" > "$INIT_DIR_CONFIG"
        export INIT_DIR="$target_dir"
        echo "Initial directory set to: ${target_dir}"
    else
        echo "Directory does not exist."
        return 1
    fi
}

# sitc = set-initial-to-current directory
sitc() { siti "$PWD"; }

# sith = set-initial-to-home directory
sith() { siti "$HOME"; }

# On terminal startup: jump to the saved directory, but only when the shell
# started in $HOME (the default). If you opened the terminal somewhere on
# purpose (e.g. "Open Git Bash here", VS Code), that location wins.
if [[ -f "$INIT_DIR_CONFIG" && "$PWD" == "$HOME" ]]; then
    SAVED_DIR=$(<"$INIT_DIR_CONFIG")
    if [[ -d "$SAVED_DIR" ]]; then
        export INIT_DIR="$SAVED_DIR"
        cd "$INIT_DIR"
    fi
    unset SAVED_DIR
fi
