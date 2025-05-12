#!/usr/local/bin/bash

# sourcetree
alias st="stree"

# brew install ncdu
alias du="ncdu --color dark -rr -x --exclude .git"

# fleet
if test -f "/usr/local/bin/fleet"; then
  alias f="/usr/local/bin/fleet"
fi
# vscode
if test -f "/usr/local/bin/code"; then
  alias c="/usr/local/bin/code"
fi

alias e="emacs --debug-init"
alias cat="cat -n"

# git
alias g="git"
alias gt="git log --graph --oneline --all"
alias gspush="git stash push"
alias gspop="git stash pop"
alias gclean="git clean -d -f"
alias gup="git-up"
alias gfollow="git log --follow --"
#alias fo="fork"
alias tfile="tig --"

alias bup="brew update --verbose && brew upgrade --verbose"

# remove derived data
alias cleandt="rm -rf ~/Library/Developer/Xcode/DerivedData"

# moden unix
alias ls="lsd"
alias 10rg="rg -A 10 -B 10"
alias rg="rg --no-ignore"

# python tools
alias http="python3 -m http.server 8000"
alias prettyjson='python -m json.tool'
alias python=python3
alias pip=pip3

alias o="open ."
