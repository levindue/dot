#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dot"
CONFIG_DIR="$HOME/.config"
DOTFILES=(emacs foot sway zathura)

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        echo "Removing existing symlink: $dest"
        rm "$dest"
    elif [ -d "$dest" ] || [ -f "$dest" ]; then
        echo "Found existing: $dest"
        read -rp "Options for '$dest': [B]ackup (default), [D]elete, [C]ancel: " choice
        case "${choice,,}" in
            d)
                echo "Deleting $dest"
                rm -rf "$dest"
                ;;
            c)
                exit 1
                ;;
            *)
                backup="$dest.backup.$(date +%s)"
                echo "Backing up to $backup"
                mv "$dest" "$backup"
                ;;
        esac
    fi

    echo "Linking $src -> $dest"
    ln -s "$src" "$dest"
}

for item in "${DOTFILES[@]}"; do
    src="$DOTFILES_DIR/$item"
    dest="$CONFIG_DIR/$item"

    if [ ! -e "$src" ]; then
        echo "Warning: $src does not exist. Skipping..."
        continue
    fi

    backup_and_link "$src" "$dest"
done
