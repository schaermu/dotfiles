#!/usr/bin/env bash
set -o pipefail

install () {
    # exit immediately if bw is already in $PATH
    type bw >/dev/null 2>&1 && return 0

    echo "installing bitwarden cli..."  

    case "$(uname -s)" in
    Darwin)
        curl -L https://vault.bitwarden.com/download/?app=cli\&platform=macos -o /tmp/bw.zip && unzip /tmp/bw.zip -d ~/.local/bin
        ;;
    Linux)
        curl -L https://vault.bitwarden.com/download/?app=cli\&platform=linux -o /tmp/bw.zip && unzip /tmp/bw.zip -d ~/.local/bin
        ;;
    *)
        echo "unsupported OS"
        exit 1
        ;;
    esac
}

# make sure install path is included in $PATH
export PATH=$PATH:~/.local/bin

# install & configure bitwarden cli
install
if ! bw status | grep -q "\"authenticated\""; then
    bw config server "https://vault.hpfr.ch"
    bw login schaermu@protonmail.com --raw
fi

# configure base environment variables
if [ ! -f ~/.bwenv ]; then
    read -p "Enter client secret: " client_secret
    cat > ~/.bwenv<< EOF
export BW_CLIENTID="user.40c5ce89-e0c9-4719-8aa0-06eecf440917"
export BW_CLIENTSECRET="$client_secret"
EOF
fi

# source environment variables
source ~/.bwenv
echo "Bitwarden CLI installed and ready to use.
Unlock vault with 'export BW_SESSION=\$(bw unlock --raw)' before running chezmoi init!"