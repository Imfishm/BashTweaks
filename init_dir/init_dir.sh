#!/bin/bash
# Source this file from ~/.bashrc (installer.sh does that for you).

INIT_DIR_CONFIG="$HOME/.saved_init_dir"

# sit = set-initial-to directory (saved across terminal sessions)
sit() {
    local target_dir
    if [[ -z "$1" ]]; then
        echo "Usage: sit <directory>"
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
sitc() { sit "$PWD"; }

# sith = set-initial-to-home directory
sith() { sit "$HOME"; }

uninstall_init_dir() { sed -i "/initial directory tools/d;/bash_init_dir/d" ~/.bashrc && rm -f ~/.bash_init_dir ~/.saved_init_dir && unset -f sit sitc sith uninstall_init_dir && echo "init_dir uninstalled."; }

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
