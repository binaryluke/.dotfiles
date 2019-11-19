#!/usr/bin/env bash

main() {
  ask_for_sudo
  install_xcode_command_line_tools # next step requires "git" installed with xcode
  clone_dotfiles_repo
  install_homebrew
  install_packages_with_brewfile
  change_shell_to_latest_bash
  setup_symlinks
  setup_vim
  setup_tmux
  setup_yabai
  setup_macos_system_preferences
  setup_macos_application_preferences
  setup_macos_login_items
}

DOTFILES_REPO=~/dotfiles

# Credit: https://github.com/sam-hosseini/dotfiles/blob/92cdd34570629fdb6d3e94865ba6b8bedd99dbe8/bootstrap.sh#L23
function ask_for_sudo {
  echo "Prompting for sudo password"
  if sudo --validate; then
    # Keep-alive
    while true; do sudo --non-interactive true; \
      sleep 10; kill -0 "$$" || exit; done 2>/dev/null &
    echo "Sudo password updated"
  else
      echo "Sudo password update failed"
      exit 1
  fi
}

# Credit: https://github.com/sam-hosseini/dotfiles/blob/92cdd34570629fdb6d3e94865ba6b8bedd99dbe8/bootstrap.sh#L35
function install_xcode_command_line_tools {
  echo "Installing Xcode command line tools"
  if softwareupdate --history | grep --silent "Command Line Tools"; then
    echo "Xcode command line tools already exists"
  else
    xcode-select --install
    read -n 1 -s -r -p "Press any key once installation is complete"

    if softwareupdate --history | grep --silent "Command Line Tools"; then
      echo "Xcode command line tools installation succeeded"
    else
      echo "Xcode command line tools installation failed"
      exit 1
    fi
  fi
}

# Credit: https://github.com/sam-hosseini/dotfiles/blob/92cdd34570629fdb6d3e94865ba6b8bedd99dbe8/bootstrap.sh#L173
function clone_dotfiles_repo {
  echo "Cloning dotfiles repository into ${DOTFILES_REPO}"
  if test -e $DOTFILES_REPO; then
    echo "${DOTFILES_REPO} already exists"
    pull_latest_in_dotfiles_repo $DOTFILES_REPO
    echo "Pull successful in ${DOTFILES_REPO} repository"
  else
    url=https://github.com/binaryluke/dotfiles.git
    if git clone "$url" $DOTFILES_REPO && \
      git -C $DOTFILES_REPO remote set-url origin git@github.com:binaryluke/dotfiles.git; then
        echo "Dotfiles repository cloned into ${DOTFILES_REPO}"
    else
        echo "Dotfiles repository cloning failed"
        exit 1
    fi
  fi
}

function pull_latest_in_dotfiles_repo {
  echo "Pulling latest changes in ${1} repository"
  if git -C $1 pull origin master &> /dev/null; then
    return
  else
    error "Please pull latest changes in ${1} repository manually"
  fi
}

# Credit: https://github.com/sam-hosseini/dotfiles/blob/92cdd34570629fdb6d3e94865ba6b8bedd99dbe8/bootstrap.sh#L52
function install_homebrew {
  echo "Installing Homebrew"
  if hash brew 2>/dev/null; then
    echo "Homebrew already exists"
  else
    url=https://raw.githubusercontent.com/Homebrew/install/master/install
    if yes | /usr/bin/ruby -e "$(curl -fsSL ${url})"; then
      echo "Homebrew installation succeeded"
    else
      echo "Homebrew installation failed"
      exit 1
    fi
  fi
}

function install_packages_with_brewfile {
  echo "Installing Brewfile packages"

  BREWFILE=${DOTFILES_REPO}/Brewfile

  if brew bundle check --file="$BREWFILE" &> /dev/null; then
    echo "Brewfile packages already installed"
  else
    if brew bundle --file="$BREWFILE"; then
      echo "Brewfile packages installation succeeded"
    else
      echo "Brewfile packages installation failed"
      exit 1
    fi
  fi
}

function change_shell_to_latest_bash {
  echo "Changing default shell to latest Bash"
  if [ "$SHELL" == "/usr/local/bin/bash" ]; then
    echo "Latest Bash is already the default shell"
  else
    user=$(whoami)
    echo "Adding latest Bash to /etc/shells"
    if grep --fixed-strings --line-regexp --quiet "/usr/local/bin/bash" /etc/shells; then
      echo "Latest Bash already exists in /etc/shells"
    else
      if echo /usr/local/bin/bash | sudo tee -a /etc/shells > /dev/null; then
        echo "Latest Bash successfully added to /etc/shells"
      else
        echo "Failed to add latest Bash to /etc/shells"
        exit 1
      fi 
    fi
    echo "Switching shell to latest Bash for \"${user}\""
    if sudo chsh -s /usr/local/bin/bash "$user"; then
      echo "Latest Bash shell successfully set as default for \"${user}\""
    else
      echo "Failed to set latest Bash as default shell"
    fi 
  fi
}

function setup_symlinks {
  echo "Not yet implemented: setup_symlinks"
}

function setup_vim {
  echo "Not yet implemented: setup_vim"
}

function setup_tmux {
  echo "Not yet implemented: setup_tmux"
}

function setup_yabai {
  echo "Not yet implemented: setup_yabai"
}

function setup_macos_system_preferences {
  echo "Not yet implemented: setup_macos_system_preferences"
}

function setup_macos_application_preferences {
  echo "Not yet implemented: setup_macos_application_preferences"
}

function setup_macos_login_items {
  echo "Not yet implemented: setup_macos_login_items"
}

main "$@"

