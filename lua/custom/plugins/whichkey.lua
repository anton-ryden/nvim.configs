-- Plugin spec for which-key and leader mappings
-- Loaded eagerly so leader registrations are available early
return {
  'folke/which-key.nvim',
  lazy = false,
  config = function()
    local ok, wk = pcall(require, 'which-key')
    if not ok or not wk then
      return
    end

    -- Basic setup: make which-key trigger on <leader>
    wk.setup({ triggers = { '<leader>' } })

    -- Keep which-key setup minimal here. Per-plugin modules register their
    -- own labels/descriptions so we avoid duplicate registrations.
  end,
}
