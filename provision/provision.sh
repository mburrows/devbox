sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove

# Utilities
sudo apt-get -y install dos2unix

# Basic X11 windowing
sudo apt-get -y install x11-apps xauth xclip

# Install the friendly interactive shell
sudo apt-get -y install fish

# Dev tools
sudo apt-get -y install git
sudo apt-get -y install exuberant-ctags
sudo apt-get -y install silversearcher-ag

# C++ environment
sudo apt-get -y install cmake
sudo apt-get -y install clang
sudo apt-get -y install libboost-dev
sudo apt-get -y install gdb

# Install python2 support with numerical libraries
sudo apt-get -y install python-dev python-pip 
sudo apt-get -y install ipython python-numpy python-matplotlib python-scipy

# Install python3 support
sudo apt-get -y install python3-dev python3-pip

# Install ruby support
sudo apt-get -y install ruby ruby-dev

# Install tmuxinator
sudo gem install tmuxinator

# Circuit simulation using SPICE
sudo apt-get -y install ngspice

function link_dot 
{
    SOURCE_FILE=/vagrant/dotfiles/$1
    TARGET_FILE=$2
    TARGET_DIR=`dirname $2`    
    
    if [ ! -f "$SOURCE_FILE" ]; then
        echo "$SOURCE_FILE does not exist"
        return
    fi

    if [ ! -d "$TARGET_DIR" ] ; then
        mkdir -p $TARGET_DIR
    fi

    if [ -f "$TARGET_FILE" ]; then
        echo "$TARGET_FILE already exist"
        return
    fi

    ln -s $SOURCE_FILE $TARGET_FILE
}

link_dot .vimrc $HOME/.vimrc 
link_dot .tmux.conf $HOME/.tmux.conf 
link_dot .inputrc $HOME/.inputrc 
link_dot .tmuxline.conf $HOME/.tmuxline.conf 
link_dot .gitconfig $HOME/.gitconfig 
link_dot config.fish $HOME/.config/fish/config.fish

# Install some perty colours for the shell
if [ ! -d "$HOME/.config/base16-shell" ] ; then
    git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
fi

if [ ! -f "$HOME/.bashrc.local" ] ; then
    link_dot .bashrc.local $HOME/.bashrc.local
    cat << 'EOS' >> $HOME/.bashrc
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
EOS
fi

