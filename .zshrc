#
# ~/.zshrc
#

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500
#export EDITOR=/usr/bin/vim
#export VISUAL=/usr/bin/vim
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word


## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                     # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gitu='git add . && git commit && git push'
alias ls='ls --color=auto --group-directories-first'            # Automatically colour results, and order.
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias mv='mv -i'													# confirm before overwriting
alias rm='rm -i'													# confirm before deletion

####################################
# --------- CUSTOM ALIASES ---------
####################################

# Launch the OU data analysis course and open the associated Jupyter notebooks.
alias datacourse='python ~/python/load_ou_course.py'

# UNMOUNT
# Because... Come on
alias unmount='umount'

# DICTIONARY
alias def='sdcv --color'

# VIM
alias vim='nvim'

# HON
alias hon='cat ~/hon.md'

# GAMES
# (Yes, it's clunky to cd in and out of the directories, but some of the
# executables wouldn't launch if wine is invoked outside the directory
# within which they're located.)
# Cogmind
alias cogmind='cd ~/Games/COGMIND\ \(Beta\ 10.2\); wine COGMIND.exe; cd ~'
# Malleus Goblinficarium
alias mg='cd ~/Games/malleus-goblinficarium; Malleus\ Goblinficarium.exe; cd ~'
# Hylics
alias hylics='cd ~/Games/Hylics; wine Game.exe; cd ~'
# Sengoku
alias sengoku='cd ~/.wine/drive_c/GOG\ Games/Sengoku; wine SengokuGame.exe; cd ~'
# Spelunky
alias spelunky='cd ~/.wine/drive_c/GOG\ Games/Spelunky; wine Spelunky.exe; cd ~'
# Donsol
alias donsol='cd ~/Games/donsol-js-master; npm start; cd ~'
# Sethian
alias sethian='cd ~/Games/Sethian; wine Sethian.exe; cd ~'
# PICO-8
alias pico-8='~/pico-8/pico8'
# Brogue
alias brogue='cd ~/Games/Brogue-windows-v1.7.5; wine brogue.exe; cd ~'
# Sanctuary RPG
alias sanctuary-rpg='cd ~/.wine/drive_c/Program\ Files\ \(x86\)/Black\ Shell\ Games/SanctuaryRPG; wine SanctuaryRPG.exe; cd~'
# SpaceChem
alias spacechem='~/Games/SpaceChem/start.sh'
# Cinco Paus
alias cinco-paus='cd ~/Games/Cinco-Paus; wine Cinco\ Paus.exe; cd ~'
# Ultima Ratio Regum 0.9
alias urr='cd ~/Games/ultima-ratio-regum; wine URR090c.exe; cd ~'
# Loop Hero
alias loop-hero='~/Games/loop-hero/game/Loop_Hero'
# Dominion Online
alias dom='python ~/python/playground/dominion_online_launcher.py'
# Rift Wizard
alias rift-wizard='python ~/Games/RiftWizard/RiftWizard.py'
alias rw='rift-wizard'
# Return of the Obra Dinn
alias obra-dinn='cd ~/Games/ObraDinn; wine ObraDinn.exe; cd ~'
# Ultima VII
alias ultima='echo "DOSBOX is really buggy so best not try to run this at the moment."'
# Morrowind
alias morrowind='openmw'
# Jumpgrid
alias jumpgrid='cd ~/Games/jumpgrid/; ./jumpgrid; cd ~'
# Factorio
alias factorio='~/Games/factorio/bin/x64/factorio'
# Infra Arcana - doesn't work because of libSDL2 error.
alias ia='~/Games/infra-arcana/ia'
# Into The Breach
alias itb='~/Games/into-the-breach/start.sh'
# Mage Guild
alias mage-guild='wine ~/Games/mage-guild/MageGuild.exe'
# The Temple of Torment
alias ttot='wine ~/Games/TToTd20_Stable190/TheTempleofTorment.exe'
# Tangledeep
alias tangledeep='~/Games/Tangledeep/start.sh'
# Dream Quest
alias dq='cd ~/Games/dream-quest; wine Windows64.exe; cd ~'

