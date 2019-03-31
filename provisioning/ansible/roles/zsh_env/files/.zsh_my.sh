export EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc

export LESS="-XeFR"

manp()
{
  man -t "${1}" | open -f -a Skim
}

eval "$(lessfile)"
alias tmux-a-d='tmux new -A -D -s J'

alias cd..='cd ..';
alias df='df -h'
alias du='/usr/bin/du -h -d 1'
alias ipy='ipython --pyplot inline'

unalias ll
unalias l
function ll()
{
  if [[ -d $1 ]]; then
    #   /bin/ls -Galwuh "$@" |less -Er;
    /bin/ls -Nhalu --color='always'  "$@" |/bin/less -XEr;
  else
    if [[ -n $1 ]]; then
      #     /bin/ls -Galdwuh "$@" |less -Er;
      /bin/ls -Nhdalu --color='always'  "$@" |/bin/less -XEr;
    else
      #       /bin/ls -Galwuh|less -Er;
      /bin/ls -Nhalu --color='always'   | /bin/less -XEr;
    fi
  fi
}
function l() {
  if [[ -n $1 ]]; then
    #   /bin/ls -daGCFwh "$@" |less -Er;
    /bin/ls -NhdaCF --color='always'  "$@" | /bin/less -XEr;
  else
    #   /bin/ls -aGCFwh |less -Er;
    /bin/ls -NhaCF --color='always' | /bin/less -XEr;
  fi
}
function lda() {
  if [[ -n $1 ]]; then
    #   /bin/ls -dltGwh "$@" |less -Er;
    /bin/ls -Nhdlt --color='always'  "$@" | /bin/less -XEr;
  else
    #   /bin/ls -ltGwh|less -Er;
    /bin/ls -Nhlt --color='always'  | /bin/less -XEr;
  fi
}
s() { pwd > ~/.save_dir ; }
i() { cd "$(cat ~/.save_dir)" ; }

if [ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ]; then
  source /usr/local/bin/virtualenvwrapper_lazy.sh
fi  

eval $(ssh-agent -s) 
function cleanup {
  echo "Killing SSH-Agent"
  kill -9 $SSH_AGENT_PID
}
trap cleanup EXIT

