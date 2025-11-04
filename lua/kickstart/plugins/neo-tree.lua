-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  event = 'VimEnter',
  keys = {
    { '<leader>et', '<cmd>Neotree toggle<CR>', desc = 'Explorer: toggle' },
    { '<leader>er', '<cmd>Neotree reveal<CR>', desc = 'Explorer: reveal file' },
    { '<leader>ef', '<cmd>Neotree focus<CR>', desc = 'Explorer: focus' },
    { '<leader>ec', '<cmd>Neotree close<CR>', desc = 'Explorer: close' },
    { '<leader>eg', '<cmd>Neotree git_status<CR>', desc = 'Explorer: git status' },
  },
  config = function()
    require('neo-tree').setup {
      filesystem = {
        filtered_items = { hide_dotfiles = false },
      },
    }
    -- Auto-open (använd reveal så aktuell fil visas)
    vim.schedule(function()
      pcall(function()
        vim.cmd 'Neotree reveal'
      end)
    end)
  end,
}
