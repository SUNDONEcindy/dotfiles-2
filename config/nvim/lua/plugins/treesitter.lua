local ensure_installed = {
	'astro',
	'awk',
	'bash',
	'css',
	'dockerfile',
	'go',
	'gomod',
	'gosum',
	'hcl',
	'javascript',
	'json',
	'jsonc',
	'lua',
	'markdown',
	'markdown_inline',
	'python',
	'rego',
	'toml',
	'typescript',
	'vim',
	'vimdoc',
	'yaml',
}

return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	build = ':TSUpdate',
	lazy = false,
	config = function()
		require('nvim-treesitter').setup()

		local installed = require('nvim-treesitter').get_installed()
		local to_install = vim.tbl_filter(function(lang)
			return not vim.tbl_contains(installed, lang)
		end, ensure_installed)

		if #to_install > 0 then
			require('nvim-treesitter').install(to_install)
		end
	end,
}
