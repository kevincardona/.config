# zmodload zsh/zprof # profiling
# if [ "$TMUX" = "" ]; then tmux; fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export PATH=/opt/homebrew/bin:$PATH

# robbyrussell, af-magic
ZSH_THEME="af-magic"
DISABLE_UPDATE_PROMPT=true

# Custom Theme
# PROMPT='%{$fg[green]%}%~%{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%} '
#
# ZSH_THEME_GIT_PROMPT_PREFIX="("
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"
# ZSH_THEME_GIT_PROMPT_DIRTY=" ✗"
# ZSH_THEME_GIT_PROMPT_CLEAN=" ✔"

# plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	rvm
	emoji
)

source $ZSH/oh-my-zsh.sh

# keybindings
bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

# aliases
alias darkmode="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
alias python="python3"
alias vim="nvim"
alias mux="tmuxinator"
alias ms="mux start"
alias mn="mux new"
alias mf='tmuxinator list | sed 1d | awk '\''{for(i=1;i<=NF;i++) if($i ~ /^[[:alnum:]_\-]+$/) print $i}'\'' | fzf --height 40% --border rounded | xargs tmuxinator start'
alias ta='tmux a'
alias vsc="cd ~/.config/scripts && python vsc.py"
alias log-sf-test='stern --context sf-test'
alias log-au-test='stern --context au-test'
alias del='trash'
alias spt='spotify_player'
alias bers="bundle exec rails s"
alias lg="lazygit"
alias dl="trash"

# functions
# mf() {
#   local initial_query="$1"
#   tmuxinator list | sed 1d | awk '{for(i=1;i<=NF;i++) if($i ~ /^[[:alnum:]_\-]+$/) print $i}' | fzf --height 40% --border rounded --query="$initial_query" | xargs tmuxinator start
# }
ccd() {
    local selected=$(find ~ ~/projects ~/.config ~/work ~/work/valert ~/work/telekit ~/work/racc ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)

    if [[ -z $selected ]]; then
        echo "No directory selected."
        return 1
    fi

    # Change to the selected directory
    cd "$selected" || return

    # If inside tmux, update the current pane's directory
    if [[ -n $TMUX ]]; then
        tmux send-keys "cd $selected" C-m
    fi
}

menubar() {
    currentState=$(defaults read NSGlobalDomain _HIHideMenuBar)
    if [ "$currentState" -eq 1 ]; then
        defaults write NSGlobalDomain _HIHideMenuBar -bool false
    else
        defaults write NSGlobalDomain _HIHideMenuBar -bool true
    fi
    killall Finder
}

gcobr() {
    git checkout -b $1/RACCWEB-$2
}


tmuxfzf() {
  local initial_query="$1"
  # Get the list of projects, excluding the first line
  local projects=$(tmuxinator list | sed 1d | awk '{for(i=1;i<=NF;i++) if($i ~ /^[[:alnum:]_\-]+$/) print $i}')
  
  # Filter projects based on the initial query, if provided
  local filtered_projects=""
  if [[ -n "$initial_query" ]]; then
    filtered_projects=$(echo "$projects" | grep -i "$initial_query")
  else
    filtered_projects="$projects"
  fi

  # Count the number of matching projects
  local count=$(echo "$filtered_projects" | wc -l | xargs)
  
  # If exactly one match is found, start it directly
  if [ "$count" -eq 1 ]; then
    tmuxinator start "$(echo "$filtered_projects")"
  else
    # Otherwise, use fzf to select the project
    echo "$filtered_projects" | fzf --height 40% --border rounded --query="$initial_query" | xargs tmuxinator start
  fi
}



# plugins
zstyle ':omz:plugins:rvm' lazy yes

# dependencies
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH=$(pyenv root)/shims:$PATH

# NVM Configuration
# lazy_nvm() {
#     unset -f nvm node npm npx
#     export NVM_DIR="$HOME/.nvm"
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#     nvm "$@"
#     export PATH="`yarn global bin`:$PATH"
# }
# nvm() { lazy_nvm; }
# node() { lazy_nvm; }
# npm() { lazy_nvm; }
# npx() { lazy_nvm; }
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
# alias node='unalias node ; unalias npm ; nvm use default ; node $@'
# alias npm='unalias node ; unalias npm ; nvm use default ; npm $@'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -s "/Users/kcardona/.bun/_bun" ] && source "/Users/kcardona/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export JAVA_HOME=/opt/homebrew/opt/openjdk@11
export PATH=$HOME/development/sdks/flutter/bin:$PATH 

export PATH=$HOME/.gem/bin:$PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/kcardona/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# add local scripts to path
export PATH="$HOME/.config/bin/.local/scripts:$PATH"

# zprof # profiling - end
