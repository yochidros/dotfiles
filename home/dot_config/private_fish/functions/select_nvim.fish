function select_nvim --description 'Select Neovim config for editing'
  # ~/.config/nvim-* ディレクトリから選択
  set config (fd --max-depth 1 --regex 'nvim(-.*)?' ~/.config | fzf --prompt="Neovim Configs > " --height=50% --layout=reverse --border --exit-0)

  # fzfで何も選択されなかった場合は終了
  if test -z "$config"
    echo "No config selected"
    return
  end
   # argv が空ならカレントディレクトリを渡す
    if not set -q argv[1]
        set argv "."
    end

  # 選択されたconfigでNeovimを起動
  set nvim_appname (basename $config)
  env NVIM_APPNAME=$nvim_appname nvim $argv
end
