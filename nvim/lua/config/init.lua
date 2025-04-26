require("config.options")
require("config.keymaps")
require("config.lazy_init")
require("config.config")

require('lazy').setup({
	spec = 'config.plugins',
	change_detection = { notify = false },
	checker = { enabled = true, notify = false }
})
