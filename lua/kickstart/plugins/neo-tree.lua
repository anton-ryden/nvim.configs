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
    { '<leader>eG', '<cmd>Neotree git_status position=float<CR>', desc = 'Explorer: git status (float)' },
  },
  config = function()
    local commands = {}

    -- Open Diffview for the selected git status entry (file).
    commands.git_diffview = function(state)
      local node = state.tree:get_node()
      if not node then return end
      local path = node:get_id()
      -- Use DiffviewOpen with the path. If path is directory, just open generic diff.
      if vim.fn.isdirectory(path) == 1 then
        vim.cmd('DiffviewOpen')
      else
        vim.cmd('DiffviewOpen ' .. vim.fn.fnameescape(path))
      end
    end

    -- Open full-file blame in a scratch buffer using git blame
    commands.git_blame_file = function(state)
      local node = state.tree:get_node()
      if not node then return end
      local path = node:get_id()
      if vim.fn.isdirectory(path) == 1 then return end
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_name(buf, 'Git Blame: ' .. path)
      vim.api.nvim_set_current_buf(buf)
      vim.fn.jobstart({ 'git', 'blame', '--date=iso', path }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if not data then return end
          vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
        end,
        on_exit = function(_, code)
          if code ~= 0 then
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'git blame failed for ' .. path })
          end
        end,
      })
    end

    require('neo-tree').setup {
      sources = { 'filesystem', 'git_status' },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      git_status = {
        window = {
          position = 'left',
          mappings = {
            ['s'] = 'git_stage',            -- stage file
            ['u'] = 'git_unstage',          -- unstage file
            ['r'] = 'git_revert',           -- revert changes (checkout file)
            ['D'] = 'git_diffview',         -- open Diffview for file
            ['B'] = 'git_blame_file',       -- full file blame in scratch buffer
            ['<CR>'] = 'open',
          },
        },
        commands = commands,
      },
    }
    -- Auto-reveal current file on startup (keeps behavior from original config)
    vim.schedule(function()
      pcall(function()
        vim.cmd 'Neotree reveal'
      end)
    end)
  end,
}
