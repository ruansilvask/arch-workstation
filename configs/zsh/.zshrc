# =========================================================
# HISTÓRICO
# =========================================================

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS


# =========================================================
# AUTOCOMPLETAR
# =========================================================

fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit


# =========================================================
# ZSH AUTOSUGGESTIONS
# =========================================================

if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'


# =========================================================
# HISTÓRICO COM SETAS
# =========================================================

if [[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi


# =========================================================
# FZF
# =========================================================

[[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -r /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh


# =========================================================
# THEFUCK
# =========================================================

if command -v thefuck >/dev/null 2>&1; then
  eval "$(thefuck --alias)"
fi


# =========================================================
# STARSHIP
# =========================================================

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi


# =========================================================
# SYNTAX HIGHLIGHTING
# =========================================================

if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# =========================================================
# NODE VERSION MANAGER (NVM)
# =========================================================

export NVM_DIR="$HOME/.nvm"
if [[ -s /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
fi


# =========================================================
# SDKMAN - JAVA / JVM
# =========================================================

if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi


# =========================================================
# SSH AGENT
# =========================================================
# The agent itself is managed by systemd --user. This file only
# exposes the standard socket and loads an existing key.

if [[ -z "${SSH_AUTH_SOCK:-}" && -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
