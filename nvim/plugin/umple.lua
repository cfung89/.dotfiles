vim.filetype.add({ extension = { ump = "umple" } })

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.inference = {
	install_info = {
		url = "~/Github/tree-sitter-umple/",
		branch = "main",
		files = { "src/parser.c" },
		-- generate_requires_npm = false
	},
	filetype = ".ump"
}
