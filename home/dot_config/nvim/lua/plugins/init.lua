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

	---- auto tag
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "xml", "ts", "typescriptreact", "tsx" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

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
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
		branch = "master",
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "visual_multi_exit",
				callback = function()
					local keymaps = vim.api.nvim_buf_get_keymap(0, "i")
					for _, map in ipairs(keymaps) do
						if map.desc == "blink.cmp" then
							vim.keymap.del("i", map.lhs, { buffer = 0 })
						end
					end
					require("blink.cmp.keymap.apply").keymap_to_current_buffer({
						["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
						-- ["<C-c>"] = { "cancel", "fallback" },
						["<C-e>"] = { "cancel", "fallback" },
						-- ["<Esc>"] = { "cancel", "fallback" },
						["<CR>"] = { "select_and_accept", "fallback" },
						["<C-p>"] = { "select_prev", "fallback_to_mappings" },
						["<C-n>"] = { "select_next", "fallback_to_mappings" },
						["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
						["<Tab>"] = { "select_next", "fallback" },
						["<S-Tab>"] = { "select_prev", "fallback" },
						["<C-d>"] = {
							"scroll_documentation_down",
							"fallback",
						},
						["<C-f>"] = {
							"scroll_documentation_down",
							"fallback",
						},
					})
				end,
			})
		end,
	},

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
