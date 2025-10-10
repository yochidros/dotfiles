# Repository Guidelines
## プロジェクト構造とモジュール構成
このリポジトリは Neovim 向け Lua 設定をモジュール化しており、`init.lua` が `lua/config/*` を順に読み込んだ後、`VeryLazy` イベントでキーマップを遅延設定します。主要ディレクトリは以下の通りです。
- `lua/config/` : 基本設定・配色・ダークモード・キーマップ・プライベートパス・lazy.nvim 初期化。
- `lua/plugins/` : 各プラグインのテーブル定義。ファイル名は機能名 (`telescope.lua`, `dap.lua` など) に合わせて追加します。
- `lsp/` : 言語サーバー個別設定 (例: `clangd.lua`, `sourcekit.lua`)。
- `snippets/` : LuaSnip 形式のスニペット (`rust.snippets`, `swift.snippets`)。
- `lazy-lock.json` : プラグインバージョンのロックファイル。手動更新は避け、Lazy に任せます。

## ビルド・テスト・開発コマンド
- `nvim --headless "+Lazy sync" +qa` : プラグイン同期。初回導入や依存追加後に実行します。
- `nvim --headless "+MasonUpdate" +qa` : LSP / DAP / formatter のインデックス更新。
- `nvim --headless "+checkhealth" +qa` : 必須ライブラリや外部コマンドの健全性チェック。
- `nvim --headless "+so init.lua" +qa` : 設定の即時再読込。CI 相当の静的検証に使えます。
- `nvim --headless "+lua vim.cmd('qa')" -c "Lazy restore"` : `lazy-lock.json` を反映させた環境再現。

## コーディングスタイルと命名規約
Lua コードは 2 スペース幅 (`tabstop` / `shiftwidth` = 2) と `expandtab` を使用し、`local` 変数は `snake_case`、クラスやモジュールテーブルは PascalCase を推奨します。共通設定・プラグイン定義は `return { ... }` で終える既存パターンに従ってください。フォーマッタは none-ls 経由の `stylua` と `prettier` を利用できるため、編集後は `:Format` または `:lua vim.lsp.buf.format()` で整形します。コメントは必要最小限で、複雑なオートコマンドやハックには意図を日本語で記述します。

## テスト指針
設定変更後は `nvim --headless "+Lazy sync" "+checkhealth" +qa` を最低限実行し、プラグインの読み込み失敗がないことを確認します。LSP 連携を追加した場合は `:Mason` で対象サーバーがインストールされるか、`nvim --headless "-c" "Lua require('vim.lsp').start_client(...)"` のようなスモークテストを検討してください。キーマップや UI 変更は `nvim --clean -u init.lua` での手動確認を推奨します。重大な変更にはスクリーンショットや `:messages` のログを添付してください。

## コミットとプルリクエスト
コミットメッセージは Conventional Commits (`feat:`, `fix:`, `refactor:` など) 形式を推奨し、設定追加は対象ファイル名と効果を短く書きます。PR の説明には 1) 目的、2) 主な変更点、3) 影響範囲 (例: 対象のプラグインや言語)、4) 検証手順と実行結果 (コマンド出力やスクリーンショット) を含めてください。レビュー負荷を下げるため、プラグイン追加とキーマップ変更は別 PR に分け、`lazy-lock.json` を再生成した場合は差分を確認してから提出します。関連 Issue があれば `Closes #123` のように明記し、環境依存の設定値は `config/private_path.lua` へ隔離したうえで PR に含めないでください。

## セキュリティと環境依存メモ
`config/private_path.lua` には個人環境の SDK パスや API Key への参照が含まれるため、平文シークレットを追加せず、必要なら環境変数参照 (`vim.env.*`) に置き換えます。macOS 固有の設定 (`clipboard`, `shell = "fish"`) を変更する場合は Linux / Windows での代替値を `if vim.fn.has(...)` で条件分岐してください。プラグインの試験導入は `lua/plugins/<feature>-experimental.lua` などの一時ファイルで行い、安定したら正式名にリネームする運用を推奨します。外部バイナリ依存を増やす際は README と同時に更新し、`install.sh` 等の補助スクリプトが存在する場合はそちらへの追記も忘れないでください。
