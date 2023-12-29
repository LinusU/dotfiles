################################################################################
#                                                                              #
#  SETUP                                                                       #
#                                                                              #
################################################################################

# Load Brew
eval $(/opt/homebrew/bin/brew shellenv)

# Load Cargo/Rust
. "$HOME/.cargo/env"

# Load Starship
eval "$(starship init zsh)"

################################################################################
#                                                                              #
#  NVM                                                                         #
#                                                                              #
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

################################################################################
#                                                                              #
#  emoji_bump                                                                  #
#                                                                              #
################################################################################

function emoji_bump {
  npm version "$1" -m '🚢 %s'
}

################################################################################
#                                                                              #
#  Load profile                                                                #
#                                                                              #
################################################################################

source ~/.profile
