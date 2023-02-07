#!/usr/bin/env bash

function check_and_install()
{
  status=$(command -v "$1")
  bottle=$2
  if [ -z "$2" ]
  then
    bottle="$1"
  fi

  if ! [ -x "$status" ]; then
    echo "Installing $bottle ..."
    brew install "$bottle"
  fi
}

# 升级最新版 Homebrew
brew update

# 升级 formulae
brew upgrade

check_and_install emacs
check_and_install ncdu
check_and_install rbenv
# check_and_install swiftenv
check_and_install git-lfs
check_and_install swiftlint
check_and_install gs ghostscript
check_and_install magick ImageMagick
check_and_install stree sourcetree
check_and_install mcfly
check_and_install exa
check_and_install rg ripgrep
check_and_install tig
check_and_install stats
check_and_install mate textmate

brew cleanup

# install zsh-autosuggestions - suggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
