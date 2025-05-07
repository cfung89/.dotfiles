local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local config = require("telescope.config").values

local M = {}

---@param opts table | nil
local multigrep = function(opts)
	opts = opts or {}
	opts.cwd = opts.cwd or vim.uv.cwd()

	local finder = finders.new_async_job({
		command_generator = function(prompt)
			if not prompt or prompt == "" then
				return nil
			end
			local pieces = vim.split(prompt, "  ")
			local args = { "rg" } -- ripgrep
			if pieces[1] then
				table.insert(args, "-e") -- ripgrep opt for pattern matching
				table.insert(args, pieces[1])
			end
			if pieces[2] then
				table.insert(args, "-g") -- ripgrep glob files
				table.insert(args, pieces[2])
			end

			---@diagnostic disable-next-line: deprecated
			return vim.tbl_flatten({
				args,
				{ "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
			})
		end,
		entry_maker = make_entry.gen_from_vimgrep(opts),
		cwd = opts.cwd,
	})

	pickers
		.new(opts, {
			debounce = 100,
			prompt_title = "Multi Grep",
			finder = finder,
			previewer = config.grep_previewer(opts), -- get normal previewer
			sorter = require("telescope.sorters").empty(), -- no sort, will be sorted automatically by rg
		})
		:find()
end

M.setup = function()
	vim.keymap.set("n", "<leader>fg", multigrep)
end

return M
