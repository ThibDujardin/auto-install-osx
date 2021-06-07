#!/bin/zsh
# 
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing  Oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &>/dev/null

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU core utilities (those that come with OS X are outdated)
brew install findutils

PACKAGES=(
    ack
    autoconf
    autojump
    automake
    asdf
    awscli
    docker
    docker-machine
    ffmpeg
    gettext
    gifsicle
    git
    gh
    go
    graphviz
    helm
    highlight
    hub
    hugo
    imagemagick
    jq
    kubectx
    kubedecode
    kubernetes-cli
    kube-ps1
    libjpeg
    libmemcached 
    markdown
    maven
    memcached
    npm
    node
    nvm
    pkg-config
    postgresql
    rabbitmq
    rename
    shellcheck
    ssh-copy-id
    terminal-notifier
    the_silver_searcher
    tree
    wget
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."
brew install caskroom/cask/brew-cask

CASKS=(
    flux
    google-chrome
    google-cloud-sdk
    gpg-suite
    iterm2
    intellij-idea
    rambox
    slack
    visual-studio-code
    vlc
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing fonts..."
brew tap caskroom/fonts
FONTS=(
    font-inconsolidata
    font-roboto
    font-clear-sans
)
brew cask install ${FONTS[@]}

echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}

echo "Installing global npm packages..."
npm install marked -g

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true


# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# Enable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

echo "Creating folder structure..."
[[ ! -d Workspace ]] && mkdir Workspace
[[ ! -d GitHub ]] && mkdir GitHub

echo "generate SSH KEY"
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""

echo "Bootstrapping complete"
