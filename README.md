# My dotfiles

```bash
$ git clone https://github.com/math2001/dotfiles
# use what you need
$ ln -s dotfiles/.bashrc .bashrc
$ ln -s dotfiles/.vimrc .vimrc
$ ln -s dotfiles/.tmux.conf .tmux.conf
$ ln -s ~/dotfiles/.vim ~/.vim
# Download minpac
$ git clone https://github.com/k-takata/minpac.git \
    ~/.vim/pack/minpac/opt/minpac
# make backup folders
mkdir -p ~/.vim/.backups ~/.vim/.swapfiles ~/.vim/.undos
```

And then `:PackUpdate`
