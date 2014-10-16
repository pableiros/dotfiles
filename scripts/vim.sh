#!/usr/bin/env bash
#
# vim
#
# http://www.vim.org/
# vim editor
#
set -e

echo "Vim"

# check for vim
if test $(which vim)
then
    
    # vim-pathogen
    # https://github.com/tpope/vim-pathogen
    # manage your runtimepath

    # install
    echo "Install pathogen"
    if [[ ! -d ~/.vim/autoload && ! -d ~/.vim/bundle ]]; then
        mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    else
        echo "pathogen is already installed"
    fi

    # vim plugins (github)
    declare -a plugins=(
        altercation/vim-colors-solarized
        bling/vim-airline
        scrooloose/nerdtree
    )

    echo "Install plugins"
    for plugin in "${plugins[@]}"
    do
        # get dest
        dest=${plugin#*/}
        dest=${dest%%.git}
        
        cd ~/.vim/bundle
        if [[ ! -d $dest ]]; then
            echo "Installing ${plugin}"
            git clone git://github.com/$plugin.git
        else
            echo "Plugin ${plugin} exists"
            echo "Updating.."
            cd $dest
            git pull origin master
        fi
    done

    # config dir
    if [[ -d ../configs ]]; then
        vimrc=../configs/vimrc
    else
        vimrc=configs/vimrc
    fi

    # .vimrc file
    if [[ -f  $vimrc ]]; then
        cp -f $vimrc ~/.vimrc
    fi
    echo -e "Done\n"
else
    echo "vim not installed"
fi