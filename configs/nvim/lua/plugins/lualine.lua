return {
  {
    "nvim-lualine/lualine.nvim",
    config = function(_, opts)
      vim.o.laststatus = 0
      require("lualine").setup(opts)
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(function()
            require("lualine").setup(opts)
          end)
        end,
      })
    end,
    opts = {
      options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = {
          { "branch" },
          { "diff", colored = true },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = "●", readonly = "", unnamed = "No Name" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
          { "filetype" },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { left = "", right = "" },
          },
        },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    },
  },
}
