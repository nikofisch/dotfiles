#!/bin/bash
WAYBAR_DIR="$HOME/.config/waybar"
STYLECSS="$WAYBAR_DIR/style.css"

menu() {
    find "${WAYBAR_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}


main() {
    choice=$(menu | wofi -c ~/.config/wofi/waybar -s ~/.config/wofi/style-waybar.css --show dmenu --prompt "  Select Waybar (Scroll with Arrows)" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    echo $selected_wallpaper
    if [[ "$selected_wallpaper" == "/home/$USER/.config/waybar/experimental.png" ]]; then
        cat $WAYBAR_DIR/style-experimental.css > $STYLECSS
        pkill waybar && waybar
    elif [[ "$selected_wallpaper" == "/home/$USER/.config/waybar/main.png" ]]; then
        cat $WAYBAR_DIR/style-main.css > $STYLECSS
        pkill waybar && waybar
    fi
    
}
main
