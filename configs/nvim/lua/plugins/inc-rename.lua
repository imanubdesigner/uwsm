return {
  "smjonas/inc-rename.nvim",
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing",
    })

    -- Mapping "Pulito": appare solo il comando, scrivi tu da zero
    vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Incremental Rename" })
  end,
}
