#
# ~/.bashrc
#

source /usr/share/doc/pkgfile/command-not-found.bash

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto --group-directories-first'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias mv='mv -i'													# confirm before overwriting
alias rm='rm -i'													# confirm before deletion
xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
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


# --------- CUSTOM ALIASES ---------

# GAMES

# Cogmind
alias cogmind='cd ~/Games/COGMIND\ \(Beta\ 10.2\); wine COGMIND.exe'
# Malleus Goblinficarium
alias mg='cd ~/Games/malleus-goblinficarium; wine Malleus\ Goblinficarium.exe'
# Hylics
alias hylics='cd ~/Games/Hylics; wine Game.exe'
# Sengoku
alias sengoku='cd ~/.wine/dosdevices/c:/GOG\ Games/Sengoku; wine SengokuGame.exe'
# Spelunky
alias spelunky='cd ~/.wine/dosdevices/c:/GOG\ Games/Spelunky; wine Spelunky.exe'
# Donsol
alias donsol='cd ~/Games/donsol-js-master; npm start'
# Sethian
alias sethian='cd ~/Games/Sethian; wine Sethian.exe'
# PICO-8
alias pico8='cd ~/pico-8; ./pico8'
# Brogue
alias brogue='cd ~/Games/Brogue-windows-v1.7.5; wine brogue.exe'
# Sanctuary RPG
alias sanctuaryrpg='cd ~/.wine/drive_c/Program\ Files\ \(x86\)/Black\ Shell\ Games/SanctuaryRPG; wine SanctuaryRPG.exe' 
# SpaceChem
alias spacechem='cd ~/Games/SpaceChem; ./start.sh'
# Cinco Paus
alias cincopaus='cd ~/Games/Cinco-Paus; wine Cinco\ Paus.exe'
# Ultima Ratio Regum 0.8
alias urr='cd ~/Games/ultima-ratio-regum-0.8; wine URR080.exe'

# APPLICATIONS
# Reddit command line
alias reddit='ttrv'
# Spotify command line
alias spotify='spt'
# Anaconda-navigator
alias jupyter='anaconda-navigator'  # Because I can never bloody remember the proper command.

# SSH
# SSH Status
alias ssh-status='sudo systemctl status sshd.service'
# Enable SSH
alias ssh-enable='sudo systemctl enable sshd.service'
# Start SSH
alias ssh-start='sudo systemctl start sshd.service'
# Disable SSH
alias ssh-disable='sudo systemctl disable sshd.service'
# Stop SSH
alias ssh-stop='sudo systemctl stop sshd.service'
# Print SSH commands
alias ssh-alias='less .bashrc | grep ssh'
# SSH to Raspberry Pi
alias ssh-pi='ssh pi@192.168.1.75 -p 9973'

# TIME/DATE
alias time='date'

# PASS
# Pass git push
alias pass-sync='pass git push -u --all'

# COVID-CLI
alias covid='curl -L covid19.trackercli.com/uk'

# PACMAN
# Clear cache except last 3 package versions
alias pacman-clear-cache='paccache -rvk3'
alias pacman-list='pacman -Ql'

# RIPGREP
alias ripgrep='rg'  # Because I can never bloody remember it otherwise

# VIM-like quit (because I keep doing it!)
alias ':q'='exit'
alias ':Q'='exit'

# VIMRC BACKUP
alias vb='cd ~/.vim; cp -f vimrc ~/vimrc_backup; cd ~'
alias extra_vb='cd ~/vimrc_backup; cp vimrc backup_of_backup; cd ~'

# DOTFILES
alias bashrc='cd ~; vim .bashrc'
alias vimrc='cd ~/.vim; vim vimrc; cd ~'

# BATTERY
alias battery='echo "9 cell battery:"; upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage; echo "Slice battery:"; upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage'


# -------- CUSTOM ALIASES END -------- #


# ADDITIONS TO $PATH

# EPR eBook Reader
export PATH=/home/wil/epr:$PATH

# Required for Jekyll
export PATH=/home/wil/.gem/ruby/2.7.0/bin:$PATH

# Automatically start Anaconda python environment. Needed for OU data analysis course.
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

# __conda_setup="$('/home/wil/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/wil/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/wil/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/wil/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# <<< conda initialize <<<

# Use vi bindings in the shell instead of default emacs bindings.
# Handed by .inputrc file instead.
# set -o vi
. "$HOME/.cargo/env"
