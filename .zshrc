# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="miloshadzic"

# Add vim as default editor
export EDITOR=vim

# archbey -c white

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-z1sh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(archlinux git sublime ruby rails3 gem rake github heroku rbenv redis-cli vi-mode screen task-warrior)

source $ZSH/oh-my-zsh.sh

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}

# Aliases / functions
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }  
# Copy SSH public key
alias cbssh="cat ~/.ssh/id_rsa.pub | cb"
# Copy current working directory
alias cbwd="pwd | cb"  
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 2 | sed -n 1p | sed -r 's/^:.{0,14};//' | cb"

# Color output shortcuts
alias grep='grep -n --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias l='ls -la --color=auto'
eval $(dircolors -b)

# Rdesktop shortcuts
alias mars='rdesktop -g 1440x900 -P -z -x l -d main -u administrator -p - mars.main.emyth.com'
alias mercury='rdesktop -g 1440x900 -P -z -x l -d main -u administrator -p - mercury.main.emyth.com'
alias jupiter='rdesktop -g 1440x900 -P -z -x l -d main -u administrator -p - jupiter.main.emyth.com'
alias emanager='rdesktop -g 1440x900 -P -z -x l -d main -u administrator -p - 192.168.0.9'

# Other aliases
alias reflect='sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist'
alias config='git --git-dir=/home/luke/.config.git/ --work-tree=/home/luke'

# Keybinds
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# Other customizations
# ------------------------------------------------
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl
export PATH="$HOME/.rbenv/bin:$PATH"
export LESS="-R"
eval "$(rbenv init -)"

