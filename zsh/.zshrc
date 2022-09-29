path+=("$HOME/scripts")
path+=("/usr/local/opt/mysql-client/bin") # mysql client
path+=("/usr/local/sbin") # Add brew lib to path (WTF? this is the sudo bin folder...)
typeset -U path

# Export iCloud drive path variable
export ICLOUD="$HOME/Library/Mobile\ Documents/com~apple~CloudDocs"

# Add to keychain quietly (why does nobody else need this in their dotfiles?)
# ssh-add -K &> /dev/null

# Aliases
alias vim="nvim"
alias gst="git status"
alias gd="git diff"
alias gc="git commit"
alias gcl="git clone"
alias ga="git add"
alias gp="git push"
alias gst="git status"
alias glg="git log"
alias gdca="git diff --cached"
alias gco="git checkout"
alias gb="git branch"
alias gm="git merge"
alias g="git"

# Lazyload Node.js - NVM and npm
# Credit: https://github.com/ryanhanwu/dotfiles/blob/master/.zshrc#L79
lazynvm() {
  unset -f nvm node npm
  export NVM_DIR=~/.nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm use default
}

nvm() {
  lazynvm
  nvm $@
}

node() {
  lazynvm
  node $@
}

npm() {
  lazynvm
  npm $@
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

