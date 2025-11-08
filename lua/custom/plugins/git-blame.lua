-- Lightweight inline/virtual git blame plugin configuration
-- Provides on-demand entire-file blame toggling via f-person/git-blame.nvim

return {
  'f-person/git-blame.nvim',
  event = 'BufReadPost',
  keys = {
    { '<leader>gb', function()
        vim.cmd.GitBlameToggle()
      end, desc = 'Toggle inline git blame' },
    { '<leader>gB', function()
        -- Open full file blame in vertical split (using built-in :Gitsigns blame_line alternative approach)
        local path = vim.api.nvim_buf_get_name(0)
        if path == '' then return end
        vim.cmd('vnew')
        local buf = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_name(buf, 'Blame:' .. path)
        vim.fn.jobstart({ 'git', 'blame', '--date=relative', path }, {
          stdout_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
            end
          end,
        })
        vim.bo[buf].buftype = 'nofile'
        vim.bo[buf].bufhidden = 'wipe'
        vim.bo[buf].swapfile = false
      end, desc = 'Open full-file git blame (relative dates)' },
  },
  opts = {
    enabled = false, -- start disabled (toggle enables)
    date_format = '%Y-%m-%d',
    message_template = '<author>, <date> • <summary>',
    virtual_text_column = 120,
  },
}
