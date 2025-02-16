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

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

if [ -d "$HOME/opt/bin" ]; then
  export PATH="$HOME/opt/bin:$PATH"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
