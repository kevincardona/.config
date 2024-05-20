# zmodload zsh/zprof # profiling
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export PATH=/opt/homebrew/bin:$PATH

# robbyrussell, af-magic
ZSH_THEME="af-magic"
DISABLE_UPDATE_PROMPT=true

# plugins
plugins=(
	git
	zsh-autosuggestions
        zsh-completions
	zsh-syntax-highlighting
	emoji
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# keybindings
bindkey -e
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

# functions
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

# Function to open JIRA ticket from the branch name
ticket() {
  # Get the current branch name
  local branch_name=$(git rev-parse --abbrev-ref HEAD)

  # Extract the ticket number (e.g., RACCWEB-18579) from the branch name
  if [[ $branch_name =~ ([A-Z]+-[0-9]+) ]]; then
    local ticket_number=${match[1]}
    # Construct the JIRA URL
    local jira_url="https://vailsys.atlassian.net/browse/$ticket_number"
    # Open the URL in the default web browser
    open $jira_url
  else
    echo "No JIRA ticket number found in the branch name."
  fi
}

lazy_load() {
    local -a names
    if [[ -n "$ZSH_VERSION" ]]; then
        names=("${(@s: :)${1}}")
    else
        names=($1)
    fi
    unalias "${names[@]}"
    . $2
    shift 2
    $*
}

group_lazy_load() {
    local script
    script=$1
    shift 1
    for cmd in "$@"; do
        alias $cmd="lazy_load \"$*\" $script $cmd"
    done
}

# aliases
alias darkmode="osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to not dark mode'"
alias python="python3"
alias vim="nvim"
# alias mux="tmuxinator"
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

# dependencies
export PATH=$(pyenv root)/shims:$PATH

# NVM Configuration
lazy_load_nvm() {
  unset -f node nvm
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  node $@
}


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

# You may need to add this to your ~/.zshrc file to make sure that the PATH is set correctly
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to path for scripting (to manage Ruby versions)
# export PATH="$GEM_HOME/bin:$PATH"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*

# zprof # profiling - end
