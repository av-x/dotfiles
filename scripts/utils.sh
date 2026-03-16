#!/usr/bin/env bash

info() {
  printf "\033[34m[info]\033[0m %s\n" "$1"
}

warn() {
  printf "\033[33m[warn]\033[0m %s\n" "$1"
}

error() {
  printf "\033[31m[error]\033[0m %s\n" "$1" >&2
}

detect_os() {
  case "$(uname -s)" in
    Darwin)
      echo "macos"
      ;;
    Linux)
      if [[ -f /etc/arch-release ]]; then
        echo "arch"
      else
        error "Unsupported Linux distribution. Only Arch Linux is supported."
        exit 1
      fi
      ;;
    *)
      error "Unsupported operating system: $(uname -s)"
      exit 1
      ;;
  esac
}