# APPLICATIONS
# Reddit command line
alias reddit='ttrv'
# Spotify command line
alias spotify='spt'
alias spotofy='spotify'
# Micro (Text Editor)
alias micro='~/micro'
# GPXSEE
alias gpxsee='~/gpxsee/gpxsee'
alias map='~/gpxsee/gpxsee'

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

# TIME/DATE
alias time='date'

# GETTING WINDOW DIMENSIONS
alias cwd='xdotool getwindowfocus getwindowgeometry'
alias gwd='xdotool selectwindow getwindowgeometry'

# DIRECTORY NAVIGATION
alias ..='cd ..'

# XPROP (WINDOW INFORMATION)
alias window-info='xprop'
alias window-class='xprop | grep WM_CLASS | awk "{print $4}"'

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

# VIM-like quit
alias ':q'='exit'
alias ':Q'='exit'

# GET DIRECTORY SIZE
alias ds='du -ch --max-depth=1 | sort -nr'

# DOTFILES/CONFIG FILES
alias bash-config='vim ~/.bashrc'
alias vim-config='vim ~/.vim/vimrc'
alias zsh-config='vim ~/.zshrc'
alias i3-config='vim ~/.config/i3/config'
alias polybar-config='vim ~/.config/polybar/config'
alias rofi-config='vim ~/.config/rofi/config.rasi'
alias dunst-config='vim ~/.config/dunst/dunstrc'

# BATTERY
alias battery='echo "Main Battery:"; upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage; echo "Slice Battery:"; upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage'
alias battery-info='sudo tlp-stat'

# TARBALLS
alias extar='tar -xvzf'

# FIREFOX CONFIG
alias firefox-config='vim ~/.mozilla/firefox/3pryh7ro.default-release/chrome/userChrome.css'

# GROFF/MOM
alias momdoc='firefox ~/wget/groff-mom/groff-mom-documentation/mom/momdoc/toc.html'

# HELM (SYNTHESISER) MANUAL
alias helm='zathura ~/Documents/helm_manual.pdf & disown'

# FARGE (COLOUR PICKER)
alias colour='farge'

# LINUX NOTES
alias linux='vim ~/Documents/linux/linux_guide.md'

##########################################
# -------- CUSTOM ALIASES END ------------
##########################################

# ADDITIONS TO $PATH

# EPR eBook Reader
export PATH=/home/wil/epr:$PATH

# Required for Jekyll
export PATH=/home/wil/.gem/ruby/2.7.0/bin:$PATH

# For uxn
export PATH=/home/wil/bin:$PATH

# Use vi bindings in the shell instead of default emacs bindings.
# Handed by .inputrc file instead.
# set -o vi


# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# Set vi key mode.
#bindkey -v

#vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
#vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
#vim_mode=$vim_ins_mode

#function zle-keymap-select {
  #vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  #zle reset-prompt
#}
#zle -N zle-keymap-select

#function zle-line-finish {
  #vim_mode=$vim_ins_mode
#}
#zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
# Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
#function TRAPINT() {
  #vim_mode=$vim_ins_mode
  #return $(( 128 + $1 ))
#}

# enable substitution for prompt
setopt prompt_subst

