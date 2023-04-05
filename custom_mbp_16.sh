#!/usr/bin/env bash

function binstall {
  # Comment out the last 2 lines of this script
  tail -n 2 Gemfile | sed -i '' 's/^/#/' Gemfile

  bundle exec pod install --repo-update --verbose

  # uncomment these lines to
  tail -n 2 Gemfile | sed -i '' 's/^.//' Gemfile
}

alias pinstallr="bundle exec pod install --repo-update --verbose"
