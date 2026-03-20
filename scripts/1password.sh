#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPTS_DIR/utils.sh"

install_1password() {
  local os
  os="$(detect_os)"

  case "$os" in
    macos)
      if [[ -d "/Applications/1Password.app" ]]; then
        info "1Password already installed, skipping"
        return
      fi
      info "Installing 1Password..."
      brew install --cask 1password
      ;;
    arch)
      if pacman -Q 1password &>/dev/null; then
        info "1Password already installed, skipping"
        return
      fi
      info "Installing 1Password..."
      yay -S --noconfirm 1password
      ;;
  esac

  info "1Password installed"
}

install_1password
