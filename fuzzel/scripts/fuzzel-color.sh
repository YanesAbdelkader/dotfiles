#!/usr/bin/env zsh

colors_file="$HOME/.cache/wal/colors.json"
fuzzel_config="$HOME/.config/fuzzel/fuzzel.ini"

if [[ ! -f "$colors_file" ]]; then
    echo "Pywal colors.json not found."
    exit 1
fi

bg=$(jq -r '.colors.color0' "$colors_file")
fg=$(jq -r '.special.foreground' "$colors_file")
sel_bg=$(jq -r '.colors.color2' "$colors_file")
sel_fg=$(jq -r '.special.background' "$colors_file")
border=$(jq -r '.colors.color1' "$colors_file")

if grep -q "^\[colors\]" "$fuzzel_config"; then
    sed -i "s|^background=.*|background=${bg}cc|" "$fuzzel_config"
    sed -i "s|^text=.*|text=${fg}ff|" "$fuzzel_config"
    sed -i "s|^match=.*|match=${sel_fg}ff|" "$fuzzel_config"
    sed -i "s|^selection=.*|selection=${sel_bg}ff|" "$fuzzel_config"
    sed -i "s|^selection-text=.*|selection-text=${sel_fg}ff|" "$fuzzel_config"
    sed -i "s|^border=.*|border=${border}ff|" "$fuzzel_config"
else
    cat >> "$fuzzel_config" <<EOF

[colors]
background=${bg}cc
text=${fg}ff
match=${sel_fg}ff
selection=${sel_bg}ff
selection-text=${sel_fg}ff
border=${border}ff
EOF
fi
