return {
	{ "lambdalisue/nerdfont.vim", lazy = false },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = { default = true },
	},
	---- Plenary
	"nvim-lua/plenary.nvim",

	---- Fuzzy finder
	{ "airblade/vim-rooter", event = "VeryLazy" },

	---- auto tag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	---- Silicon
	{ "segeljakt/vim-silicon", cmd = "Silicon" },

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

	-- Fish
	{ "dag/vim-fish", ft = "fish" },

	---- Git
	{ "airblade/vim-gitgutter", event = "VeryLazy" },
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
			vim.g.vtm_target_lang = "ja"
			vim.g.vtm_default_engines = { "google", "bing" }
		end,
	},

	---- check trailing whitespaces
	{
		"ntpeters/vim-better-whitespace",
		event = "VeryLazy",
		config = function()
			vim.g.better_whitespace_enabled = 1
			vim.g.strip_whitespace_on_save = 1
			vim.g.strip_whitespace_confirm = 0
			vim.g.better_whitespace_operator = " "
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
		build = "cd app && yarn install",
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
	{ "tpope/vim-rails", ft = "ruby" },

	-- Fastlane
	{ "milch/vim-fastlane", ft = { "ruby" } },

	---- Swift
	{ "keith/swift.vim", ft = "swift" },
	-- { "tokorom/vim-swift-format", ft = "swift" },
}
