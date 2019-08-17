#!/bin/sh

# Export the path to this directory for later use in the script
export LINKDOT=$PWD

# Install fonts and programs.
sudo pacman -S ttf-joypixels ttf-croscore noto-fonts-cjk noto-fonts \
    ttf-fantasque-sans-mono ttf-linux-libertine rofi mpv fzf maim \
    alacritty alacritty-terminfo compton mpd neofetch dash neovim \
    ncmpcpp feh xclip sxhkd bspwm i3-gaps dunst zathura-pdf-mupdf \
    diff-so-fancy zsh-autosuggestions zsh-syntax-highlighting exa \
    xorg-server xorg-xinit xorg-xprop pulseaudio-alsa libnotify fd \
    nnn bat ripgrep httpie sxiv firefox zathura-cb transmission-gtk

# Link dash to /bin/sh for performance boost.
# Then link several font config files for better font display.
sudo ln -sfT dash /usr/bin/sh
sudo ln -sf /etc/fonts/conf.avail/75-joypixels.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -sf /etc/fonts/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/

# Disable mouse acceleration, keep dash linked to /bin/sh, and font stuff.
sudo install -Dm 644 other/freetype2.sh /etc/profile.d/
sudo install -Dm 644 other/local.conf /etc/fonts/
sudo install -Dm 644 other/dashbinsh.hook /usr/share/libalpm/hooks/
sudo install -Dm 644 other/50-mouse-acceleration.conf /etc/X11/xorg.conf.d/

# Make some folders needed for proper functionality.
mkdir -p $LINKDOT/config/mpd/playlists ~/.config ~/.aurpkgs

# Clone the aur packages being installed. Polybar and Oh-My-Zsh
git clone https://aur.archlinux.org/oh-my-zsh-git.git ~/.aurpkgs/oh-my-zsh-git
git clone https://aur.archlinux.org/polybar.git ~/.aurpkgs/polybar

# Install them
cd ~/.aurpkgs/oh-my-zsh-git
makepkg -si
cd ~/.aurpkgs/polybar
makepkg -si

# Link all dotfiles into their appropriate locations
cd ~
ln -sf $LINKDOT/home/.* .

cd ~/.config
ln -sf $LINKDOT/config/* .

echo "Installation Complete! Restart the computer."
