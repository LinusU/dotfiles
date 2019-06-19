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

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0

  # Checks if working tree is dirty
  if [[ -n "$(command git status --porcelain --ignore-submodules=dirty 2> /dev/null | tail -n1)" ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_DIRTY$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_CLEAN$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

################################################################################
#                                                                              #
#  SETUP                                                                       #
#                                                                              #
################################################################################

# Load colors support
autoload -U colors && colors

# Notify Terminal.app of the cwd
precmd_functions+=(update_terminalapp_cwd)
update_terminalapp_cwd

# Configure prompt
setopt prompt_subst
PS1="%n@%m:%~%# "

################################################################################
#                                                                              #
#  THEME                                                                       #
#                                                                              #
################################################################################

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

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
