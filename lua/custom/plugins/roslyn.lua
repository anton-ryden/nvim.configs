return {
  'seblyng/roslyn.nvim',
  config = function()
    local sln = vim.fs.find('*.sln', { upward = true })[1]
    require('roslyn').setup({
      solution = sln,
      dotnet_path = 'dotnet',
      lsp = {
        semantic_tokens = true,
        inlay_hints = true,
        analyzers = true,
        formatting = true,
      },
    })
    if sln then
      vim.notify('[roslyn] Attached using solution: ' .. sln, vim.log.levels.INFO)
    else
      vim.notify('[roslyn] No .sln found, attempting project inference', vim.log.levels.WARN)
    end
  end,
}
