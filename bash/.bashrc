alias g='git'
alias lsnew=" ls -al --time-style=+%D | grep `date +%D` "
alias cd..="cd .."
alias ls='ls -p'
alias ll="ls -l"
function gi() { curl http://www.gitignore.io/api/$@ ;}

export PS1='\e[0;32m\w\e[m $'
