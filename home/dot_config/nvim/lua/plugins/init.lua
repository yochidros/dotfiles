return {
	{ "lambdalisue/nerdfont.vim", lazy = false },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		lazy = not vim.g.started_by_firenvim,
		config = function()
			vim.g.startuptime_tries = 40
		end,
	},

	{
		"williamboman/mason.nvim",
		event = { "BufReadPre", "BufNewFile" },
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = { default = true },
	},
	{
		"pwntester/octo.nvim",
		event = "VeryLazy",
		lazy = not vim.g.started_by_firenvim,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	--- chat GPT
	{
		"jackMort/ChatGPT.nvim",
		lazy = not vim.g.started_by_firenvim,
		event = "VeryLazy",
		config = function()
			if vim.g.started_by_firenvim then
				return
			end
			require("chatgpt").setup({
				openai_params = {
					model = "gpt-4",
				},
				openai_edit_params = {
					model = "code-davinci-edit-002",
				},
				actions_paths = { "~/.config/nvim/custom_actions.json" },
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	--- enabled textarea in browser using neovim
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
	},

	---- Plenary
	"nvim-lua/plenary.nvim",

	---- Fuzzy finder
	{ "airblade/vim-rooter", event = "VeryLazy" },

	---- auto tag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "ts", "typescriptreact", "tsx" },
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
	{
		"airblade/vim-gitgutter",
		event = "VeryLazy",
		lazy = not vim.g.started_by_firenvim,
		config = function()
			vim.keymap.set("n", "[h", "<Plug>(GitGutterNextHunk)", { silent = true })
			vim.keymap.set("n", "[h", "<Plug>(GitGutterPrevHunk)", { silent = true })
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
		lazy = not vim.g.started_by_firenvim,
		config = function()
			require("scrollbar").setup()
		end,
	},

	---- window resizer
	{
		"simeji/winresizer",
		event = "VeryLazy",
		lazy = not vim.g.started_by_firenvim,
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
	-- NOTE: print zero padding width bugs when telescope find_files, live_grep selections.
	-- {
	-- 	"ntpeters/vim-better-whitespace",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		vim.g.better_whitespace_enabled = 1
	-- 		vim.g.strip_whitespace_on_save = 1
	-- 		vim.g.strip_whitespace_confirm = 0
	-- 		vim.g.better_whitespace_operator = " "
	-- 	end,
	-- },
	{
		"johnfrankmorgan/whitespace.nvim",
		event = "VeryLazy",
		config = function()
			require("whitespace-nvim").setup({
				-- configuration options and their defaults

				-- `highlight` configures which highlight is used to display
				-- trailing whitespace
				highlight = "TodoBgFIX",

				-- `ignored_filetypes` configures which filetypes to ignore when
				-- displaying trailing whitespace
				ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "Comment" },

				-- `ignore_terminal` configures whether to ignore terminal buffers
				ignore_terminal = true,
			})
			vim.keymap.set("n", "<leader>i", require("whitespace-nvim").trim)
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*",
				callback = function()
					require("whitespace-nvim").trim()
				end,
			})
			vim.api.nvim_create_autocmd({ "InsertLeave", "BufReadPost", "InsertEnter" }, {
				pattern = "*",
				callback = function()
					require("whitespace-nvim").highlight()
				end,
			})
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
