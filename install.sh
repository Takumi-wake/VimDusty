#!/bin/bash

# if [ -a ~/.vimrc ]
#     then
#     mv -f ~/.vimrc ~/.vimrc.bak
# fi

# if [ -d ~/.vim ]
#     then
#     mv -f  ~/.vim ~/.vim.bak
# fi

rm -rf ~/.vim
rm -rf ~/.vimrc

ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/vim ~/.vim

