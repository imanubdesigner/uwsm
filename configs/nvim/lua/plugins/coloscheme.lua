return {
  -- 1. LazyVim core configured to use catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- 2. Tokyo Night explicitly disabled
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },

  -- 3. Catppuccin theme configured as primary
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {}, -- Keeping empty opts as in your example
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Selected flavour: latte, frappe, macchiato, mocha
        transparent_background = false,
        integrations = {
          lualine = true,
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
          cmp = true,
          gitsigns = true,
          telescope = true,
          mason = true,
          which_key = true,
          notify = true,
          noice = true,
          mini = true,
        },
      })
    end,
  },
}
