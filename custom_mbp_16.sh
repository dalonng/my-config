#!/usr/bin/env bash

function binstall {
  # remove last two lines
  sed -i '' '$d;$d' Gemfile

  bundle install

  # undo file modifications
  git checkout -- Gemfile
}

alias pinstallr="bundle exec pod install --repo-update --verbose"
