-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Load custom plugin specs (each file should return a plugin spec table)
return {
	-- which-key configuration moved here so it can load early and register leader mappings
	require('custom.plugins.whichkey'),
}
