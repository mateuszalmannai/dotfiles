set -o emacs
#set -o vi
# set vi color scheme
# bashrc and bash_profile got the color variables from a website 

# Color Variables for Prompt
GRAD1='\333\262\261\260'
GRAD2='\260\261\262\333'
YLOBRN='\[\033[01;33;43m\]'
WHTBRN='\[\033[01;37;43m\]'
REDBRN='\[\033[01;31;43m\]'
BLUBRN='\[\033[01;34;43m\]'
GRNBRN='\[\033[00;32;43m\]'
REDBLK='\[\033[00;31;40m\]'
PPLBLK='\[\033[01;35;40m\]'
WHTBLK='\[\033[01;37;40m\]'
NONE='\[\033[00m\]'
HBLK='\[\033[00;30;30m\]'
HBLU='\[\033[01;34;34m\]'
BLU='\[\033[01;34m\]'
YEL='\[\033[01;33m\]'
WHT='\[\033[01;37m\]'
PRPL='\[\033[00;35m\]'
RED='\[\033[01;31m\]'
GRN='\[\033[01;32m\]'          
GRAY='\[\033[01;30m\]'
PINK='\[\033[01;35m\]'
NORM='\[\033[01;00;0m\]'
CYAN='\[\033[01;36m\]'

export GRAD1 GRAD2 YLOBRN WHTBRN REDBRN BLUBRN GRNBRN REDBLK PPLBLK WHTBLK NONE HBLK HBLU BLU YEL WHT PRPL RED GRN GRAY PINK NORM CYAN

# root's prompt
#PS1='\n\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\][\w]\[\e[m\] \[\e[0;31m\]\n\!\$ \[\e[m\]\[\e[0;32m\]'
# what I use for normal users 
#PS1="\n$YEL[\t] $GRN\u$YEL@$BLU\h $GRN[\w]\n$BLU\!\$$GRN $WHT"
# The first \n in PS1 makes a leading blank line, and the second \n
# separates the two lines of text. The final \$ outputs $ for non-
# superusers or # if you are root.

# aliases
#alias ls='ls -aF --color=always'
#alias ls='ls -F --color=always'
#alias ll='ls -l | more'
#alias scheckinstall="sudo /usr/sbin/checkinstall"
#alias sipkg="sudo /sbin/installpkg"
#alias srmpkg="sudo /sbin/removepkg"
#alias spkgtool="sudo /sbin/pkgtool"
#alias schkrootkit="sudo /root/chkrootkit-0.43/chkrootkit"
#alias srkhunter="sudo /usr/local/bin/rkhunter -c --skip-keypress"
#alias t='task'
#alias salt=' < /dev/urandom tr -dc a-zA-Z0-9_¬!£$%^\&*\(\)+={}[]:@~\"#,\`./\<\>?\\| fold -w 8 | head -n 1'
#alias dice=' < /dev/urandom tr -dc 1-6|fold -w 1| head -n 1'
#task
#source /etc/bash_completion


# Compress the cd, ls series of commands and cater for the most common typo
function cl (){
cd $1;
ls -F --color=always
}
alias lc="cl"
function cs () {
clear
# only change directory if a directory is specified
[ -n "${1}" ] && cd $1
# filesystem stats
echo "`df -hT .`"
echo ""
echo -n "[`pwd`:"
# count files
echo -n " <`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
# count sub-directories
echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
# count links
echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
# total disk space used by this directory and all subdirectories
echo " <~`du -sh . 2> /dev/null | cut -f1`>]"
ROWS=`stty size | cut -d' ' -f1`
FILES=`find . -maxdepth 1 -mindepth 1 |
wc -l | tr -d '[:space:]'`
# if the terminal has enough lines, do a long listing
if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
ls -ACF
else
ls -hlAF --full-time
fi
}

# Better cd command from O'reilly Bash Cookbook
# Allow use of 'cd ...' to cd up 2 levels, 'cd ....' up 3, etc. (like 4NT/4DOS)
# Usage: cd ..., etc.
function cd {

local option= length= count= cdpath= i= # local scope and start clean 

# if we have a -L or -P sym link option, save then remove it 
if [ "$1" = "-P" -o "$1" = "-L" ]; then 
option="$1"
shift
fi

# Are we using the special syntax? Make sure $1 isn't empty, then 
# match the first 3 characters of $1 to see if they are '...' then
# make sure there isn't a slash by trying a substitution; if it fails,
# there's no slash. Both of these string routines require Bash 2.0+
if [ -n "$1" -a "${1:0:3}" = '...' -a "$1" = "${1%/*}" ]; then
# We are using special syntax
length=${#1}	# Assume that $1 has nothing but dots and count them
count=2 # 'cd ..' still means up one level, so ignore the first two

# While we haven't run out of dots, keep cd'ing up 1 level 
for ((i=$count;i<=$length;i++)); do 
cdpath="${cdpath}../"	# Build the cd path
done

# Actually do the cd
builtin cd $option "$cdpath"
elif [ -n "$1" ]; then
# We are NOT using special syntax; just plain old cd by itself
builtin cd $option "$*"
else
# We are NOT using special syntax; plain old cd by itself to home dir
builtin cd $option
fi
} # end of cd

# mkdir newdir then cd into it from O'reilly Bash Cookbook
# usage: mkcd (<mode>) <dir>
function mkcd {                  
local newdir='_mkcd_command_failed_'
if [ -d "$1" ]; then # Dir exists, mention that...
echo "$1 exists..."    
newdir="$1"             
else
if [ -n "$2" ]; then 	# We've specified a mode
command mkdir -p -m $1 "$2" && newdir="$2"
else # Plain old mkdir
command mkdir -p "$1" && newdir="$1"
fi                      
fi
builtin cd "$newdir"	# No matter what, cd into it
} # end of mkcd


# History 
# A new shell gets the history lines from all the previous shells
shopt -s histappend #Make bash append rather than overwrite the history on disk
PROMPT_COMMAND='history -a' #Whenever displaying the prompt, write the previous line to disk
HISTFILESIZE=1000000000
HISTSIZE=1000000
#Filter what gets stored in command history by setting environment variable, $HISTIGNORE
# The special pattern '&' suppresses duplicate entries
# Including "[ \t]*" in the HISTIGNORE string, you can suppress history recording at will for any given command just by starting with a space!
# export HISTIGNORE="[ \t]*:&:ls:cl:[bf]g:exit"
# to ananlyze the frequency of typed in commands:
# cut -f1 -d" " .bash_history | sort | uniq -c | sort -nr | head -n 30
# Chance are anything in at least the top ten, could do with being aliased 

export EDITOR='vim'
export INPUTRC=$HOME/.inputrc
# make bash autocomplete with left and right arrows
bind '"\e[C":history-search-backward'
bind '"\e[D":history-search-forward'

# make shift+tab cycle through commands instead of listing (not working yet)
# bind '"\t\e[Z":menu-complete' 

# path stuff
PATH=$HOME/Scripts:$HOME/Documents/mongodb/bin:$HOME/Documents/visualvm_136/bin:/usr/local/mysql/bin:$PATH

source ~/.bash/git-prompt
# export PS1="\u@\h:\w\$(parse_git_branch) $ "
# export PS1="\[\e[1m\]________________________________________________________________________________\n\[\e[1;30;47m\]| \W @ \h (\u) \n| => \[\e[0m\]"
# export PS1="\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch) $ "
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  export PS1="\n$WHITE[\t]$GREEN \u@\h\[\033[00m\]:$BLUE\w\[\033[00m\] $RED\$(parse_git_branch)\[\033[00m\]___________________________________________ \n$ "
}
prompt
