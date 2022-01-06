# Dotfile backup to github

I have moved the config files within the repo from their original locations to the `~/dotfiles` folder. These are then symlinked back to their original locations.

For example, in the case of the i3 config file that exists in `~/.config/i3/config` by default, the following commands would move it to the dotfiles folder, then create the symlink respectively:

```bash
mkdir ~/dotfiles/i3
mv ~/.config/i3/config ~/dotfiles/i3/config
ln -s ~/dotfiles/i3/config ~/.config/i3/config  # -s specifies a symlink
```
