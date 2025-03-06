return {
	"neovim/nvim-lspconfig",
	-- For clangd setup on arm - https://github.com/mason-org/mason-registry/issues/5800#issuecomment-2156640019
	-- opts = {
	-- 	servers = {
	-- 		clangd = {
	-- 			mason = false,
	-- 		},
	-- 	},
	-- },

	branch = "master",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					-- REQUIRED - must specify a snippet engine
					vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
					-- require("luasnip").lsp_expand(args.body)
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
				["<C-o>"] = cmp.mapping.abort(),
				-- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
				-- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				-- { name = "luasnip" },
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
				local opts = { buffer = event.buf }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts)
			end,
		})

		-- Mason
		require("mason").setup({})
		-- https://github.com/williamboman/mason.nvim/issues/1881
		require("mason-lspconfig").setup({})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,

			-- Dedicated handlers for specific servers below
			-- Python environment
			-- ["pyright"] = function() end,

			-- local util = require("lspconfig/util")
			-- local path = util.path
			-- require("lspconfig").pyright.setup({
			-- 	on_attach = on_attach,
			-- 	capabilities = capabilities,
			-- 	before_init = function(_, config)
			-- 		default_venv_path = path.join(vim.env.HOME, ".venv", "bin", "python")
			-- 		config.settings.python.pythonPath = default_venv_path
			-- 	end,
			-- })
		})

		-- VIM DIAGNOSTICS SETUP
		-- vim.diagnostic.config({
		-- 	virtual_text = false,
		-- 	signs = true,
		-- 	underline = true,
		-- 	update_in_insert = false,
		-- 	severity_sort = false,
		-- })
	end,
}
