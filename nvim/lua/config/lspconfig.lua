local M ={}

function M.setup()
	local status, nvim_lsp = pcall(require, "lspconfig")
	if (not status) then return end

	local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

	vim.api.nvim_create_autocmd('LspAttach', {
		group = lsp_cmds,
		desc = 'LSP actions',
		callback = function()
			local bufmap = function(mode, lhs, rhs)
				vim.keymap.set(mode, lhs, rhs, {buffer = true})
			end

			bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
			bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
			bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
			bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
			bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
			bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
			bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
			bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
			bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
			bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
			bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
			bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
			bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
		end
	})
	local lsp_defaults = nvim_lsp.util.default_config

	lsp_defaults.capabilities = vim.tbl_deep_extend(
		'force',
		lsp_defaults.capabilities,
		require('cmp_nvim_lsp').default_capabilities()
	)
	require('mason').setup({})
	require('mason-lspconfig').setup({
		ensure_installed = {
			'tsserver',
			'eslint',
			'html',
			'cssls',
			'clangd'
		}
	})

	require('mason-lspconfig').setup_handlers({
		function(server)
			nvim_lsp[server].setup({})
		end,
		['tsserver'] = function()
			nvim_lsp.tsserver.setup({
				settings = {
					completions = {
						completeFunctionCalls = true
					}
				}
			})
		end,
		['clangd'] = function()
			nvim_lsp.clangd.setup{}
		end
	})
	-- local on_attach = function(client, bufnr)
	-- 	-- format on save
	-- 	if client.server_capabilities.documentFormattingProvider then
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = vim.api.nvim_create_augroup("Format", { clear = true }),
	-- 			buffer = bufnr,
	-- 			callback = function() vim.lsp.buf.formatting_seq_sync() end
	-- 		})
	-- 	end
	-- end
	--
	-- -- TypeScript
	-- nvim_lsp.tsserver.setup {
	-- 	on_attach = on_attach,
	-- 	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	-- 	cmd = { "typescript-language-server", "--stdio" }
	-- }
	--
	-- --Clangd
	-- nvim_lsp.clangd.setup{}

end

return M
