local M = {}
local config = {
  prefer_project = false,      -- if true prefer project over solution when both exist
  auto_open_qf = true,         -- open quickfix when there are build results
  commands = true,             -- create :Dotnet* commands
  keymaps = true,              -- register default keymaps
  autocommands = true,         -- set buffer-local makeprg for C# files
  custom_args = {              -- extra args appended per command kind
    build = {},
    clean = {},
    rebuild = {},
  },
  notify_level = vim.log.levels.INFO,
  dotnet_cmd = 'dotnet',       -- allow overriding path to dotnet
}

function M.setup(user_opts)
  if user_opts then
    config = vim.tbl_deep_extend('force', config, user_opts)
  end
  M.ensure_errorformat()
  if config.commands then M.register_commands() end
  if config.keymaps then M.register_keymaps() end
  if config.autocommands then M.register_autocmds() end
end

-- Locate a file upward matching any pattern
local function find_up(patterns)
  local dir = vim.fn.expand('%:p:h')
  local found = vim.fs.find(patterns, { path = dir, upward = true })
  return found[1]
end

function M.find_solution()
  return find_up({ '*.sln' })
end

function M.find_project()
  return find_up({ '*.csproj' })
end

-- Ensure msbuild style errorformat pattern exists
function M.ensure_errorformat()
  local efm = vim.opt.errorformat
  local efm_str = table.concat(efm:get(), '\n')
  if not efm_str:match('%%f%%(%l\\,%c%)') then
    efm:append('%f(%l\\,%c): %t%*[^:]: %m')
  end
end

-- Build the dotnet command based on kind
function M.make_dotnet_cmd(kind)
  local sln = M.find_solution()
  local proj = M.find_project()
  local target = (config.prefer_project and proj) or sln or proj
  local cmd = config.dotnet_cmd .. ' '
  local args_tbl = {}
  if kind == 'build' then
    cmd = cmd .. 'build'
    args_tbl = config.custom_args.build
  elseif kind == 'clean' then
    cmd = cmd .. 'clean'
    args_tbl = config.custom_args.clean
  elseif kind == 'rebuild' then
    cmd = cmd .. 'build -t:Rebuild'
    args_tbl = config.custom_args.rebuild
  elseif kind == 'build_solution' then
    cmd = cmd .. 'build'; target = sln
    args_tbl = config.custom_args.build
  elseif kind == 'build_project' then
    cmd = cmd .. 'build'; target = proj
    args_tbl = config.custom_args.build
  else
    cmd = cmd .. 'build'
    args_tbl = config.custom_args.build
  end
  if target then
    cmd = cmd .. ' "' .. target .. '"'
  end
  if args_tbl and #args_tbl > 0 then
    cmd = cmd .. ' ' .. table.concat(args_tbl, ' ')
  end
  return cmd, target
end

-- Execute :make with the generated command
function M.run(kind)
  local cmd, target = M.make_dotnet_cmd(kind)
  if not target and (kind == 'build_solution' or kind == 'build_project') then
    vim.notify('[dotnet] No matching target for ' .. kind, vim.log.levels.WARN)
    return
  end
  vim.bo.makeprg = cmd
  vim.notify('[dotnet] Running: ' .. cmd, config.notify_level)
  vim.cmd('make')
  vim.schedule(function()
    local qf = vim.fn.getqflist()
    if #qf > 0 and config.auto_open_qf then vim.cmd('copen') end
  end)
end

-- Register user commands
function M.register_commands()
  vim.api.nvim_create_user_command('DotnetBuild', function() M.run('build') end, { desc = 'Build nearest solution/project' })
  vim.api.nvim_create_user_command('DotnetClean', function() M.run('clean') end, { desc = 'Clean nearest solution/project' })
  vim.api.nvim_create_user_command('DotnetRebuild', function() M.run('rebuild') end, { desc = 'Rebuild nearest solution/project' })
  vim.api.nvim_create_user_command('DotnetBuildSolution', function() M.run('build_solution') end, { desc = 'Build nearest solution only' })
  vim.api.nvim_create_user_command('DotnetBuildProject', function() M.run('build_project') end, { desc = 'Build nearest project only' })
end

function M.register_keymaps()
  local map = vim.keymap.set
  -- Actual keymaps are created here using vim.keymap.set
  -- NOTE: The descriptions are correctly set here and will be picked up by which-key.
  map('n', '<leader>dB', '<cmd>DotnetBuild<CR>', { desc = '[D]otnet [B]uild (nearest)' })
  map('n', '<leader>dC', '<cmd>DotnetClean<CR>', { desc = '[D]otnet [C]lean (nearest)' })
  map('n', '<leader>dR', '<cmd>DotnetRebuild<CR>', { desc = '[D]otnet [R]ebuild (nearest)' })
  map('n', '<leader>dS', '<cmd>DotnetBuildSolution<CR>', { desc = '[D]otnet build [S]olution' })
  map('n', '<leader>dP', '<cmd>DotnetBuildProject<CR>', { desc = '[D]otnet build [P]roject' })

  do
    local ok, wk = pcall(require, 'which-key')
    if ok and wk then
      wk.add({
        { '<leader>d', group = 'Dotnet', icon = { icon = '󰌛', color = 'azure' } },        { '<leader>dB', desc = '󰔧 Build (nearest)' },
        { '<leader>dC', desc = '󰓌 Clean (nearest)' },
        { '<leader>dR', desc = '󰑐 Rebuild (nearest)' },
        { '<leader>dS', desc = '󰌷 Build Solution' },
        { '<leader>dP', desc = '󰉋 Build Project' },
      })
    end
  end
end

-- Autocommands
function M.register_autocmds()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cs',
    callback = function()
      local cmd = M.make_dotnet_cmd('build')
      vim.bo.makeprg = cmd
    end,
  })
end

-- Expose config for introspection
function M.get_config()
  return vim.deepcopy(config)
end

return M
