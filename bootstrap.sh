#! /bin/bash

sudo apt-get update
sudo apt-get install vim tmux

echo "Setting up profile"
echo "" >> ~/.bashrc
cat dotfiles/bashrc >> ~/.bashrc

echo "Setting up VIM.."
cp dotfiles/vimrc ~/.vimrc

