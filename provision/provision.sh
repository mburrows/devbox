sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove

# Dev tools
sudo apt-get -y install git

# C++ environment
sudo apt-get -y install cmake
sudo apt-get -y install clang
sudo apt-get -y install libboost-dev

# R environment
sudo apt-get -y install r-base
sudo apt-get -y install r-base-dev

# Circuit simulation
sudo apt-get -y install ngspice

if [ ! -d "~/.vim/bundle" ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
