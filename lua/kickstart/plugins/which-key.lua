return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ', Down = '<Down> ', Left = '<Left> ', Right = '<Right> ',
        C = '<C-…> ', M = '<M-…> ', D = '<D-…> ', S = '<S-…> ', CR = '<CR> ', Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ', ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ', BS = '<BS> ', Space = '<Space> ', Tab = '<Tab> ',
        F1 = '<F1>', F2 = '<F2>', F3 = '<F3>', F4 = '<F4>', F5 = '<F5>', F6 = '<F6>', F7 = '<F7>', F8 = '<F8>', F9 = '<F9>', F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
      },
    },
    spec = {
      { '<leader>s', group = 'Search', icon = { icon = '🔍', color = 'green' } },
      { '<leader>t', group = 'Toggle', icon = { icon = '', color = 'blue' } },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' }, icon = { icon = '', color = 'orange' } },
    },
  },
}
