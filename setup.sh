#!/usr/bin/env bash
function doIt() {
	ln -s ~/.dotfiles/.bashrc ~/.bashrc
	ln -s ~/.dotfiles/fish ~/.config/fish
	ln -s ~/.dotfiles/_vimrc ~/.vimrc
	ln -s ~/.dotfiles/vimfiles ~/.vim
	ln -s ~/.dotfiles/.xmodmap ~/.xmodmap
	ln -s ~/.dotfiles/.rspec ~/.rspec
	ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
	ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
        mkdir ~/.vimtmp
        mkdir ~/.vimtmp/swap
        mkdir ~/.vimtmp/backup

	mkdir ~/bin
	curl http://hub.github.com/standalone -sLo ~/bin/hub
	chmod +x ~/bin/hub
	ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt
	fi
fi
unset doIt

