# -------------------------
# Fast Zsh Config (Improved)
# -------------------------

# NVM (lazy load for speed)
export NVM_DIR="$HOME/.nvm"
# Only load nvm when used
lazy_nvm() {
  unset -f nvm node npm npx
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
for cmd in nvm node npm npx; do
  eval "$cmd() { lazy_nvm; $cmd \"\$@\" }"
done

# Composer bin path
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Powerlevel10k instant prompt (keep at top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------
# Zinit + Plugins
# -------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Defer heavy plugins with `wait`
zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light Aloxaf/fzf-tab

# Load OMZ snippets on demand
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit ice wait lucid; zinit snippet OMZP::aws
zinit ice wait lucid; zinit snippet OMZP::kubectl
zinit ice wait lucid; zinit snippet OMZP::kubectx
zinit ice wait lucid; zinit snippet OMZP::command-not-found

# Faster compinit (cache)
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

zinit cdreplay -q

# -------------------------
# Prompt
# -------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -------------------------
# Keybindings
# -------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# -------------------------
# History
# -------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# -------------------------
# Completion styling
# -------------------------
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# -------------------------
# Aliases
# -------------------------
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias update='sudo dnf update'
alias upgrade='sudo dnf upgrade'
alias search='sudo dnf search'
alias install='sudo dnf install'
alias remove='sudo dnf remove'
alias info='fastfetch'

# -------------------------
# Shell integrations (lazy)
# -------------------------
eval "$(zoxide init --cmd cd zsh)"
(( $+commands[fzf] )) && eval "$(fzf --zsh)"