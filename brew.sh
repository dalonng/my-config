#!/usr/bin/env bash

# 升级最新版 Homebrew
brew update

# 升级 formulae
brew upgrade

brew insteall rbenv
brew install git-lfs
brew install swiftlint
brew install ghostscript
brew install ImageMagick

brew cleanup
