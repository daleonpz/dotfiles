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
PS1="\[$White\]\d - \A \[$BIWhite\][\W]\n\[$BIYellow\][Jobs:\j] \u@\h \[$BIGreen\]\$(parse_git_branch)$ \[$BIBlue\] "

#######################################################
# program exports
#######################################################
export PATH="$PATH:/home/dnl/MATLAB/R2013a/bin"
export PATH="$PATH:/home/dnl/Documents/scripts"
export PATH="/opt/android-build:/opt/jdk1.8.0_25/bin:$PATH"
export EDITOR=vim
export VISUAL="vim"

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
alias addctags='ctags -R .'
alias translate='trans -b'
alias filemanager='cd "$(/bin/vifm --choose-dir - $@)"'
alias fjfirefox='firejail --private --dns=8.8.8.8 --dns=8.8.4.4 firefox -no-remote'

alias diamond_lattice='/home/dnl/diamond_lattice/usr/local/diamond/3.10_x64/bin/lin64/diamond'

#######################################################
# functions
#######################################################
mycal() {
    gcal
    calPath="/home/dnl/Documents/localStuff"
    gcal -u -f $calPath/myown.cal --date-format='%1%Y %<3#U %>02*D, %>3w#K%2' -cdl@t7 --heading-text="Time:_%t__o'clock"   >  /tmp/caltemp

#     sed -e "s/<\(.*\)$/\x1b[01;32m&\x1b[0m/g"   /tmp/caltemp
    sed -e "s/<\(.*\)>/\x1b[01;32mTODAY/g" -e "s/TO\(.*\)$/&\x1b[0m/g"  -e "s/\(.*\!\)$/\x1b[01;31m&\x1b[0m/g" /tmp/caltemp
}


opendocument(){
    zathura "$*" &> /dev/null 
}

browser(){
     firefox &> /dev/null
}

mkcd () {
    mkdir -p "$*"
    cd "$*"
}

pomodoro_break (){
    sleep 25m && xfce4-terminal --fullscreen -x break_reminder.sh countdown "$*"
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



#######################################################
# Exports
#######################################################
# my python scripts
export PATH="$PATH:/home/dnl/Documents/gitStuff/dnl_tools/tools/python"

#for load libraries	
export PATH=/usr/local/bin:$PATH
export PATH=/opt/mpich/bin:$PATH
export PATH=/home/dnl/Documents/toolchains/GNAT/2020-arm-elf/bin:$PATH

export CPATH=/usr/local/include:$CPATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


PATH="/home/dnl/.gem/ruby/2.7.0/bin:$PATH"

