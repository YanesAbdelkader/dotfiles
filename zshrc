# -------------------------------------
# Ultra-Fast Zsh Config
# -------------------------------------

# -------------------------------------
# NVM Lazy Loading
# -------------------------------------
export NVM_DIR="$HOME/.nvm"

_lazy_nvm_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

for cmd in nvm node npm npx; do
  eval "$cmd() { _lazy_nvm_load; $cmd \"\$@\" }"
done

# Composer
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# -------------------------------------
# Powerlevel10k Instant Prompt
# -------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------
# Zinit
# -------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Core prompt fast
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Syntax, autosuggest, completions (deferred)
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# OMZ Snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit ice wait lucid; zinit snippet OMZP::command-not-found

# Kubernetes & AWS only if installed
(( $+commands[kubectl] )) && zinit ice wait lucid && zinit snippet OMZP::kubectl
(( $+commands[kubectx] )) && zinit ice wait lucid && zinit snippet OMZP::kubectx
(( $+commands[aws] )) && zinit ice wait lucid && zinit snippet OMZP::aws

# Faster compinit
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

zinit cdreplay -q

# -------------------------------------
# Prompt
# -------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -------------------------------------
# Keybindings
# -------------------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# -------------------------------------
# History
# -------------------------------------
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE

setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_ignore_dups
setopt hist_save_no_dups hist_find_no_dups
setopt extended_history

# -------------------------------------
# Completion Styles
# -------------------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -------------------------------------
# Aliases (Arch optimized)
# -------------------------------------
alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'
# For Pacman
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias clean='sudo pacman -Sc'
alias fclean='sudo pacman -Scc'
# For Yay
alias up='yay -Syu'
alias get='yay -S'
alias see='yay -Ss'
alias cl='yay -Sc'
alias fcl='yay -Scc'
# For Git
alias gi='git init'
alias gc='git commit -m'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'
alias clone='git clone'
# For DEV
alias dev='cd ~/Code'

# -------------------------------------
# Integrations
# -------------------------------------
eval "$(zoxide init zsh --cmd cd)"

if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
