# Fedora Sway Dotfiles

Personal dotfiles for a clean, opinionated Fedora + Sway setup.

---

## Prerequisites

Clone the repository:

```bash
git clone https://github.com/YanesAbdelkader/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Update the system (replace DNF config, then update):

```bash
sudo mv -i ~/.dotfiles/dnf.conf /etc/dnf/dnf.conf
sudo dnf update -y
```

---

## Packages

Core packages:

```bash
sudo dnf install -y zsh alacritty fuzzel grim slurp python3-pip
```

Pywal:

```bash
pip install --user pywal
```

---

## Visual Studio Code

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

sudo dnf check-update
sudo dnf install -y code
```

---

## Nerd Font

JetBrainsMono Nerd Font is required (Waybar, icons, prompts).

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

---

## Zsh

Set Zsh as default shell:

```bash
chsh -s "$(which zsh)"
```

---

## Installation

Create required directories:

```bash
mkdir -p \
  ~/.config/alacritty \
  ~/.config/sway \
  ~/.config/waybar \
  ~/.config/fuzzel \
  ~/.config/swaylock
```

Move dotfiles into place (overwrites existing files):

```bash
mv -f ~/.dotfiles/.zshrc ~/.zshrc
mv -f ~/.dotfiles/alacritty ~/.config/
mv -f ~/.dotfiles/sway ~/.config/
mv -f ~/.dotfiles/waybar ~/.config/
mv -f ~/.dotfiles/fuzzel ~/.config/
mv -f ~/.dotfiles/swaylock ~/.config/
```

---

## Post‑Installation

### Zsh Plugins

On first Zsh launch, `zinit` installs all defined plugins automatically.

### Pywal

Generate colors and apply wallpaper:

```bash
wal -i /path/to/wallpaper.jpg
```

Wallpapers:
https://github.com/YanesAbdelkader/wallpapers.git

---

## Node Version Manager (nvm)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

. "$HOME/.nvm/nvm.sh"

nvm install 24
node -v
npm -v
```

---

## PHP & Composer (Laravel)

Install PHP:

```bash
sudo dnf install -y php
```

Install Composer:

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer
```