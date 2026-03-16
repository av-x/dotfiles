# dotfiles

Bootstrap a dev environment.

## Supported Platforms

- macOS (via [Homebrew](https://brew.sh))
- Arch Linux (via pacman)

## Usage

MacOS:
```bash
curl -fsSL https://raw.githubusercontent.com/av-x/dotfiles/main/init.sh | bash
```

Linux:
```bash
wget -qO-  https://raw.githubusercontent.com/av-x/dotfiles/main/init.sh | bash
```

This will:

1. Install Homebrew (macOS) or verify pacman (Arch)
2. Install git if needed
3. Clone this repo to `~/.dotfiles`
4. Run all install scripts

## What Gets Installed

| Tool | macOS | Arch |
|------|-------|------|
| [Ghostty](https://ghostty.org) | `brew install --cask ghostty` | `pacman -S ghostty` |

## Project Structure

```
init.sh              # Entry point (curl this to bootstrap)
scripts/
  utils.sh           # Shared helpers (OS detection, logging)
  ghostty.sh         # Installs Ghostty terminal
```

## Adding a New Tool

1. Create `scripts/<tool>.sh`
2. Source utils at the top: `source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/utils.sh"`
3. Check if already installed before installing
4. Add a `bash "$DOTFILES_DIR/scripts/<tool>.sh"` line to `init.sh`
