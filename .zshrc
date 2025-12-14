# -------------------------------------------------
# Zsh Config
# -------------------------------------------------

# -----------------------------
# NVM Lazy Loading
# -----------------------------
export NVM_DIR="$HOME/.nvm"

_lazy_nvm_load() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

for cmd in nvm node npm npx; do
  eval "$cmd() { _lazy_nvm_load; $cmd \"\$@\" }"
done

# Composer global binaries
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# -----------------------------
# Powerlevel10k Instant Prompt
# -----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------
# Zinit
# -----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Syntax + completion + autosuggest + fzf-tab
zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# Useful OMZ snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::systemd

# Enable AWS/Kubernetes only if installed
(( $+commands[kubectl] ))  && zinit ice wait lucid && zinit snippet OMZP::kubectl
(( $+commands[kubectx] )) && zinit ice wait lucid && zinit snippet OMZP::kubectx
(( $+commands[aws] ))      && zinit ice wait lucid && zinit snippet OMZP::aws

# Faster compinit
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

zinit cdreplay -q

# -----------------------------
# Prompt
# -----------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------
# Keybindings
# -----------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# -----------------------------
# History
# -----------------------------
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE

setopt appendhistory sharehistory
setopt hist_ignore_space hist_ignore_all_dups hist_ignore_dups
setopt hist_save_no_dups hist_find_no_dups
setopt extended_history

# -----------------------------
# Completion Styles
# -----------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -----------------------------
# Aliases
# -----------------------------
alias ls='ls --color=auto'
alias vim='nvim'
alias c='clear'
alias info='fastfetch'

# DNF
alias update='sudo dnf upgrade --refresh'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias search='dnf search'
alias clean='sudo dnf clean all'

# Git
alias gi='git init'
alias gcm='git commit -m'
alias gst='git status'
alias gph='git push'
alias gpl='git pull'
alias clone='git clone'

# Dev
alias dev='cd ~/Code'

# -----------------------------
# Integrations
# -----------------------------
eval "$(zoxide init zsh --cmd cd)"

if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

(cat ~/.cache/wal/sequences &)