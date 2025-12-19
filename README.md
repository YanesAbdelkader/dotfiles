# Fedora Sway Dotfiles

Personal dotfiles for a clean, opinionated Fedora Sway Spin setup.

you can get the distro from here : https://www.fedoraproject.org/spins/sway

---

## Prerequisites

Clone the repository:

make sure you have git installed

```bash
sudo dnf install git -y
```

```bash
git -v
```

```bash
git clone https://github.com/YanesAbdelkader/dotfiles.git ~/.dotfiles
```

```bash
cd ~/.dotfiles
```

Update the system (replace DNF config, then update):

```bash
sudo mv -i ~/.dotfiles/dnf.conf /etc/dnf/dnf.conf
```

```bash
sudo dnf update -y
```

---

## Packages

Core packages:

```bash
sudo dnf install -y zsh fzf zoxide alacritty fuzzel grim slurp nautilus dunst fastfetch python3-pip gdm 
```

Pywal:

```bash
pip install pywal
```

Enable RPM Fusion :

https://rpmfusion.org/Configuration

Adding Flatpaks :

https://flatpak.org/setup/Fedora

Change Hostname :
```bash
sudo hostnamectl set-hostname "your-custom-hostname"
```

---

## Visual Studio Code

```bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
```

```bash
sudo tee /etc/yum.repos.d/vscode.repo > /dev/null <<'EOF'
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
```

```bash
sudo dnf check-update
```

```bash
sudo dnf install -y code
```

---

## Nerd Font

JetBrainsMono Nerd Font is required (Waybar, icons, prompts).

```bash
mkdir -p ~/.local/share/fonts
```

```bash
cd ~/.local/share/fonts
```

```bash
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
```

```bash
unzip JetBrainsMono.zip
```

```bash
rm JetBrainsMono.zip
```

```bash
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
mkdir -p ~/.config/alacritty ~/.config/sway ~/.config/waybar ~/.config/fuzzel ~/.config/swaylock ~/Pictures/Screenshots
```

Move dotfiles into place (overwrites existing files):

```bash
mv -f ~/.dotfiles/.zshrc ~/.zshrc
```

```bash
mv -f ~/.dotfiles/alacritty ~/.config/
```

```bash
mv -f ~/.dotfiles/sway ~/.config/
```

```bash
mv -f ~/.dotfiles/waybar ~/.config/
```

```bash
mv -f ~/.dotfiles/fuzzel ~/.config/
```

```bash
mv -f ~/.dotfiles/swaylock ~/.config/
```

```bash
mv -f ~/.dotfiles/rename_files.sh ~/.local/bin/
```

---

## Post‑Installation

### Zsh Plugins

On first Zsh launch, `zinit` installs all defined plugins automatically.

### Wallpapers

You can get wallpapers from here:
https://github.com/YanesAbdelkader/wallpapers.git

---

## Node Version Manager (nvm)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

```bash
. "$HOME/.nvm/nvm.sh"
```

```bash
nvm install 24
```

```bash
node -v
```

```bash
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
```

```bash
php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
```

```bash
php composer-setup.php
```

```bash
php -r "unlink('composer-setup.php');"
```

```bash
sudo mv composer.phar /usr/local/bin/composer
```

```bash
composer global require laravel/installer
```
