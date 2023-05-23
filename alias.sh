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
alias g="git"
alias cat="cat -n"

# git
alias gt="git log --graph --oneline --all"
alias gspush="git stash push"
alias gspop="git stash pop"
alias gclean="git clean -d -f"
alias amend="git commit --amend --no-edit"
alias gup="git-up"
alias gfollow="git log --follow --"
alias fo="fork"
alias tfile="tig --"

alias bup="brew update --verbose && brew upgrade --verbose"

# moden unix
alias ls="exa"
alias 10rg="rg -A 10 -B 10"
alias rg="rg --no-ignore"

# python tools
alias http="python3 -m http.server 8000"
alias prettyjson='python -m json.tool'
