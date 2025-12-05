return {
  'seblyng/roslyn.nvim',
  ---@type RoslynNvimConfig
  opts = {
    -- Auto-pick a target to avoid the "Multiple potential target files found" message.
    -- New strategy (closest upward solution):
    --   1. If only one target, use it.
    --   2. Collect only .sln files; if none, fallback to first target.
    --   3. From .sln files that are ANCESTORS of current buffer path, pick the DEEPEST (longest path / most separators).
    --   4. If no ancestor .sln matches, fallback to deepest .sln overall.
    --   5. Tie-break lexicographically.
    choose_target = function(targets)
      if #targets == 0 then return nil end
      if #targets == 1 then return targets[1] end
      local buf = vim.api.nvim_buf_get_name(0)
      if buf == '' then buf = vim.loop.cwd() end

      local slns = {}
      for _, t in ipairs(targets) do
        if t:match('%.sln$') then
          slns[#slns + 1] = t
        end
      end
      if #slns == 0 then return targets[1] end
      if #slns == 1 then return slns[1] end

      local function is_ancestor(sln, path)
        local dir = sln:gsub('[^/\\]+$', '') -- remove filename
        return path:sub(1, #dir) == dir
      end
      local function depth(p)
        local _, count = p:gsub('[/\\]', '')
        return count
      end

      local ancestors = {}
      for _, s in ipairs(slns) do
        if is_ancestor(s, buf) then ancestors[#ancestors + 1] = s end
      end
      local candidates = (#ancestors > 0) and ancestors or slns
      table.sort(candidates, function(a, b)
        local da, db = depth(a), depth(b)
        if da ~= db then return da > db end -- deeper wins
        return a < b
      end)
      return candidates[1]
    end,

    -- Set to true if some projects live outside the solution directory tree.
    broad_search = false,

    -- Keep notifications (set to true to silence).
    silent = false,
  },
  config = function(_, opts)
    require('roslyn').setup(opts)

    -- Optional keymap to manually switch later if auto-picked wrong one.
    vim.keymap.set('n', '<leader>rt', ':Roslyn target<CR>', { desc = 'Roslyn: choose target' })
    -- Register which-key label for Roslyn (array-style full-key entry)
    do
      local ok, wk = pcall(require, 'which-key')
      if ok and wk then
        wk.add({
          { 'rt', desc = 'Roslyn: choose target' },
        })
      end
    end
  end,
}
