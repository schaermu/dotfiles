#!/usr/bin/env bash
if bw status | grep -q "\"locked\""; then
    echo "Bitwarden locked, unlock using 'export BW_SESSION=\$(bw unlock --raw)' before running 'chezmoi apply'!"
    return 1 2>/dev/null
    exit 1
fi