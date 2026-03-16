#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/av-x/dotfiles.git"
DOTFILES_REPO_RAW="https://raw.githubusercontent.com/av-x/dotfiles/main"
DOTFILES_DIR="$HOME/.dotfiles"

source <(curl -fsSL "$DOTFILES_REPO_RAW/scripts/utils.sh")

install_homebrew() {
  if command -v brew &>/dev/null; then
    info "Homebrew already installed"
    return
  fi
  info "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  info "Homebrew installed"
}

install_git() {
  if command -v git &>/dev/null; then
    info "git already installed"
    return
  fi
  info "Installing git..."
  case "$1" in
    macos) brew install git ;;
    arch) sudo pacman -S --noconfirm git ;;
  esac
  info "git installed"
}

clone_dotfiles() {
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "Dotfiles dir already cloned, pulling latest..."
    git -C "$DOTFILES_DIR" pull
    return
  fi
  info "Cloning dotfiles dir to $DOTFILES_DIR..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  info "Dotfiles dir cloned"
}

main() {
  info "Starting dotfiles installation..."

  local os
  os="$(detect_os)"
  info "Detected OS: $os"

  case "$os" in
    macos) install_homebrew ;;
  esac

  install_git "$os"
  clone_dotfiles

  info "Running install scripts..."
  bash "$DOTFILES_DIR/scripts/ghostty.sh"

  info "Done!"
}

main
