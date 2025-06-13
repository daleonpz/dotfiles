if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1

set -o vi

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete
shopt -s nocaseglob

#######################################################
# Exports
#######################################################
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export EDITOR=vim
export VISUAL=vim
export SUDO_EDITOR=/usr/bin/vim
export PATH=/usr/local/bin:$PATH
export CPATH=/usr/local/include:$CPATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PROMPT_COMMAND='history -a; history -r'
export PATH=$PATH:/home/dnl/.scripts/

#######################################################
# alias
#######################################################
alias execjekyll='bundle exec jekyll serve'
alias ctagsbuild='ctags -R .'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fehslides='feh -r -F -V -d -Z'


#########################################################3
# Prompt
#########################################################3
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# prompt
# PS1='[\u@\h \W]\$ '  # Original prompt     
nix_shell_indicator() {
    if [ -n "$IN_NIX_SHELL" ]; then
        echo -e "$BIGreen(nix)$Color_Off"
    fi
}
PS1="\[$White\]\d - \A \[$BIWhite\][\W]\$(nix_shell_indicator)\n\[$BIYellow\][Jobs:\j] \u@\h \[$BIGreen\]\$(parse_git_branch)\[$IWhite\] "



#######################################################
# functions
#######################################################
# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
opendocument(){
    zathura "$*" &> /dev/null 
}

mubrowser(){
    cd ~/Downloads/mullvad-browser 
    ./start-mullvad-browser.desktop --browser &> /dev/null
    cd -
}

browser(){
     firefox &> /dev/null
}

chrome(){
    mullvad-exclude chromium &> /dev/null
}

mkcd () {
    mkdir -p "$*"
    cd "$*"
}

pomodoro_break_50_10 (){
    sleep 50m && xfce4-terminal --fullscreen --font=150 -x break_reminder.sh countdown 600
}
pomodoro_break_45_15 (){
    sleep 45m && xfce4-terminal --fullscreen --font=150 -x break_reminder.sh countdown 900
}

pomodoro_break_25_5 (){
    sleep 25m && xfce4-terminal --fullscreen --font=150 -x break_reminder.sh countdown 300
}

pomodoro_break_30_10 (){
    sleep 30m && xfce4-terminal --fullscreen --font=150 -x break_reminder.sh countdown 600
}

dpick() {
    local args=($(pick "$1" "$(ret)") )
    vim "${args[@]}"
}

dgrep() {
    cgrep "$@" | cap
}

#######################################################
# fzf
#######################################################
# fzf autocompletion aktivieren
if [ -x "$(command -v fzf)"  ]
then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#######################################################
# Exports
#######################################################
export PATH=/usr/local/bin:$PATH
export CPATH=/usr/local/include:$CPATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PROMPT_COMMAND='history -a; history -r'
export PATH=$PATH:/home/dnl/.scripts/
export EDITOR=vim
export VISUAL="vim"
export SUDO_EDITOR=/usr/bin/vim

#######################################################
# cscope and ctags
#######################################################
function build_cscope_db_func()
 {
     find $PWD -name '*.c' \
            -o -name '*.h' \
            -o -name '*.mk' \
            -o -name '*.xml'\
            -o -name '*.cfg'\
            -o -name '*.ini'\
            -o -name '*.dat'\
            -o -name '*.py'\
            -o -name '*.cpp' > $PWD/cscope.files
  cscope -RCbk
  export CSCOPE_DB=$PWD/cscope.out
}

alias csbuild=build_cscope_db_func

function cscope_export_db_func()
{
   export CSCOPE_DB=$PWD/cscope.out
}
alias csexport=cscope_export_db_func
alias tagsbuild='csbuild && ctagsbuild'

#######################################################
# NVM
#######################################################
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

########################################################
# YAZI
########################################################
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

