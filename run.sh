#!/bin/bash

## Change apt src
cp /etc/apt/source.list /etc/apt/source.list.bak
cp ./source.list /etc/apt/source.list
apt-get update

## Add arch
dpkg --add-architecture i386
apt-get update

## Do apt-get
apt-get install -y openssh-server vim zsh neovim python-pip python3-pip curl tmux bat	\
	libc6:i386 libncurses5:i386 libstdc++6:i386 gcc-6-multilib	\

## zsh plugins
chsh -s /bin/zsh
mkdir -p ~/.zshtools
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zshtools/fzf
~/.zshtools/fzf/install --all
git clone https://github.com/clvv/fasd ~/.zshtools/fasd
sh -c "cd ~/.zshtools/fasd; make install"
wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb	\
	-O ~/.zshtools/pet_0.3.0_linux_amd64.deb
dpkg -i ~/.zshtools/pet_0.3.0_linux_amd64.deb
# apt install bat
wget https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb	\
	-O ~/.zshtools/bat_0.17.1_amd64.deb
dpkg -i ~/.zshtools/bat_0.17.1_amd64.deb
# apt install fd-find
wget https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb		\
	-O ~/.zshtools/fd_8.1.1_amd64.deb
dpkg -i ~/.zshtools/fd_8.1.1_amd64.deb

## gdb plugins
mkdir -p ~/.gdbtools
git clone https://github.com/longld/peda.git ~/.gdbtools/peda
git clone https://github.com/scwuaptx/Pwngdb.git ~/.gdbtools/Pwngdb

## Copy config files
cp ~/.gdbtools/Pwngdb/.gdbinit ~/
cp ./.vimrc ~/
cp ./.tmux.conf ~/
cp ./.zshrc ~/

