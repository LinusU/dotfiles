################################################################################
#                                                                              #
#  FUNCTIONS                                                                   #
#                                                                              #
################################################################################

# Encodes a string using RFC 2396 URL-encoding (%-escaped).
function urlencode() {
  setopt local_options extended_glob no_multibyte

  input=( ${(s::)1} )
  print ${(j::)input/(#b)([^A-Za-z0-9;\/?:@&=+\$,_.\!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
}

# Emits the control sequence to notify Terminal.app of the cwd
# Identifies the directory using a file: URI scheme, including
# the host name to disambiguate local vs. remote paths.
function update_terminalapp_cwd() {
  # Percent-encode the pathname.
  local URL_PATH="$(urlencode $PWD)"
  [[ $? != 0 ]] && return 1

  # Undocumented Terminal.app-specific control sequence
  printf '\e]7;%s\a' "file://$HOST$URL_PATH"
}

################################################################################
#                                                                              #
#  SETUP                                                                       #
#                                                                              #
################################################################################

# Notify Terminal.app of the cwd
precmd_functions+=(update_terminalapp_cwd)
update_terminalapp_cwd

# Load Starship
eval "$(starship init zsh)"

################################################################################
#                                                                              #
#  NVM                                                                         #
#                                                                              #
################################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

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
