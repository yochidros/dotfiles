# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a comprehensive NeoVim configuration written in Lua, designed for modern software development with extensive plugin support. The configuration follows a modular architecture with separate files for different functionality and uses lazy.nvim for efficient plugin management.

## Core Architecture

### Initialization Flow

- `init.lua`: Main entry point that loads core configuration modules in order
- Configuration loads in sequence: base → highlights → private_path → dark_mode → lazy → keymaps (delayed)
- Keymaps are loaded after all plugins via the "VeryLazy" event to prevent conflicts

### Directory Structure

```
lua/
├── config/           # Core configuration files
│   ├── base.lua      # Basic NeoVim settings (encoding, tabs, search, etc.)
│   ├── highlights.lua # Color scheme and display settings
│   ├── keymaps.lua   # Key mappings and shortcuts
│   ├── lazy.lua      # Plugin manager configuration
│   ├── dark_mode.lua # Dark mode configuration
│   └── private_path.lua # Language interpreter paths
└── plugins/          # Individual plugin configurations
    ├── init.lua      # Basic plugins and utilities
    ├── lsp.lua       # Language Server Protocol setup
    ├── telescope.lua # Fuzzy finder configuration
    └── [50+ other plugin files]
```

## Key Configuration Details

### Plugin Management

- Uses lazy.nvim with lazy loading enabled by default
- Plugins are loaded on-demand based on events, file types, or commands
- Configuration disables several default NeoVim plugins for performance

### Language Support

- **LSP**: Comprehensive setup with lua_ls, rust_analyzer, clangd, pylsp, sourcekit (Swift), gleam
- **Languages**: Rust, Swift, Go, Python, Lua, C/C++, Gleam, TypeScript, Haskell, Ruby, Markdown
- **Auto-formatting**: Configured for Gleam and other languages via LSP

### Development Tools

- **Telescope**: Fuzzy finder with custom keybindings (`<leader>ff`, `<C-g>`, `<leader>fb`)
- **Git Integration**: GitGutter, Blamer, Fugitive, GitUI for comprehensive Git workflow
- **Debugging**: DAP (Debug Adapter Protocol) support with UI
- **AI Assistance**: GitHub Copilot and CopilotChat integration
- **Code Analysis**: Treesitter for syntax highlighting and code analysis

### Japanese Language Support

- SKK input method (`skkeleton`) for Japanese text input
- Japanese comments throughout configuration files
- Translator plugin for quick translation

### Key Bindings (Space as Leader)

- `<leader>ff`: Find files
- `<leader>fb`: Browse buffers
- `<leader>fc`: Command line fuzzy search
- `<leader>fp`: File browser with path insertion
- `<leader>l`: Open Lazy plugin manager
- `<leader>rc`: Reload configuration
- Window navigation: `<C-h/j/k/l>` or `sh/sj/sk/sl`
- Split windows: `ss` (horizontal), `sv` (vertical)

## Development Workflow

### Plugin Development

- Add new plugins to `lua/plugins/` directory with descriptive filenames
- Follow the existing pattern of returning plugin configuration tables
- Use lazy loading with appropriate triggers (events, file types, commands)

### LSP Configuration

- Language servers are managed through Mason and mason-lspconfig
- Custom LSP settings are in `lua/plugins/lsp.lua`
- Keybindings are set automatically on LSP attach

### Theming

- Primary theme: Gruvbox with custom highlights
- Dark mode support with True Color enabled
- Custom Telescope highlight groups for consistent appearance

## Special Features

### Performance Optimizations

- Lazy loading for most plugins
- Disabled unused default plugins
- Startup time monitoring with vim-startuptime

### File Management

- Fern file explorer with Git status integration
- Telescope file browser with path insertion capabilities
- Buffer management with close-buffers.nvim

### Code Quality

- Multiple formatting tools (Prettier, none-ls)
- Linting and diagnostics through LSP
- Trouble.nvim for diagnostics management

## Dependencies

This configuration assumes the following external tools are available:

- `lua-language-server`
- `rust-analyzer`
- `clangd`
- `sourcekit-lsp` (for Swift)
- `rg` (ripgrep) for search functionality
- Various language-specific tools installed via Mason

## Customization Notes

- Language interpreter paths are set in `config/private_path.lua`
- Shell is configured to use Fish (`o.shell = "fish"`)
- Tab settings: 2 spaces, expandtab enabled
- Search is case-insensitive with smart case
- No backup or swap files created