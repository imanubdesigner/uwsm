-- ~/.config/nvim/lua/config/lazy.lua

-- ─────────────────────────────────────────────────────────────
-- Bootstrap lazy.nvim (plugin manager)
-- ─────────────────────────────────────────────────────────────

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  -- Clone lazy.nvim if not installed
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })

  -- Handle clone failure
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────────────────────────
-- Plugin setup
-- ─────────────────────────────────────────────────────────────

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",

      -- Import default LazyVim plugins
      import = "lazyvim.plugins",

      -- Disable default colorscheme
      -- (we load our dynamic theme from matugen instead)
      opts = {
        colorscheme = nil,
      },
    },

    -- Load user plugins
    { import = "plugins" },
  },

  -- ───────────────────────────────────────────────────────────
  -- Default behavior
  -- ───────────────────────────────────────────────────────────
  defaults = {
    lazy = false, -- Load plugins at startup (important for theme consistency)
    version = false, -- Always use latest commit
  },

  -- Prevent Lazy from installing fallback themes
  install = {
    colorscheme = {},
  },

  -- Plugin update checker
  checker = {
    enabled = true,
    notify = false,
  },

  -- ───────────────────────────────────────────────────────────
  -- Performance optimizations
  -- ───────────────────────────────────────────────────────────
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