# Prompt (on left side) similar to default bash prompt, or redhat zsh prompt with colors
PROMPT="%(!.%{$fg[red]%}[%4~]%{$reset_color%}# .%{$fg[green]%}[%4~]%{$reset_color%} > "
# Maia prompt
#PROMPT='${vim_mode} %B%{$fg[cyan]%}%(4~|%-1~/.../%2~|%~)%u%b >%{$fg[cyan]%}>%B%(?.%{$fg[cyan]%}.%{$fg[red]%})>%{$reset_color%}%b ' # Print some system information when the shell is first started
# Print a greeting message when shell is started
echo $fg[red]"██████╗  ██████╗ ███╗  ██╗█╗██████╗  ██████╗  █████╗ ███╗  ██╗██╗ ██████╗
██╔══██╗██╔═══██╗████╗ ██║╚╝ ╚██╔═╝  ██╔══██╗██╔══██╗████╗ ██║██║██╔════╝
██║  ██║██║   ██║██╔██╗██║    ██║    ██████╔╝███████║██╔██╗██║██║██║
██║  ██║██║   ██║██║╚████║    ██║    ██╔═══╝ ██╔══██║██║╚████║██║██║
██████╔╝╚██████╔╝██║ ╚███║    ██║    ██║     ██║  ██║██║ ╚███║██║╚██████╗
╚═════╝  ╚═════╝ ╚═╝  ╚══╝    ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚══╝╚═╝ ╚═════╝"$reset_color
echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)
## Prompt on right side:
#  - shows status of git when in git repository (code adapted from https://techanic.net/2011/12/30/my_git_prompt_for_zsh.html)
#  - shows exit status of previous command (if previous command finished with an error)
#  - is invisible, if neither is the case

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"                              # plus/minus     - clean repo
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"             # A"NUM"         - ahead by "NUM" commits
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"           # B"NUM"         - behind by "NUM" commits
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"     # lightning bolt - merge conflict
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"       # red circle     - untracked files
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"     # yellow circle  - tracked files modified
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"        # green circle   - staged changes present = ready for "git push"

parse_git_branch() {
  # Show Git branch/tag, or name-rev if on detached head
  ( git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD ) 2> /dev/null
}

parse_git_state() {
  # Show different symbols as appropriate for various Git repository states
  # Compose this value via multiple conditional appends.
  local GIT_STATE=""
  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi
  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi
  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi
  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi
  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi
  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi
  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
  fi
}

git_prompt_string() {
  local git_where="$(parse_git_branch)"

  # If inside a Git repository, print its branch and state
  [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"

  # If not inside the Git repo, print exit codes of last command (only if it failed)
  [ ! -n "$git_where" ] && echo "%{$fg[red]%} %(?..[%?])"
}

# Right prompt with exit status of previous command if not successful
 #RPROMPT="%{$fg[red]%} %(?..[%?])"
# Right prompt with exit status of previous command marked with ✓ or ✗
 #RPROMPT="%(?.%{$fg[green]%}✓ %{$reset_color%}.%{$fg[red]%}✗ %{$reset_color%})"


# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# bind UP and DOWN arrow keys to history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Apply different settigns for different terminals
case $(basename "$(cat "/proc/$PPID/comm")") in
  login)
      RPROMPT="%{$fg[red]%} %(?..[%?])"
      alias x='startx ~/.xinitrc'      # Type name of desired desktop after x, xinitrc is configured for it
    ;;
#  'tmux: server')
#        RPROMPT='$(git_prompt_string)'
#		## Base16 Shell color themes.
#		#possible themes: 3024, apathy, ashes, atelierdune, atelierforest, atelierhearth,
#		#atelierseaside, bespin, brewer, chalk, codeschool, colors, default, eighties,
#		#embers, flat, google, grayscale, greenscreen, harmonic16, isotope, londontube,
#		#marrakesh, mocha, monokai, ocean, paraiso, pop (dark only), railscasts, shapesifter,
#		#solarized, summerfruit, tomorrow, twilight
#		#theme="eighties"
#		#Possible variants: dark and light
#		#shade="dark"
#		#BASE16_SHELL="/usr/share/zsh/scripts/base16-shell/base16-$theme.$shade.sh"
#		#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
#		# Use autosuggestion
#		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#		ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
#  		ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
#     ;;
  *)
        RPROMPT='$(git_prompt_string)'
    # Use autosuggestion
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
    ;;
esac

# Required by pyenv
# eval "$(pyenv init -)"

# Correct zsh help function on Manjaro.
autoload -Uz run-help
(( ${aliases[run-help]} )) && unalias run-help
alias help=run-help
