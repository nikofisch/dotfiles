#!/usr/bin/env bash

set -euo pipefail

force_opaque=false
args=()

for arg in "$@"; do
    case "$arg" in
        --opaque)
            force_opaque=true
            ;;
        *)
            args+=("$arg")
            ;;
    esac
done

if "$force_opaque"; then
    ACTIVE_OPACITY="$(hyprctl getoption decoration:active_opacity -j | jq -r '.float')"
    INACTIVE_OPACITY="$(hyprctl getoption decoration:inactive_opacity -j | jq -r '.float')"

    restore_opacity() {
        hyprctl keyword decoration:active_opacity "$ACTIVE_OPACITY" >/dev/null 2>&1 || true
        hyprctl keyword decoration:inactive_opacity "$INACTIVE_OPACITY" >/dev/null 2>&1 || true
    }

    trap restore_opacity EXIT

    hyprctl keyword decoration:active_opacity 1.0 >/dev/null
    hyprctl keyword decoration:inactive_opacity 1.0 >/dev/null
fi

# Give Hyprland one frame to repaint before hyprshot freezes the scene.
sleep 0.15

hyprshot "${args[@]}"
