#!/bin/zsh

cd `dirname $0`/../

# zshrcは書き換えること多いので、不用意に消さないように
if [ ! -f $HOME/.zshrc ]; then
  ln -sf $PWD/zsh/zshrc $HOME/.zshrc
fi

if [ -e $HOME/.tmux.conf ]; then
  rm -f $HOME/.tmux.conf
fi
ln -sf $PWD/zsh/tmux.conf $HOME/.tmux.conf

if [ -e $HOME/.vimrc ]; then
  rm -f $HOME/.vimrc
fi
ln -sf $PWD/vim/vimrc $HOME/.vimrc

if [ -e $HOME/.ctags ]; then
  rm -f $HOME/.ctags
fi
ln -sf $PWD/vim/ctags $HOME/.ctags

if [ -e $HOME/Library/Application\ Support/Code/User/settings.json ]; then
  rm -f $HOME/Library/Application\ Support/Code/User/settings.json
fi
ln -s $PWD/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

if [ ! -d $HOME/.vim ]; then
  mkdir -p $HOME/.vim/rc/ $HOME/.vim/tmp/backup/ $HOME/.vim/tmp/snippets $HOME/.vim/tmp/swap/
fi
ln -sf $PWD/vim/dein.toml $HOME/.vim/rc/dein.toml
ln -sf $PWD/vim/dein_lazy.toml $HOME/.vim/rc/dein_lazy.toml

if [ ! -d $HOME/.sdkman ]; then
  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk version
fi
sdk install java

if [ ! -d $HOME/.anyenv ]; then
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
  exec $SHELL -l
fi

if [ ! -d $HOME/.anyenv/envs/nodenv ]; then
  anyenv install nodenv
  exec $SHELL -l
fi
nodenv install `cat .node_version`
nodenv global  `cat .node_version`
nodenv rehash

if [ ! -d $HOME/.anyenv/envs/rbenv ]; then
  anyenv install rbenv
  exec $SHELL -l
fi
rbenv install `cat .ruby_version`
rbenv global  `cat .ruby_version`
rbenv rehash

