# common
set -gx TERM xterm-256color
alias ls='lsd'
alias vim='nvim'

set -g ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -Ux fish_user_paths $HOME/Library/Android/sdk/platform-tools $fish_user_paths
set -x PATH $PATH /usr/local/bin

# Wezterm
set -Ux fish_user_paths /Applications/WezTerm.app/Contents/MacOS $fish_user_paths
# Rust
set -x PATH $PATH $HOME/.cargo/bin

# neovim
set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim

# homebrew
eval (/opt/homebrew/bin/brew shellenv)

bind -M insert \cr _fzf_search_history
bind -M insert \cF _fzf_search_directory

# golang
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOPATH/bin $PATH
eval (goenv init - | source)

# direnv
eval (direnv hook fish)

# deno
set -x PATH $HOME/.deno/bin $PATH


# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end


set -x OPENAI_API_KEY (cat ~/.chatgpt)

# haskell
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yochidros/.ghcup/bin $PATH # ghcup-env

# startup
starship init fish | source
zoxide init fish | source

# if needed
# --google-japanese-input=notfound
# --no-daemonize
# pkill yaskkserv2
# alias yasskserv_start="yaskkserv2 --port 1179 \
#   --no-daemonize \
#   --google-suggest \
#   --google-cache-filename=$HOME/yaskkserv/tmp/yaskkserv2.cache \
#   $HOME/yaskkserv/tmp/dictionary.yaskkserv2"

