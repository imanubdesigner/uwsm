-- autocmds.lua — Matugen live reload (no flicker)
-- Watches generated.lua with fs_event (zero polling overhead)
-- Lualine is updated via refresh(), NOT rebuilt from scratch

-- ── Highlight helpers ────────────────────────────────────────────────────────

local function apply_highlights()
  local ok, base16 = pcall(require, "base16-colorscheme")
  if not ok or not base16.colors then
    return
  end
  local c = base16.colors

  vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = c.base0D })
  vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = c.base0B, bold = true })
  vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = c.base0D })
  vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = c.base05 })
  vim.api.nvim_set_hl(0, "SnacksDashboardFile", { fg = c.base05 })
  vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = c.base03, italic = true })
  vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = c.base0B, bold = true })
end

-- ── Lualine theme builder (called once at startup + on theme change) ─────────
-- NOTE: does NOT unload lualine — uses lualine.setup() which is idempotent
--       when called after initial load (LazyVim handles the first setup via
--       lualine.lua; subsequent calls here just update the theme).

local function build_lualine_theme()
  local ok, base16 = pcall(require, "base16-colorscheme")
  if not ok or not base16.colors then
    return
  end
  local c = base16.colors

  return {
    normal = {
      a = { fg = c.base00, bg = c.base0D, gui = "bold" },
      b = { fg = c.base05, bg = c.base02 },
      c = { fg = c.base04, bg = c.base01 },
    },
    insert = {
      a = { fg = c.base00, bg = c.base0B, gui = "bold" },
      b = { fg = c.base05, bg = c.base02 },
      c = { fg = c.base04, bg = c.base01 },
    },
    visual = {
      a = { fg = c.base00, bg = c.base0E, gui = "bold" },
      b = { fg = c.base05, bg = c.base02 },
      c = { fg = c.base04, bg = c.base01 },
    },
    replace = {
      a = { fg = c.base00, bg = c.base08, gui = "bold" },
      b = { fg = c.base05, bg = c.base02 },
      c = { fg = c.base04, bg = c.base01 },
    },
    command = {
      a = { fg = c.base00, bg = c.base0A, gui = "bold" },
      b = { fg = c.base05, bg = c.base02 },
      c = { fg = c.base04, bg = c.base01 },
    },
    inactive = {
      a = { fg = c.base03, bg = c.base01 },
      b = { fg = c.base03, bg = c.base01 },
      c = { fg = c.base03, bg = c.base00 },
    },
  }
end

local function update_lualine_theme()
  local ok, lualine = pcall(require, "lualine")
  if not ok then
    return
  end

  local theme = build_lualine_theme()
  if not theme then
    return
  end

  -- setup() is safe to call multiple times; it does NOT reload the module.
  -- It simply reconfigures the running instance — no flicker.
  lualine.setup({ options = { theme = theme } })
  lualine.refresh()
end

-- ── On-change handler ────────────────────────────────────────────────────────

local matugen_path = vim.fn.expand("$HOME/.config/nvim/generated.lua")

local function on_theme_change()
  if vim.fn.filereadable(matugen_path) == 0 then
    return
  end
  dofile(matugen_path)
  apply_highlights()
  update_lualine_theme()
  -- 🔥 ADD THIS (critical fix)
  vim.api.nvim_exec_autocmds("ColorSchemePre", {})
  vim.api.nvim_exec_autocmds("ColorScheme", {})

  -- 🔥 force global UI refresh
  vim.cmd("redraw!")
end

-- ── fs_event watcher (event-driven, no polling) ──────────────────────────────

local watcher = vim.uv.new_fs_event()

local function start_watcher()
  -- Watch the directory so we catch atomic writes (mv-replace by matugen)
  local dir = vim.fn.fnamemodify(matugen_path, ":h")
  watcher:start(
    dir,
    {},
    vim.schedule_wrap(function(err, filename)
      if err then
        return
      end
      -- Only react to our specific file
      if filename and not filename:match("generated%.lua$") then
        return
      end
      on_theme_change()
    end)
  )
end

-- ── Startup: apply theme once, then start watching ───────────────────────────

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  once = true,
  callback = function()
    on_theme_change() -- apply current generated.lua immediately
    start_watcher() -- then watch for future changes
  end,
})
