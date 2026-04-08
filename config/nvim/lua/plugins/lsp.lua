-- servers that need extra "settings"
local servers = {
	gopls = {},
	html = {},
	jsonls = {},
	dockerls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				disable = { "missing-fields", "inject-fields" },
				globals = { "vim", "Snacks" },
			},
		},
	},
	marksman = {},
	pyright = {},
	ruff = {},
	tailwindcss = {},
	ts_ls = {},
	vale_ls = { installVale = false },
	yamlls = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/docker/docker-agent/refs/heads/main/agent-schema.json"] = {
					'**/cagent*.yaml',
					'**/cagent*.yml',
					'**/*cagent*.yaml',
					'**/*cagent*.yml',
					'**/agent.yaml',
					'**/agent.yml',
					'**/agents.yaml',
					'**/agents.yml',
				}
			}
		}
	},
	astro = {},
	regal = {},
}

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then desc = 'LSP: ' .. desc end
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end
	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
	-- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	-- nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	-- nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
end

return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		opts = {
			ensure_installed = vim.tbl_keys(servers),
			automatic_enable = true,
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			-- enable inlay hints
			vim.lsp.inlay_hint.enable()

			-- global defaults
			vim.lsp.config("*", {
				on_attach = on_attach,
			})

			-- per-server settings
			for name, cfg in pairs(servers) do
				if cfg and next(cfg) ~= nil then
					vim.lsp.config(name, { settings = cfg })
				end
			end

			require("lsp_lines").setup()
			vim.diagnostic.config { virtual_text = true, virtual_lines = false }

			vim.keymap.set("", "<leader>l", function()
				local config = vim.diagnostic.config() or {}
				if config.virtual_text then
					vim.diagnostic.config { virtual_text = false, virtual_lines = true }
				else
					vim.diagnostic.config { virtual_text = true, virtual_lines = false }
				end
			end, { desc = "Toggle lsp_lines" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				on_attach = on_attach,
				sources = {
					null_ls.builtins.diagnostics.markdownlint,
					null_ls.builtins.formatting.prettier,
				},
			})
		end
	},
}
