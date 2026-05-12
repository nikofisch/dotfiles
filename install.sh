#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

link_dir() {
  local source="$1"
  local target="$2"
  local backup=""

  mkdir -p "$(dirname "$target")"

  if [[ -e "$target" || -L "$target" ]]; then
    backup="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup"
    printf 'Backed up %s to %s\n' "$target" "$backup"
  fi

  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

link_dir "$ROOT_DIR/cava" "$CONFIG_DIR/cava"
link_dir "$ROOT_DIR/hypr" "$CONFIG_DIR/hypr"
link_dir "$ROOT_DIR/rofi" "$CONFIG_DIR/rofi"
link_dir "$ROOT_DIR/waybar" "$CONFIG_DIR/waybar"
link_dir "$ROOT_DIR/yazi" "$CONFIG_DIR/yazi"
link_dir "$ROOT_DIR/neofetch" "$CONFIG_DIR/neofetch"
link_dir "$ROOT_DIR/wallpapers" "$CONFIG_DIR/wallpapers"

printf 'Done.\n'
