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
export PATH=/opt/SEGGER/JLink:$PATH
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
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias ls='eza --icons --group-directories-first --color=always'
alias cat='bat'
alias ccat='bat -P'
alias tree='eza --tree -la --icons'
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
    # Use mullvad-exclude to run Chrome outside the VPN
    # added flags to disable Manifest V2 extensions, because uBlock Origin stopped working otherwise
    mullvad-exclude chromium --disable-features=ExtensionManifestV2Unsupported,ExtensionManifestV2Disabled &> /dev/null
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

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

dpick() {
    chosen_line=$(echo "$(ret)" | sed -n "${1}p" |sed 's/\x1b\[[0-9;]*m//g')

    local rest=$(echo "$chosen_line" | sed 's/^[0-9]\+[[:space:]]\+//')
    local file_name=$(echo "$rest" | cut -d: -f1)
    local line_number=$(echo "$rest" | cut -d: -f2)

    vim +"$line_number" "$file_name"
}

dgrep() {
      rg --color=always -n "$@" | awk -v OFS='\t' '{print NR, $0}' | cap
}

crg() { 
    if [ -z "$1" ]; then 
        echo "Usage: crg <pattern> [additional rg options]" 
        return 1 
    fi

    rg --color=always --line-number --no-heading "$@" \
        | fzf --ansi --delimiter : \
        --preview '
            bash -c "
                line={2};
                file={1};
                start=\$(( line-20<1 ? 1 : line-20 ));
                bat --style=numbers \
                    --color=always \
                    --highlight-line \$line --line-range \$start: \$file"' \
        --preview-window=right:60% \
        | awk -F: '{print $1, $2}'
}

dgrep_fzf() {
    local result
    result=$(crg "$@")
    if [ -z "$result" ]; then
        echo "No match selected"
        return 1
    fi

    local file=$(echo "$result" | awk '{print $1}')
    local line=$(echo "$result" | awk '{print $2}')
    vim +"$line" "$file"
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
function tagsbuild() {
    rm cscope.* 2> /dev/null
    rm tags 2> /dev/null

    fd -t f -a \
      -e c -e h -e cpp -e py -e rs -e mk -e xml -e cfg -e ini \
      . \
      > cscope.files

    echo "Building cscope database..."
    cscope -b -q -k

    echo "Building ctags..."
    ctags --links=no  -L cscope.files \
        --totals=yes  \
        --fields=+l --extras=+q
    echo "Done."
}

# This functions accepts a directory to append its files to the existing cscope.files
# and rebuilds the cscope database and ctags
function append_tags() {
    local dir="$1"
    local new_files
    new_files=$(mktemp)

    if [ -z "$dir" ] || [ ! -d "$dir" ]; then
        echo "Usage: append_tags <directory>"
        return 1
    fi

    if [ ! -f cscope.files ]; then
        echo "cscope.files not found, creating a new one."
        touch cscope.files
    fi

    # Collect candidate files
    fd -t f -a \
      -e c -e h -e cpp -e py -e rs -e mk -e xml -e cfg -e ini \
      . "$dir" \
      > "$new_files"

    cat "${new_files}" >> cscope.files
    sort -u -o cscope.files cscope.files

    echo "Rebuilding cscope database..."
    cscope -b -q -k

    echo "Updating ctags incrementally..."
    ctags --links=no \
          --fields=+l --extras=+q \
          -L "${new_files}" \
          -f tags.new

    # Merge + re-sort tags
    cat tags.new >> tags
    LC_ALL=C sort -u tags -o tags
    rm -f tags.new
    rm -f "$new_files"
    echo "Done."
}

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
