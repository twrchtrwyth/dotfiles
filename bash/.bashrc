#
# ~/.bashrc
#

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

	alias ls='ls --color=auto'
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

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

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

################
# MY ADDITIONS #
################

# PATH ADDITIONS
export PATH=/home/wil/programs/bin:$PATH

# ALIASES

alias vim='nvim'
# alias fzfp="fzf --preview 'bat --color=always {}'"
alias ripgrep='rg'
alias ..='cd ..'
alias sysinfo='inxi --admin --verbosity=7 --filter --no-host --width'

## GAMES
alias sethian='cd ~/games/sethian/Sethian/; wine Sethian.exe; cd ~'

## SSH
alias oki='ssh -p 9967 wil@oki.nohost.me'
alias akira='ssh osmc@192.168.178.32'
alias pihole='ssh pi@pi-hole.local'

## WORK
alias work='firefox --kiosk https://ntxgateway.luht.scot.nhs.uk/portal/webclient/index.html & disown & exit'
alias rx='cd ~/documents/work/prescribing/'

## PDFs
alias biochem='mupdf ~/documents/books/textbooks/molbiolcell.pdf & disown & exit'
alias pharm="zathura ~/documents/books/textbooks/Rang\ and\ Dale\'s\ Pharmacology\,\ Seventh\ Edition-\ H.\ P.\ Rang.pdf & disown & exit"
alias physics='zathura ~/documents/books/textbooks/David\ Halliday\,\ Robert\ Resnick\,\ Jearl\ Walker\ -\ Fundamentals\ of\ Physics_\ Extended-Wiley\ \(2018\).pdf & disown & exit'
alias medicine='zathura ~/documents/books/Oxford\ Handbook\ of\ Clinical\ Medicine\ \(10th\ Ed\)\(gnv64\).pdf & disown & exit'
alias quantum='zathura ~/documents/books/\(Teach\ Yourself\)\ Alexandre\ Zagoskin\ -\ Quantum\ Theory_\ A\ Complete\ Introduction-Teach\ Yourself\ \(2015\).pdf & disown & exit'
alias orgchem='zathura ~/documents/books/textbooks/John\ McMurry\ -\ Organic\ Chemistry-Cengage\ Learning\ \(2016\).pdf & disown & exit' 
alias funorgchem='zathura ~/documents/books/textbooks/McMurry\,\ John\ -\ Fundamentals\ of\ organic\ chemistry-Brooks_Cole\ \(2011\).pdf & disown & exit' 
alias marine="zathura ~/documents/books/textbooks/J.\ D.\ Fish\,\ S.\ Fish\ -\ A\ Student\'s\ Guide\ to\ the\ Seashore\,\ 3rd\ Edition\ -Cambridge\ University\ Press\ \(2011\).pdf"

# FZF
## Display preview with bat. bat must be installed.
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"
## Use fd instead of find with fzf. fd must be installed.
export FZF_DEFAULT_COMMAND="fd --type f"
## Load default keybindings (Ctrl-T, Alt-C, Ctrl-R)
source /usr/share/fzf/key-bindings.bash

# GROFF
alias gf='cd ~/documents/groff'
## Create a new groff mom chapter document using my template.
chap () {
	cat ~/documents/groff/templates/chapter/chapter_template.mom > "$1".mom && vim "$1".mom
}
## Generate a referenced PDF from groff/mom formatted chapters.
mkrefpdf () {
	touch "$1".mom && rm "$1".mom && cat *.mom > "$1".mom && pdfmom -R "$1".mom > "$1".pdf
}
## Generate a postscript file of a chemical strucure from a specified groff/chem file.
ch () {
	chem "$1" | groffer -p
}
