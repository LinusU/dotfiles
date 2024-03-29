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

# Load Fast Node Manager
eval "$(fnm env)"

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

################################################################################
#                                                                              #
#  Alias                                                                       #
#                                                                              #
################################################################################

alias cat='bat --paging=never --style=plain --theme=ansi'
alias jq='jaq'
alias less='bat --paging=always --style=plain --theme=ansi'
alias ls='eza --all --git --group-directories-first --icons --long'
