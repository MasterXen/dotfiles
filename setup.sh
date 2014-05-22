#!/usr/bin/env bash
function doIt() {
    mkdir -p ~/.vimtmp/swap
    mkdir -p ~/.vimtmp/backup
    mkdir -p ~/config/fish
    mkdir -p ~/bin

    ensure_link ".dotfiles/.bashrc"               ".bashrc"
    ensure_link ".dotfiles/fish"                  ".config/fish"
    ensure_link ".dotfiles/_vimrc"                ".vimrc"
    ensure_link ".dotfiles/vimfiles"              ".vim"
    ensure_link ".dotfiles/.xmodmap"              ".xmodmap"
    ensure_link ".dotfiles/.rspec"                ".rspec"
    ensure_link ".dotfiles/.tmux.conf"            ".tmux.conf"
    ensure_link ".dotfiles/.gitconfig"            ".gitconfig"
    ensure_link ".dotfiles/.gitignore_global"     ".gitignore_global"
    ensure_link ".dotfiles/.slate.js"             ".slate.js"
    ensure_link ".dotfiles/.pentadactyl.rc"       ".pentadactyl.rc"

    ensure_link ".dotfiles/bin/colortest"         "bin/colortest"
    ensure_link ".dotfiles/bin/git_prompt_status" "bin/git_prompt_status"

    curl http://hub.github.com/standalone -sLo ~/bin/hub
    chmod +x ~/bin/hub
}

function ensure_link {
    test -L "$HOME/$2" || ln -s "$HOME/$1" "$HOME/$2"
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

