return {
	"neovim/nvim-lspconfig",
	-- For clangd setup on arm - https://github.com/mason-org/mason-registry/issues/5800#issuecomment-2156734203

	branch = "master",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{
			"hrsh7th/nvim-cmp",
			commit = "1e1900b",
		},
		"L3MON4D3/LuaSnip",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{
			"folke/lazydev.nvim", -- LSP for vim
			ft = "lua",  -- only load on lua files
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					-- REQUIRED - must specify a snippet engine
					vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-q>"] = cmp.mapping.abort(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
			}, {
				{ name = "buffer" },
			}),
			-- performance = {
			-- 	max_view_entries = 5,
			-- },
		})

		-- LSP Keybind Setup
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP keybindings",
			callback = function(event)
				local map = function(keys, func, desc)
					local opts = { buffer = event.buf, desc = "LSP: " .. desc }
					vim.keymap.set("n", keys, func, opts)
				end
				local builtin = require("telescope.builtin")

				map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
				map("gr", builtin.lsp_references, "[G]oto [R]eferences")
				map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
				map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>dd", function() vim.diagnostic.open_float() end, "Open Diagnostic Window")
				map("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Goto Next Diagnostic")
				map("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Goto Previous Diagnostic")
			end,
		})

		-- Vim diagnostics setup
		vim.diagnostic.config({
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		})

		-- Mason
		require("mason").setup({})
		-- https://github.com/williamboman/mason.nvim/issues/1881

		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			automatic_enable = true,
		})
		-- require("lspconfig")["gopls"].setup({ behavior = cmp.ConfirmBehavior.Insert })
	end,
}
