#!/usr/bin/env zsh
export PATH="$HOME/.local/bin:$PATH"
set -e

WALLDIR="$HOME/Pictures/Wallpapers"
SWAYLOCK_CONF="$HOME/.config/swaylock/config"

# ---- select mode ----
mode=$(printf "Wallpaper\nLockscreen\n" | fuzzel --dmenu --prompt "Mode")
[ -n "$mode" ] || exit 0

# ---- select image (filenames only) ----
choice=$(
  find "$WALLDIR" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
  \) -printf '%f\n' | sort | fuzzel --dmenu --prompt "Image"
)
[ -n "$choice" ] || exit 0

# ---- resolve full path ----
selected=$(find "$WALLDIR" -type f -name "$choice" | head -n 1)
[ -n "$selected" ] || exit 1

# ---- execute ----
case "$mode" in
  Wallpaper)
    wal -i "$selected"
    "$HOME/.config/fuzzel/scripts/fuzzel-color.sh"
    pkill waybar
    swaymsg reload 
    ;;
  Lockscreen)
    sed -i "s|^image=.*|image=$selected|" "$SWAYLOCK_CONF"
    swaylock
    ;;
esac
