#!/usr/local/bin/bash


if command -v mcfly 1>/dev/null 2>&1; then
  eval "$(mcfly init zsh)"
fi

export TOOLCHAINS=swift
export SWIFTENV_ROOT="$HOME/.swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
if command -v swiftenv 1>/dev/null 2>&1; then
  eval "$(swiftenv init -)"
fi

export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi