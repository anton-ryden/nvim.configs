-- dotnet build helper plugin spec loader
-- Loads the custom module that defines commands & keymaps.

-- Configure dotnet helper with optional overrides
require('custom.dotnet.build').setup({
	prefer_project = false,        -- set true to prefer .csproj over .sln when both exist
	auto_open_qf = true,           -- open quickfix if there are results
	custom_args = {
		build = { '--nologo' },      -- example: suppress logo
		clean = {},
		rebuild = {},
	},
	notify_level = vim.log.levels.INFO,
})

-- No external plugin spec needed; returning empty so lazy treats this as a noop spec file.
return {}