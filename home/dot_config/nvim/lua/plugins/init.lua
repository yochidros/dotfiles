return {
	{ "lambdalisue/nerdfont.vim", lazy = false },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 40
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"tris203/hawtkeys.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = {},
	},
	-- {
	-- 	"nvim-tree/nvim-web-devicons",
	-- 	config = { default = true },
	-- },
	{
		"echasnovski/mini.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
	---- Plenary
	"nvim-lua/plenary.nvim",

	---- Fuzzy finder
	-- {
	-- 	"airblade/vim-rooter",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		vim.g.rooter_manual_only = 1
	-- 		vim.g.rooter_targets = { "*/.local/", "/", "*" }
	-- 		vim.g.rooter_patterns = { ".git", "Makefile" }
	-- 	end,
	-- },

	---- auto tag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "ts", "typescriptreact", "tsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	---- Silicon
	-- { "segeljakt/vim-silicon", cmd = "Silicon" },

	---- Align
	{
		"junegunn/vim-easy-align",
		event = "VeryLazy",
		config = function()
			local map = vim.keymap.set
			map("x", "ga", "<Plug>(EasyAlign)")
			--Start⋅interactive⋅EasyAlign⋅for⋅a
			map("n", "gA", "<Plug>(EasyAlign)")
		end,
	},

	---- Git
	{
		"airblade/vim-gitgutter",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "[h", "<Plug>(GitGutterNextHunk)", { silent = true })
			vim.keymap.set("n", "]h", "<Plug>(GitGutterPrevHunk)", { silent = true })
			-- 記号の色を変更する
			vim.cmd("highlight GitGutterAdd ctermfg=green")
			vim.cmd("highlight GitGutterChange ctermfg=blue")
			vim.cmd("highlight GitGutterDelete ctermfg=red")
		end,
	},
	{ "APZelos/blamer.nvim", event = "VeryLazy" },

	---- Scroll bar
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			require("scrollbar").setup()
		end,
	},

	---- window resizer
	{
		"simeji/winresizer",
		event = "VeryLazy",
		config = function()
			vim.g.winresizer_gui_enable = 1
		end,
	},

	---- Multi cursol
	{ "mg979/vim-visual-multi", event = "VeryLazy", branch = "master" },

	---- Translator
	{
		"voldikss/vim-translator",
		cmd = "Translate",
		config = function()
			vim.g.translator_target_lang = "ja"
			vim.g.translator_default_engines = { "google" }
		end,
	},

	---- display color code
	{ "gorodinskiy/vim-coloresque", event = "VeryLazy" },
	{ "ap/vim-css-color", event = "VeryLazy" },
	{ "chrisbra/Colorizer", event = "VeryLazy" },

	---- TOML
	{ "cespare/vim-toml", ft = "toml" },

	-- Go
	{
		"fatih/vim-go",
		ft = "go",
		build = ":GoInstallBinaries",
	},

	-- Rust
	{ "rust-lang/rust.vim", ft = "rust" },

	-- Markdown
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = "cd app && npx yarn install",
		config = function()
			vim.g.mkdp_browser = "firefox"
		end,
	},
	{
		"plasticboy/vim-markdown",
		ft = "markdown",
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
		end,
	},

	---- Haskell
	{ "neovimhaskell/haskell-vim", ft = "haskell" },
	-- 'alx741/vim-hindent', { ['for'] = 'haskell' },
	-- Plug 'nbouscal/vim-stylish-haskell', { 'for': 'haskell' }

	---- Ruby
	{ "tpope/vim-endwise", ft = "ruby" },
	-- { "tpope/vim-rails", ft = "ruby" },
	--
	-- Swift
	{ "keith/swift.vim", ft = "swift" },
}
