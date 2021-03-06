#!/usr/bin/env bash
#
# Homebrew
#
# http://brew.sh/
# The missing package manager for OS X
#
set -e

echo "Homebrew"

os=`uname`
if [[ $os == "Darwin" ]]; then
    # check for homebrew
    if test ! $(which brew) || [[ $1 -eq "-f" ]]
    then
        echo "Installing brew core"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

        echo "Installing brew packages"
        brew install \
            ansible \
            bash \
            binutils \
            coreutils \
            git \
            gpg \
            gnupg \
            grc \
            htop-osx \
            iftop \
            macvim \
            most \
            openssl \
            pinentry-mac \
            pwgen \
            speedtest-cli \
            ssh-copy-id \
            tree \
            vim \
            wget \
            zsh

       brew cask install macvim

       echo "Brew cleanup"
       brew cleanup

       if [[ -f /usr/local/bin/zsh ]]; then
           echo "Enable zsh on /etc/shells"
           echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
       fi

       echo "Installing brew cask"
       brew install caskroom/cask/brew-cask

       echo "Installing brew cask packages"
       brew cask install \
           google-chrome \
           iterm2 \
           sequel-pro \
           spotify

       echo "Installing brew cask fonts"
       brew tap caskroom/fonts
       brew cask install \
           font-source-code-pro

       echo "Brew cleanup"
       brew cleanup
       brew cask cleanup

    else
        echo "Homebrew is already installed"
    fi
    echo -e "Done\n"
else
    echo -e "OS not Supported\n"
fi
