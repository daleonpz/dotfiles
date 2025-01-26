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

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fehslides='feh -r -F -V -d -Z'
alias smartsnips='SmartSnippets_Studio &> /dev/null'

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

#########################################################3
# Reset
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
# program exports
#######################################################
export EDITOR=vim
export VISUAL="vim"
export SUDO_EDITOR=/usr/bin/vim

#######################################################
# alias
#######################################################
alias apagar='sudo shutdown -P now' 
alias setvolume='amixer set Master'
alias matlab_terminal='matlab -nodesktop'
alias rmdir='rm -rf'
alias gccWg='gcc -W -Wall -g3'
alias valgdb='valgrind --vgdb-error=0'
alias execjekyll='bundle exec jekyll serve'
alias pdb2.7='python2.7 -m pdb'
valpyPath="/home/dnl/Documents/gitStuff/Python-2.7.3"
alias valgrindpy='valgrind --suppressions=$valpyPath/Misc/valgrind-python.supp $valpyPath/bin/python2.7'
alias ctagsbuild='ctags -R .'
alias translate='trans -b'
alias filemanager='cd "$(/bin/vifm --choose-dir - $@)"'
alias fjfirefox='firejail --seccomp --private --dns=8.8.8.8 --dns=8.8.4.4 firefox -no-remote'
alias diamond_lattice='/home/dnl/diamond_lattice/usr/local/diamond/3.10_x64/bin/lin64/diamond'


#######################################################
# functions
#######################################################
# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

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

makepdfdir(){
    
    if [ -z "$1" ] 
    then
        echo "usage: "
        echo "        makepdfdir DOCTITLE [optional:FILENAME]"
        return 0
    fi

    if [ "$2" ]
    then
        filename=$2
    else
        filename="notes.pdf"
    fi

    notes=$(find . -name '*.md' -exec echo {} \; | sort)
    echo "The following notes were found"
    echo $notes
    echo "Generating pdf..."
    pandoc --toc -s \
                -V toc-title:"Table of Contents"  \
                -V documentclass=report \
                -V title:$1 \
                $notes  -o $filename
   echo "Done: "$filename
}


# fzf autocompletion aktivieren
if [ -x "$(command -v fzf)"  ]
then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

#######################################################
# Exports
#######################################################

#for load libraries	
export PATH=/usr/local/bin:$PATH
export PATH=/opt/mpich/bin:$PATH
export PATH=/usr/gnat-elf/bin:$PATH
# export PATH=/usr/gnat/bin:$PATH

export CPATH=/usr/local/include:$CPATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

dpick() {
    local args=($(pick "$1" "$(ret)") )
    vim "${args[@]}"
}

dgrep() {
    cgrep "$@" | cap
}


#######################################################
# cscope 
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
alias pman='postman &> /dev/null'
alias strail='sourcetrail &> /dev/null'
#######################################################
# Embedded related aliases 
#######################################################
alias pimpmake='make all | ccze -A'


alias get_idf='. /home/dnl/Documents/git/esp-idf/export.sh'
export CPPUTEST_HOME=~/tools/cpputest


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export WORKON_HOME=$HOME/.virtualenvs   # Optional
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
# source /home/dnl/.local/bin/virtualenvwrapper.sh

export PROMPT_COMMAND='history -a; history -r'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# source /usr/share/nvm/init-nvm.sh

export STM32_PRG_PATH=/home/dnl/STM32Cube/STM32CubeProgrammer/bin

export PATH=$PATH:/opt/mssql-tools/bin
export PATH=$PATH:/home/dnl/.gem/ruby/3.0.0/bin
export PATH=$PATH:/home/dnl/.gem/ruby/2.7.0/bin
export PATH=$PATH:/home/dnl/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:/home/dnl/.scripts/
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/st/stm32cubeide_1.8.0
export PATH=$PATH:/home/dnl/.local/share/gem/ruby/3.2.0/bin
export PATH=$PATH:/home/dnl/Download/JLink_Linux_V794e_x86_64
