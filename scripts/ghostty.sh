#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

install_ghostty() {
  local os
  os="$(detect_os)"

  case "$os" in
    macos)
      if [[ -d "/Applications/Ghostty.app" ]]; then
        info "Ghostty already installed, skipping"
        return
      fi
      info "Installing Ghostty..."
      brew install --cask ghostty
      ;;
    arch)
      if pacman -Q ghostty &>/dev/null; then
        info "Ghostty already installed, skipping"
        return
      fi
      info "Installing Ghostty..."
      sudo pacman -S --noconfirm ghostty
      ;;
  esac

  info "Ghostty installed"
}

install_ghostty
