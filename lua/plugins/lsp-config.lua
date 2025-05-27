return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "cssls", "emmet_ls", "html", "jsonls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Config LSPs
			lspconfig.lua_ls.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.cssls.setup({ capabilities = capabilities })
			lspconfig.emmet_ls.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })

			-- Keyboard Maps
			vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode Goto [R]eferences" }
			)
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode Goto [I]mplementations" }
			)
			vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })

			-- Show diagnostics display automatically
			-- Reduce the time to trigger the CursorHold
			vim.o.updatetime = 250

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 2,
					severity = vim.diagnostic.severity.ERROR,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Open diagnostic automatically in floating window
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function()
					vim.diagnostic.open_float(nil, {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = "",
						scope = "cursor",
					})
				end,
			})
		end,
	},
}
