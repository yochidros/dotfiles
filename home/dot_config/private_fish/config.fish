# common
set -gx TERM xterm-256color
alias ls='lsd'
alias vim='nvim'
alias dcdn='docker compose down'
alias dcup='docker compose up'
alias vv='select_nvim'

set -g ANDROID_SDK_ROOT $HOME/Library/Android/sdk
# set -Ux fish_user_paths $HOME/Library/Android/sdk/platform-tools $fish_user_paths
set -x PATH $PATH /usr/local/bin
set -Ux fish_user_paths /opt/homebrew/opt/llvm/bin $fish_user_paths

# Wezterm
set -Ux fish_user_paths /Applications/WezTerm.app/Contents/MacOS $fish_user_paths
# Rust
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $HOME/.local/bin
# set -g JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home

# swiftly
set -x SWIFTLY_HOME_DIR "$HOME/.swiftly"
set -x SWIFTLY_BIN_DIR "$HOME/.swiftly/bin"

if not contains $SWIFTLY_BIN_DIR $PATH
    set -x PATH $SWIFTLY_BIN_DIR $PATH
end

# neovim
set -x XDG_CONFIG_HOME $HOME/.config
set -x EDITOR nvim

# homebrew
eval (/opt/homebrew/bin/brew shellenv)

bind -M insert \cr _fzf_search_history
bind -M insert \cF _fzf_search_directory

# deno
set -x PATH $HOME/.deno/bin $PATH

fzf --fish | source

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# haskell
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yochidros/.ghcup/bin $PATH # ghcup-env

# startup
starship init fish | source
zoxide init fish | source

atuin init fish | source
mise activate fish | source

# if needed
# --google-japanese-input=notfound
# --no-daemonize
# pkill yaskkserv2
# alias yasskserv_start="yaskkserv2 --port 1179 \
#   --no-daemonize \
#   --google-suggest \
#   --google-cache-filename=$HOME/yaskkserv/tmp/yaskkserv2.cache \
#   $HOME/yaskkserv/tmp/dictionary.yaskkserv2"

