sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove

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

# Install pathogen plugin for vim
if [ ! -d "$HOME/.vim/bundle" ] ; then
    mkdir -p $HOME/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    echo "Vundle installed. Now run: vim +PluginInstall +qall"
fi
