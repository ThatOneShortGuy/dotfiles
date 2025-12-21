# My Config
This is my `~/.config` directory for all the things I will want to move across distros and computers.
It probably isn't fully encompasing, but should handle most of the things I want

## Install Dotfiles
```sh
# Retrieve files
git clone --recurse-submodules https://github.com/ThatOneShortGuy/dotfiles.git ~/dotfiles/
```

### Copy existing dotfiles in (optional)
```sh
cp -r ~/.config/. ~/dotfiles/
mv ~/.config ~/.config.temp
```

```sh
mv ~/dotfiles ~/.config
```

## Install Programs
```sh
# Installing yay
sudo pacman -Sy needed git base-devel && git clone https:/aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ..

# Brave and Hypremoji
yay -Sy brave-bin hypremoji

# Pacman apps
sudo pacman -Sy cliphist hyprshot pyenv fzf nvm hyprpicker \
    hyprlock hyprpaper hypridle brightnessctl qt5-wayland qt6-wayland

# Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Starship (pretty terminal)
curl -sS https://starship.rs/install.sh | sh

# Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

## Use .bashrc
```sh
rm ~/.bashrc && ln ~/.config/.bashrc ~/.bashrc
```


## TODOs
- [ ] Write up what commands were used to install the things
- [ ] Make an install script that handles all the specific programs

