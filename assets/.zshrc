# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

#ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-history-substring-search zsh-autopair zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/custom/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# -------------------------
# 🔹 Shell Base Config
# -------------------------
autoload -Uz compinit && compinit
fpath=(~/ $fpath)

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history share_history inc_append_history hist_ignore_dups hist_ignore_space

# Bind Ctrl+R for incremental search
bindkey '^R' history-incremental-search-backward

# -------------------------
# 🔹 fzf Config
# -------------------------
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# -------------------------
# 🔹 fzf Catppuccin Mocha Theme
# -------------------------
source ~/.config/fzf/catppuccin-fzf-mocha.sh

# Useful fzf aliases
alias fh='history | fzf --tac'
alias vf='nvim $(fzf)'
alias kf='kill $(ps -ef | fzf --multi | awk "{print \$2}")'
bindkey '^R' fzf-history-widget

# -------------------------
# 🔹 zoxide
# -------------------------
eval "$(zoxide init zsh)"

# -------------------------
# 🔹 starship
# -------------------------
eval "$(starship init zsh)"

# -------------------------
# 🔹 Eza aliases
# -------------------------
alias ls='eza -a --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lla='eza -la --icons --group-directories-first --long --header --git'
alias lt='eza -T --icons --group-directories-first'
alias llt='eza -lT --icons --group-directories-first'

# -------------------------
# 🔹 YAY Yogurt aliases
# -------------------------
alias 'u'='yay -Syu'
alias 's'='yay -Ss'
alias 'i'='yay -S'
alias 'r'='yay -R'

# -------------------------
# 🔹 Pacman Aliases
# -------------------------
alias 'pyu'='sudo pacman -Syu'
alias 'ps'='pacman -Ss'
alias 'pun'=' sudo pacman -Syu --needed'
alias 'pr'='sudo pacman -R'
alias 'prs'='sudo pacman -Rns'

# -------------------------
# 🔹 Folder navigation aliases
# -------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# -------------------------
# 🔹 Git aliases
# -------------------------
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"

# -------------------------
# 🔹 Neovim
# -------------------------
alias n="nvim"

# -------------------------
# 🔹 Bat & Bat-extras
# -------------------------
# Replace common commands with bat variants
alias cat='bat'
alias grep='batgrep'
alias diff='batdiff'
alias watchlog='batwatch'
alias man='batman'

# -------------------------
# 🔹 Yazi
# -------------------------

alias 'y'='yazi'

# -------------------------
# 🔹 Quit Terminal
# -------------------------
alias ':q'="exit"
alias ';q'="exit"
alias ':qw'='exit'
alias ':wq'='exit'

# -------------------------
# 🔹 Web App
# -------------------------

alias 'pwa'="install-webapp"

# Handy wrapper
b() {
  if [[ $# -gt 1 ]]; then
    bat --style=numbers "$@"
  else
    bat "$@"
  fi
}

# -------------------------
# 🔹 cd multi-level function
# -------------------------
cdn() {
  local count=$1
  if [[ -z "$count" || ! "$count" =~ '^[0-9]+$' ]]; then
    echo "Usage: cdn <num>"
    return 1
  fi
  local path=""
  for ((i=0; i<count; i++)); do
    path+="../"
  done
  cd "$path" || return
}

# -------------------------
# 🔹 Fastfetch (optional)
# -------------------------
fastfetch -c $HOME/.config/fastfetch/ascii-art.jsonc


export PATH="$HOME/.local/bin:$PATH"
