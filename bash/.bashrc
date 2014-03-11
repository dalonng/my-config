alias g='git'
alias lsnew=" ls -al --time-style=+%D | grep `date +%D` "
alias cd..="cd .."
function gi() { curl http://www.gitignore.io/api/$@ ;}
