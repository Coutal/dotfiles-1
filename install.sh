#!/bin/sh

SYSUSERNAME=toni

# Export the path to this directory for later use in the script
export LINKDOT=$PWD

# Install fonts and programs.
sudo pacman -S ttf-joypixels ttf-croscore noto-fonts-cjk noto-fonts \
    ttf-fantasque-sans-mono ttf-linux-libertine rofi mpv fzf maim \
    alacritty alacritty-terminfo compton neofetch dash neovim cmus \
    feh xclip sxhkd bspwm i3-gaps dunst zathura-pdf-mupdf redshift \
    diff-so-fancy zsh-autosuggestions zsh-syntax-highlighting exa \
    xorg-server xorg-xinit xorg-xprop libnotify fd emacs blender \
    nnn bat ripgrep httpie sxiv firefox zathura-cb qbittorrent gimp \
    krita obs-studio
#realtime-privileges qtractor

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
#sudo install -Dm 644 other/99-realtime-privileges.conf /etc/security/limits.d/99-realtime-privileges.conf

# Add self to realtime group. Needed for pro audio programs.
#sudo gpasswd -a $SYSUSERNAME realtime

# Make some folders needed for proper functionality.
mkdir -p ~/.config ~/.aurpkgs

# Clone the aur packages being installed. Polybar and Oh-My-Zsh
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
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
