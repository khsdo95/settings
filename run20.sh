#!/bin/bash

## Change apt src
cp /etc/apt/sources.list /etc/apt/sources.list.bak
#cp ./sources.list /etc/apt/sources.list
sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/us.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/us.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
apt-get update

## Add arch
dpkg --add-architecture i386
apt-get update

## Do apt-get
apt-get install -y openssh-server vim zsh curl tmux net-tools	neovim  \
	libc6:i386 libncurses5:i386 libstdc++6:i386 gcc-6-multilib	\
	python-dev python-pip python3-pip libssl-dev libffi-dev build-essential

## zsh plugins
mkdir -p ~/.zshtools
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zshtools/fzf
~/.zshtools/fzf/install --all
git clone https://github.com/clvv/fasd ~/.zshtools/fasd
sh -c "cd ~/.zshtools/fasd; make install"
wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb	\
	-O ~/.zshtools/pet_0.3.0_linux_amd64.deb
dpkg -i ~/.zshtools/pet_0.3.0_linux_amd64.deb
apt install bat
apt install fd-find

## gdb plugins
mkdir -p ~/.gdbtools
git clone https://github.com/longld/peda.git ~/.gdbtools/peda
git clone https://github.com/scwuaptx/Pwngdb.git ~/.gdbtools/Pwngdb

## python packages
pip3 install --upgrade pip
pip3 install --upgrade pwntools

## install node&yarn
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update && apt install yarn

## Copy config files
cp ./.gdbinit ~/
cp ./init.vim ~/.config/nvim/
cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./coc-settings.json ~/.config/nvim

## vim plugins
snap install ccls
vim +PlugInstall +qall
vim -es -c "CocInstall coc-json" -c "CocInstall coc-python"

## Change ownership
chown -R mnur:mnur ~/.local/share/
chown -R mnur:mnur ~/.config/
chsh -s /bin/zsh mnur

echo "Done!"
