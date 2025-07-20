# dotfiles managed with chezmoi

## Prerequisites

1. Run bitwarden installation script:
   ```
   curl -L https://raw.githubusercontent.com/schaermu/dotfiles/refs/heads/main/_install_bitwarden.sh | bash
   ```
2. Unlock vault within current terminal session:
   ```
   export BW_SESSION=$(bw unlock --raw)
   ```

## Setup

To install the dotfiles on a new machine, use this command:

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply schaermu
```

## Tools

- WSL 2 / Debian-based distro
- Windows Terminal (Default Theme: One Half Dark)
- Fira Code Nerd Font Mono (11pt)