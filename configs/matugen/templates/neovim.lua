-- This file will be written to ~/.config/nvim/generated.lua
-- Optimized for better semantic highlighting using Material You colors

require("base16-colorscheme").setup({
	-- ─────────────────────────────────────────────────────────────
	-- Base UI colors (background & surfaces)
	-- ─────────────────────────────────────────────────────────────
	base00 = "{{colors.background.default.hex}}", -- Default background
	base01 = "{{colors.surface_container_lowest.default.hex}}", -- Darker panels / splits
	base02 = "{{colors.surface_container_low.default.hex}}", -- Lighter panels

	-- Comments / subtle text (balanced for readability)
	base03 = "{{colors.outline.default.hex}}",

	-- Foreground hierarchy
	base04 = "{{colors.on_surface_variant.default.hex}}", -- Secondary text
	base05 = "{{colors.on_surface.default.hex}}", -- Main text
	base06 = "{{colors.inverse_on_surface.default.hex}}", -- High contrast
	base07 = "{{colors.on_surface.default.hex}}", -- Bright foreground

	-- ─────────────────────────────────────────────────────────────
	-- Syntax highlighting (semantic mapping)
	-- IMPORTANT: Avoid reusing the same color roles
	-- ─────────────────────────────────────────────────────────────

	base08 = "{{colors.error.default.hex}}", -- Variables (high visibility)
	base09 = "{{colors.secondary.default.hex}}", -- Numbers / constants
	base0A = "{{colors.tertiary.default.hex}}", -- Types / classes

	base0B = "{{colors.primary_container.default.hex}}", -- Strings (clearly distinct)
	base0C = "{{colors.secondary.default.hex}}", -- Support / builtins

	base0D = "{{colors.primary.default.hex}}", -- Functions / methods
	base0E = "{{colors.tertiary.default.hex}}", -- Keywords / control flow

	base0F = "{{colors.tertiary_fixed_dim.default.hex}}", -- Deprecated / special
})

-- ─────────────────────────────────────────────────────────────
-- Visual selection (better contrast)
-- ─────────────────────────────────────────────────────────────
vim.api.nvim_set_hl(0, "Visual", {
	bg = "{{colors.primary_container.default.hex}}",
	fg = "{{colors.on_primary_container.default.hex}}",
})

-------------------------------------------------------------------------------
-- Treesitter semantic fixes (CRITICAL for real differentiation)
-------------------------------------------------------------------------------

-- Functions (strong and recognizable)
vim.api.nvim_set_hl(0, "@function", {
	fg = "{{colors.primary.default.hex}}",
	bold = true,
})

-- Keywords (control flow, statements)
vim.api.nvim_set_hl(0, "@keyword", {
	fg = "{{colors.tertiary.default.hex}}",
})

-- Strings (clearly separated from functions)
vim.api.nvim_set_hl(0, "@string", {
	fg = "{{colors.primary_container.default.hex}}",
})

-- Variables (stand out from everything else)
vim.api.nvim_set_hl(0, "@variable", {
	fg = "{{colors.error.default.hex}}",
})

-------------------------------------------------------------------------------
-- Bash / Shell specific fixes (important for your workflow)
-------------------------------------------------------------------------------

-- Make command names clearly visible
vim.api.nvim_set_hl(0, "@function.bash", {
	fg = "{{colors.primary.default.hex}}",
	bold = true,
})

-- Strings in shell scripts
vim.api.nvim_set_hl(0, "@string.bash", {
	fg = "{{colors.primary_container.default.hex}}",
})

-- Special variables like $HOME
vim.api.nvim_set_hl(0, "@punctuation.special.bash", {
	fg = "{{colors.tertiary.default.hex}}",
	bold = true,
})

-- Delimiters (; , etc.)
vim.api.nvim_set_hl(0, "@punctuation.delimiter.bash", {
	fg = "{{colors.on_surface.default.hex}}",
})

vim.api.nvim_set_hl(0, "TSPunctDelimiter", {
	fg = "{{colors.on_surface.default.hex}}",
})

-- Paths like /dev/null
vim.api.nvim_set_hl(0, "@string.special.path.bash", {
	fg = "{{colors.secondary.default.hex}}",
})

vim.api.nvim_set_hl(0, "SpecialChar", {
	fg = "{{colors.secondary.default.hex}}",
	italic = true,
})

-- Fallback for undefined tokens
vim.api.nvim_set_hl(0, "@none.bash", {
	fg = "{{colors.on_surface.default.hex}}",
})
