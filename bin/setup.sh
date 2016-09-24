#!/bin/zsh

cd `dirname $0`/../

if [ -e $HOME/.zshrc ]; then
  rm -f $HOME/.zshrc
fi
ln -sf $PWD/zsh/zshrc $HOME/.zshrc

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

if [ ! -d $HOME/.vim ]; then
  mkdir -p $HOME/.vim/bundle/ $HOME/.vim/tmp/backup/ $HOME/.vim/tmp/snippets $HOME/.vim/tmp/swap/
  git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/
fi

if [ ! -d $HOME/.anyenv ]; then
  git clone https://github.com/riywo/anyenv $HOME/.anyenv
  exec $SHELL -l
fi

if [ ! -d $HOME/.anyenv/envs/ndenv ]; then
  anyenv install ndenv
  exec $SHELL -l
  cat .node-version | ndenv install
  ndenv global `cat .node-version`
  ndenv rehash
fi

if [ ! -d $HOME/.anyenv/envs/rbenv ]; then
  anyenv install rbenv
  exec $SHELL -l
  cat .ruby-version | rbenv install
  rbenv global `cat .ruby-version`
  rbenv rehash
fi

