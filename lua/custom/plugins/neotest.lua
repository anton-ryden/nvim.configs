return { -- For running test. Includes .NET adapter and keymaps.
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
  },
  config = function()
    local neotest = require('neotest')
    neotest.setup({
      adapters = {
        require('neotest-dotnet')({
          -- args = { '--filter', 'TestCategory!=Integration' },
          -- dap = { adapter_name = 'netcoredbg' },
        }),
      },
      output = { open_on_run = true },
      quickfix = { enabled = false },
      discovery = { enabled = true },
      status = { virtual_text = true },
      diagnostic = { enabled = true },
    })
    local map = vim.keymap.set
    map('n', '<leader>tr', function() neotest.run.run() end, { desc = '[T]est [R]un nearest' })
    map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = '[T]est [F]ile' })
    map('n', '<leader>tl', function() neotest.run.run_last() end, { desc = '[T]est run [L]ast' })
    map('n', '<leader>to', function() neotest.output.open({ enter = true }) end, { desc = '[T]est [O]utput' })
    map('n', '<leader>tt', function() neotest.summary.toggle() end, { desc = '[T]est [T]ree' })
    do
      local ok, wk = pcall(require, 'which-key')
      if ok and wk then
          wk.add({
            { '<leader>t', group = '[T]est' },
          })
      end
    end
  end,
}
