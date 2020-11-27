#!/bin/bash

## Change apt src
cp /etc/apt/sources.list /etc/apt/sources.list.bak
#cp ./sources.list /etc/apt/sources.list
sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/us.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
sed -i 's/us.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list
apt update

## Do apt
apt install -y openssh-server vim zsh curl tmux net-tools	neovim  \
	python3-pip libssl-dev libffi-dev build-essential bat fd-find  \

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

## gdb plugins
mkdir -p ~/.gdbtools
git clone https://github.com/longld/peda.git ~/.gdbtools/peda
git clone https://github.com/scwuaptx/Pwngdb.git ~/.gdbtools/Pwngdb

## python packages
pip3 install --upgrade pip
pip3 install --upgrade pwntools

## install node&yarn
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update && apt install yarn

## neovim
CUSTOM_NVIM_PATH=/usr/bin/nvim
set -u
update-alternatives --install /usr/bin/ex ex "${CUSTOM_NVIM_PATH}" 110
update-alternatives --install /usr/bin/vi vi "${CUSTOM_NVIM_PATH}" 110
update-alternatives --install /usr/bin/view view "${CUSTOM_NVIM_PATH}" 110
update-alternatives --install /usr/bin/vim vim "${CUSTOM_NVIM_PATH}" 110
update-alternatives --install /usr/bin/vimdiff vimdiff "${CUSTOM_NVIM_PATH}" 110
mkdir -p ~/.local/share/nvim/site
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
chmod +rwx ~/.local/share/nvim/site/autoload
mkdir -p ~/.config/nvim

## Copy config files
cp ./.gdbinit ~/
cp ./init.vim ~/.config/nvim/
cp ./.tmux.conf ~/
cp ./.zshrc ~/
cp ./coc-settings.json ~/.config/nvim

## vim plugins
snap install ccls --classic
vim -es -c "PlugInstall"
vim -es -c "CocInstall coc-json" -c "CocInstall coc-python"

## Change ownership
chown -R mnur:mnur ~/.local/share/
chown -R mnur:mnur ~/.config/
chsh -s /bin/zsh mnur

echo "Done!"
