return {
  {
    "lambdalisue/vim-suda",
    config = function()
      -- Configurations below
      vim.g.suda_smart_edit = 1

      -- Map keys
      -- <ladder>ws for saving
      vim.api.nvim_set_keymap("n", "<leader>ws", ":SudaWrite<CR>", { noremap = true, silent = true })
      -- <ladder>rs to open a file
      vim.api.nvim_set_keymap("n", "<leader>rs", ":SudaRead<CR>", { noremap = true, silent = true })
    end,
  },
}
