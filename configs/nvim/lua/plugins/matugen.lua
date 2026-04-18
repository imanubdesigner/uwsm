return {
  -- Il plugin che gestisce i temi base16
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
  },

  -- Integrazione LazyVim per caricare il file generato
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- Percorso assoluto del file generato da Matugen
        local matugen_path = vim.fn.expand("$HOME/.config/nvim/generated.lua")

        if vim.fn.filereadable(matugen_path) == 1 then
          dofile(matugen_path)
        else
          -- Tema di fallback se il file non esiste
          vim.cmd.colorscheme("tokyonight")
        end
      end,
    },
  },
}
