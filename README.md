# Neovim Configuration: Premium DX (The Principal's Substrate)

This is not a black-box framework. This is a **high-transparency substrate for the Principal Engineer**—an intentionally "incomplete" living laboratory that rejects hidden complexity in favor of **Radical Observability** and **Utility**. We use Neovim 0.12+ core primitives to deliver a "Premium" developer experience where the signal-to-noise ratio is optimized, and every architectural choice is laid bare for you to test, fork, or override.

## 🧪 Experiments / Under Construction

This project embraces the "Incomplete Truth." If a workflow survives the "Physics" of daily use, it stays. Here is what we are currently testing in the laboratory:
- **Taskwarrior / Timewarrior Integration:** Exploring seamless terminal and buffer-based workflows to manage tasks and track time directly from the editor without breaking focus.

## 🚀 Key Features (Neovim 0.12+)

- **Native UI2:** A complete redesign of the core messaging system. No more "Press ENTER" prompts. Includes native command-line syntax highlighting and a buffer-based pager for long messages.
- **Async Tree-sitter:** Highlighting is now asynchronous. Massive files load instantly with regex and "pop" into Tree-sitter in the background.
- **Parser Management:** Leveraging the `main` branch of `nvim-treesitter` for a lightweight, modern experience.
- **Structural Awareness:** Includes `treesitter-context` for sticky function/class headers and native incremental selection (`v_an` / `v_in`).
- **Semantic Token Balancing:** Refined integration between LSP semantic tokens and Tree-sitter structural highlights.
- **Automated Agent Protocol:** Built-in documentation and backlog system for seamless collaboration with AI agents.

## 📦 Installation

### Prerequisites

1. **Neovim 0.12.0+**
2. **tree-sitter CLI** (Required for parser compilation):
   - `brew install tree-sitter`
   - `pacman -S tree-sitter`
   - `cargo install tree-sitter-cli`
3. **Nerd Font** (Optional, but recommended for icons)

### Setup

1. Clone this repository into your Neovim config directory:
   ```bash
   git clone https://github.com/e4rthb0y/nvim.git ~/.config/nvim
   ```
2. Launch Neovim:
   ```bash
   nvim
   ```
3. Run `:TSUpdate` to install/update the essential parsers.

## 🛠️ Configuration Structure

- `lua/config/`: Core settings, keymaps, and providers.
- `lua/lsp/`: LSP server configurations and UI settings.
- `lua/plugins/`: Plugin specifications managed by `lazy.nvim`.
- `.agents/`: Backlog and documentation for AI collaborators.

## ⌨️ Essential Keybindings

- `<leader>a`: Toggle Aerial (Code outline)
- `gd`: Go to Definition
- `K`: LSP Hover
- `v_an`: Expand selection (Around node)
- `v_in`: Shrink selection (Inside node)
- `:Inspect`: View highlight groups at cursor
- `:InspectTree`: View AST for the current buffer

## 🤖 AI Collaboration

This project implements a streamlined **Gemini Agent Protocol**. AI collaborators should start by reading `AGENTS.md` and the `.agents/TODO.md` backlog.
