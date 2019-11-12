# My dotfiles

What I use:

- fish shell
- vim
- tmux

## How it's setup

Everything is my `dotfiles` folder, and then it's just symlinks:

```
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/fish/ ~/.config/
```
