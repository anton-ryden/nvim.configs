-- Quickfix enhancements & keymaps live here. To add more plugins, append to the table.
return {
	{
		'kevinhwang91/nvim-bqf',
		ft = 'qf',
		config = function()
			-- Helper to toggle the quickfix window
			local function toggle_qf()
				for _, win in ipairs(vim.fn.getwininfo()) do
					if win.quickfix == 1 then
						vim.cmd('cclose')
						return
					end
				end
				vim.cmd('copen')
			end

			local map = vim.keymap.set
			-- All start with <leader>q
			map('n', '<leader>qo', '<cmd>copen<CR>', { desc = '[Q]uickfix [O]pen' })
			map('n', '<leader>qc', '<cmd>cclose<CR>', { desc = '[Q]uickfix [C]lose' })
			map('n', '<leader>qt', toggle_qf,        { desc = '[Q]uickfix [T]oggle' })
			map('n', '<leader>qn', '<cmd>cnext<CR>', { desc = '[Q]uickfix [N]ext' })
			map('n', '<leader>qp', '<cmd>cprev<CR>', { desc = '[Q]uickfix [P]revious' })
			-- Optional extras (first/last). Uncomment if desired:
			-- map('n', '<leader>qf', '<cmd>cfirst<CR>', { desc = '[Q]uickfix [F]irst' })
			-- map('n', '<leader>ql', '<cmd>clast<CR>',  { desc = '[Q]uickfix [L]ast' })

			-- Minimal bqf setup (uses defaults); customize here if needed
			-- require('bqf').setup {}
		end,
	},
}
