export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/apache-maven-3.9.2/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/include"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "~/.nvm/nvm.sh" ] && \. "~/.nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(rbenv init - zsh)"

PROMPT='%/ %# '

# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim="nvim"
alias sed="gsed"
alias mux="tmuxinator"

export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_EVAL_ALL=true

export EDITOR='nvim'

# Not really sure why these are needed, but they stop working inside tmux
bindkey '^P' up-history
bindkey '^R' history-incremental-search-backward
bindkey '^U' kill-whole-line

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/max/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/max/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/max/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/max/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/max/.bun/_bun" ] && source "/Users/max/.bun/_bun"
