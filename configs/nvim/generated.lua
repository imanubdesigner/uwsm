-- This file will be written to ~/.config/nvim/generated.lua
-- Optimized for better semantic highlighting using Material You colors

require("base16-colorscheme").setup({
	-- ─────────────────────────────────────────────────────────────
	-- Base UI colors (background & surfaces)
	-- ─────────────────────────────────────────────────────────────
	base00 = "#080906", -- Default background
	base01 = "#000000", -- Darker panels / splits
	base02 = "#11130f", -- Lighter panels

	-- Comments / subtle text (balanced for readability)
	base03 = "#a2a699",

	-- Foreground hierarchy
	base04 = "#ccd0c2", -- Secondary text
	base05 = "#ffffff", -- Main text
	base06 = "#252721", -- High contrast
	base07 = "#ffffff", -- Bright foreground

	-- ─────────────────────────────────────────────────────────────
	-- Syntax highlighting (semantic mapping)
	-- IMPORTANT: Avoid reusing the same color roles
	-- ─────────────────────────────────────────────────────────────

	base08 = "#fcc1b9", -- Variables (high visibility)
	base09 = "#c6d2b5", -- Numbers / constants
	base0A = "#a8d7d4", -- Types / classes

	base0B = "#759356", -- Strings (clearly distinct)
	base0C = "#c6d2b5", -- Support / builtins

	base0D = "#b7d892", -- Functions / methods
	base0E = "#a8d7d4", -- Keywords / control flow

	base0F = "#9dccc9", -- Deprecated / special
})

-- ─────────────────────────────────────────────────────────────
-- Visual selection (better contrast)
-- ─────────────────────────────────────────────────────────────
vim.api.nvim_set_hl(0, "Visual", {
	bg = "#759356",
	fg = "#000000",
})

-------------------------------------------------------------------------------
-- Treesitter semantic fixes (CRITICAL for real differentiation)
-------------------------------------------------------------------------------

-- Functions (strong and recognizable)
vim.api.nvim_set_hl(0, "@function", {
	fg = "#b7d892",
	bold = true,
})

-- Keywords (control flow, statements)
vim.api.nvim_set_hl(0, "@keyword", {
	fg = "#a8d7d4",
})

-- Strings (clearly separated from functions)
vim.api.nvim_set_hl(0, "@string", {
	fg = "#759356",
})

-- Variables (stand out from everything else)
vim.api.nvim_set_hl(0, "@variable", {
	fg = "#fcc1b9",
})

-------------------------------------------------------------------------------
-- Bash / Shell specific fixes (important for your workflow)
-------------------------------------------------------------------------------

-- Make command names clearly visible
vim.api.nvim_set_hl(0, "@function.bash", {
	fg = "#b7d892",
	bold = true,
})

-- Strings in shell scripts
vim.api.nvim_set_hl(0, "@string.bash", {
	fg = "#759356",
})

-- Special variables like $HOME
vim.api.nvim_set_hl(0, "@punctuation.special.bash", {
	fg = "#a8d7d4",
	bold = true,
})

-- Delimiters (; , etc.)
vim.api.nvim_set_hl(0, "@punctuation.delimiter.bash", {
	fg = "#ffffff",
})

vim.api.nvim_set_hl(0, "TSPunctDelimiter", {
	fg = "#ffffff",
})

-- Paths like /dev/null
vim.api.nvim_set_hl(0, "@string.special.path.bash", {
	fg = "#c6d2b5",
})

vim.api.nvim_set_hl(0, "SpecialChar", {
	fg = "#c6d2b5",
	italic = true,
})

-- Fallback for undefined tokens
vim.api.nvim_set_hl(0, "@none.bash", {
	fg = "#ffffff",
})
