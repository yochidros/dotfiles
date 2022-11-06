local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug 'RRethy/nvim-base16'
Plug 'morhetz/gruvbox'

Plug 'dstein64/vim-startuptime'

-- Fuzzy finder
Plug 'airblade/vim-rooter'
Plug('junegunn/fzf', {
  ['dir'] = '~/.fzf',
  ['do'] = './install --all'
})
Plug 'junegunn/fzf.vim'

-- completion

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug('glepnir/lspsaga.nvim', {
  ['branch'] = 'main'
})
Plug 'folke/lsp-colors.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/lsp-status.nvim'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'onsails/lspkind-nvim'

-- For vsnip user.
--
Plug 'hrsh7th/cmp-vsnip'
-- Plug 'hrsh7th/vim-vsnip'
-- Plug 'hrsh7th/vim-vsnip-integ'
-- Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'


-- Syntax highlight
Plug('nvim-treesitter/nvim-treesitter', {
  ['do'] = ':TSUpdate'
})

-- Utils
Plug 'romgrk/barbar.nvim'
-- -- auto pairs
Plug 'windwp/nvim-autopairs'
-- auto tag
Plug 'windwp/nvim-ts-autotag'

-- Plenary
Plug 'nvim-lua/plenary.nvim'

-- Telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {
  ['do'] = 'make'
})

-- Silicon
Plug 'segeljakt/vim-silicon'

-- SQL
Plug 'jsborjesson/vim-uppercase-sql'

-- Comment
Plug 'folke/todo-comments.nvim'
Plug 'numToStr/Comment.nvim'

-- Align
Plug 'junegunn/vim-easy-align'
-- -- Fish
-- Plug('dag/vim-fish', { ['for'] = 'fish' })

-- Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'

-- Indent line-number
Plug 'lukas-reineke/indent-blankline.nvim'

-- Trouble
Plug 'folke/trouble.nvim'

-- signature
Plug 'ray-x/lsp_signature.nvim'

-- Scroll bar
Plug 'petertriho/nvim-scrollbar'

-- window resizer
Plug 'simeji/winresizer'

-- Numbers
Plug 'myusuf3/numbers.vim'

-- Startup menu
Plug 'goolord/alpha-nvim'
Plug 'kyazdani42/nvim-web-devicons'

-- Status line
Plug 'nvim-lualine/lualine.nvim'

-- Multi cursol
Plug('mg979/vim-visual-multi', { ['branch'] = 'master' })

-- Translator
Plug 'voldikss/vim-translator'

-- check trailing whitespaces
Plug 'ntpeters/vim-better-whitespace'

-- display color code
Plug 'gorodinskiy/vim-coloresque'
Plug 'ap/vim-css-color'
Plug 'chrisbra/Colorizer'

-- ALE
Plug 'dense-analysis/ale'

-- Null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'

-- Plug
Plug 'slim-template/vim-slim'

-- TOML
Plug('cespare/vim-toml', { ['for'] = 'toml' })

-- Go
Plug('fatih/vim-go', {
  ['for'] = 'go',
  ['do'] = ':GoInstallBinaries'
})

-- Rust
Plug('rust-lang/rust.vim', { ['for'] = 'rust' })
Plug 'simrat39/rust-tools.nvim'

-- Markdown
Plug('iamcco/markdown-preview.nvim', { ['for'] = 'markdown' })
Plug('plasticboy/vim-markdown', { ['for'] = 'markdown' })

-- Haskell
Plug('neovimhaskell/haskell-vim', { ['for'] = 'haskell' })
-- Plug('alx741/vim-hindent', { ['for'] = 'haskell' })
-- Plug 'nbouscal/vim-stylish-haskell', { 'for': 'haskell' }

-- Ruby
Plug('tpope/vim-endwise', { ['for'] = 'ruby' })
Plug('tpope/vim-rails', { ['for'] = 'ruby' })

-- Swift
Plug('keith/swift.vim', { ['for'] = 'swift' })
Plug('tokorom/vim-swift-format', { ['for'] = 'swift' })

-- Fastlane
Plug 'milch/vim-fastlane'

-- Fern
Plug 'lambdalisue/fern.vim'
Plug 'yuki-yano/fern-preview.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

vim.call('plug#end')
