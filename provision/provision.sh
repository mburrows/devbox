sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove

# Utilities
sudo apt-get -y install xclip

# Dev tools
sudo apt-get -y install git

# C++ environment
sudo apt-get -y install cmake
sudo apt-get -y install clang
sudo apt-get -y install libboost-dev
sudo apt-get -y install gdb

# R environment
sudo apt-get -y install r-base
sudo apt-get -y install r-base-dev

# Circuit simulation using SPICE
sudo apt-get -y install ngspice

# Install Vundle plugin for vim
if [ ! -d "$HOME/.vim/bundle" ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    echo "Vundle installed. Now run: vim +PluginInstall +qall"
fi
    
