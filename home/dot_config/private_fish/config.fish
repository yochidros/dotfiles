# common
set -gx TERM xterm-256color
alias ls='lsd'
alias la='lsd -al'
alias vim='nvim'
alias vv='select_nvim'

set -g ANDROID_SDK_ROOT $HOME/Library/Android/sdk
# set -Ux fish_user_paths $HOME/Library/Android/sdk/platform-tools $fish_user_paths
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH ~/.nest/bin
set -Ux fish_user_paths /opt/homebrew/opt/llvm/bin $fish_user_paths

# swiftly
set -gx SWIFTLY_HOME_DIR "$HOME/.swiftly"
set -gx SWIFTLY_BIN_DIR "$HOME/.swiftly/bin"

if not string match -q "*:$SWIFTLY_BIN_DIR:*" ":$PATH:"
    set -gx PATH $SWIFTLY_BIN_DIR $PATH
end

# Wezterm
set -Ux fish_user_paths /Applications/WezTerm.app/Contents/MacOS $fish_user_paths
alias imgcat='wezterm imgcat'
# Rust
set -x PATH $PATH $HOME/.cargo/bin

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

bind -M insert ctrl-r _fzf_search_history
bind -M insert ctrl-f _fzf_search_directory

# deno
set -x PATH $HOME/.deno/bin $PATH

fzf --fish | source

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

set -x OBSIDIAN_REST_API_KEY ""
set -x OPENAI_API_KEY (cat ~/.chatgpt)

# haskell
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yochidros/.ghcup/bin $PATH # ghcup-env

# startup
starship init fish | source
zoxide init fish | source
cat ./atuin.fish | source
mise activate fish | source

