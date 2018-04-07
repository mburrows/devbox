sudo add-apt-repository -y ppa:neovim-ppa/unstable

sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove

# Utilities
sudo apt-get -y install dos2unix

# Basic X11 windowing
sudo apt-get -y install x11-apps xauth xclip

# Dev tools
sudo apt-get -y install git

# C++ environment
sudo apt-get -y install cmake
sudo apt-get -y install clang
sudo apt-get -y install libboost-dev
sudo apt-get -y install gdb

# Python/matplotlib
sudo apt-get -y install ipython python-numpy python-matplotlib python-scipy

# Circuit simulation using SPICE
sudo apt-get -y install ngspice

# Install neovim and optional provider plugins
sudo apt-get -y install neovim
sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo apt-get -y install ruby ruby-dev
sudo pip2 install --upgrade neovim
sudo pip3 install --upgrade neovim
sudo gem install neovim

if [ ! -d "$HOME/.config/nvim" ] ; then
    mkdir -p $HOME/.config/nvim
    cat << 'EOS' > $HOME/.config/nvim/init.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOS
fi

# Install Vundle plugin for vim
if [ ! -d "$HOME/.vim/bundle" ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    echo "Vundle installed. Now run: vim +PluginInstall +qall"
fi

# Install some perty colours for the shell
if [ ! -d "$HOME/.config/base16-shell" ] ; then
    git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
fi
    
# Setup local bashrc overrides
if [ ! -f "$HOME/.bashrc.local" ] ; then
    cat << 'EOS' > $HOME/.bashrc.local
source ~/.config/base16-shell/scripts/base16-tomorrow-night.sh

export EDITOR=vim
export PS1="\[\e[32m\]\u\[\e[m\]\[\e[32m\]:\[\e[m\]\[\e[35m\]\W\[\e[m\]\[\e[37m\]\\$\[\e[m\] "

alias rl='source ~/.bashrc'
alias g='git grep'
alias l='ls -lrt'
alias tmux='tmux -2'
EOS

    cat << 'EOS' >> $HOME/.bashrc

[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
EOS
fi

