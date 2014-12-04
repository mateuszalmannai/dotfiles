#!/bin/bash
#################################################
# .setup.sh
# script to create symlinks in the home directory
# to any desired dotfiles in ~/dotfiles
#################################################

declare -r dir=~/.dotfiles
declare -r old_dir=~/.dotfiles_old
declare -r time_stamp=$(date +%Y-%m-%d-%H-%M-%S)
declare -r files="bashrc vimrc vim zshrc oh-my-zsh"

echo "Creating $old_dir for backup of any existing dotfiles in ~"
mkdir -p $old_dir
echo "...done"
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory 
# then create symlinks
for file in $files; do 
  echo "Moving any existing dotfiles from ~ to $old_dir"
  mv ~/.$file ~/dotfiles_old/$file_$time_stamp
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done
