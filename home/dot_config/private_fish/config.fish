# common
set -gx TERM xterm-256color
alias ls='lsd'
alias vim='/usr/local/bin/nvim'

set -g ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -Ux fish_user_paths $HOME/Library/Android/sdk/platform-tools $fish_user_paths
set -x PATH $PATH /usr/local/bin

# Rust
set -x PATH $PATH $HOME/.cargo/bin

# neovim
set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim

# homebrew
eval (/usr/local/bin/brew shellenv)

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $PYENV_ROOT/shims $fish_user_paths
status is-login; and pyenv init --path | source

# fish-fzf
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_REVERSE_ISEARCH_OPTS "--reverse --height=100%"

# golang
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOPATH/bin $PATH
eval (goenv init - | source)

# direnv
eval (direnv hook fish)

# rbenv
set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
status --is-interactive; and rbenv init - fish | source

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# nodenv
eval (nodenv init - | source)
set -Ux fish_user_paths $HOME/.nodenv/shims $fish_user_paths
set -x PATH $HOME/.nodenv/shims $PATH

set -x OPENAI_API_KEY (cat ~/.chatgpt)

# haskell
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yochidros/.ghcup/bin $PATH # ghcup-env

# startup
starship init fish | source
zoxide init fish | source
