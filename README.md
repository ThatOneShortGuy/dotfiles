# My Config
This is my `~/.config` directory for all the things I will want to move across distros and computers.
It probably isn't fully encompasing, but should handle most of the things I want

## Install Dotfiles
```sh
# Retrieve files
git clone --recurse-submodules https://github.com/ThatOneShortGuy/dotfiles.git ~/dotfiles/

# Copy existing config
cp -r ~/.config/. ~/dotfiles/
mv ~/.config ~/.config.temp
mv ~/dotfiles ~/.config
```
## TODOs
- [ ] Write up what commands were used to install the things
- [ ] Make an install script that handles all the specific programs

