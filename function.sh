#!/usr/local/bin/bash

function mcd() {
  mkdir -p "$1"
  cd "$1" || exit
}

function pids_by_name {
  pids=$(ps -ef | pgrep "$1" | awk '{print $2}')
  echo "${pids}"
}

function killps {
  for pid in $(ps -ef | pgrep "$1" | awk '{print $3}'); do
    kill -9 "$pid"
  done
}

########################################################################
# FZF
########################################################################
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code(completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf "$@" --preview 'tree -C {} | head -200' ;;
  export | unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
  ssh) fzf "$@" --preview 'dig {}' ;;
  *) fzf "$@" ;;
  esac
}

################################################################

function fcat() {
  local path
  path="$(/usr/local/bin/fd --type f "$1")"
  /usr/local/bin/bat "$path" --theme=gruvbox-dark
}

function rcat() {
  local path
  path="$(/usr/local/bin/fd --type f "$1")"
  /usr/local/bin/rich "$path" --theme=gruvbox-dark
}

finish_work() {
    # 获取当前分支名
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # 检查是否在 main 分支
    if [ "$current_branch" = "main" ]; then
        echo "You are already on the main branch."
        return 1
    fi

    # 检查是否有未提交的更改
    if ! git diff-index --quiet HEAD --; then
        echo "You have uncommitted changes. Please commit or stash them before running finish_work."
        return 1
    fi

    # 切换到 main 分支
    git checkout main

    # 更新 main 分支
    git pull origin main

    # 删除当前分支
    git branch -D "$current_branch"

    echo "Finished work on branch $current_branch. Switched to main and deleted the branch."
}
