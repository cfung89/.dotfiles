local marks_file = vim.fn.stdpath("data") .. "/marks.json"
local marks_table = {}

vim.cmd("highlight MarkHighlight guifg=#00F102 guibg=NONE")
-- vim.cmd("highlight MarkHighlight guifg=#00DDF9 guibg=NONE") -- light blue

local load_marks = function()
	local f = io.open(marks_file, "r")
	if f then
		local content = f:read("*a")
		f:close()
		if content and content ~= "" then
			local ok, data = pcall(vim.fn.json_decode, content)
			if ok and type(data) == "table" then
				marks_table = data

				for char, mark_id in pairs(marks_table) do
					local buf = vim.api.nvim_get_current_buf()
					local mark = vim.api.nvim_buf_get_mark(buf, char)
					local lnum = mark[1]
					vim.fn.sign_define("mark-" .. char, { text = char, texthl = "MarkHighlight" })
					if lnum > 0 then
						vim.fn.sign_place(mark_id, "mark-group", "mark-" .. char, buf, { lnum = lnum, priority = 10 })
					end
				end
			end
		end
	end
end


local save_marks = function()
	local f = io.open(marks_file, "w")
	if f then
		f:write(vim.fn.json_encode(marks_table))
		f:close()
	end
end

---@param char string
local create_mark = function(char)
	vim.cmd { cmd = 'mark', args = { char } }

	local buf = vim.api.nvim_get_current_buf()
	vim.fn.sign_define("mark-" .. char, { text = char, texthl = "MarkHighlight" })
	local mark = vim.api.nvim_buf_get_mark(buf, char)
	local mark_id = marks_table[char]
	if mark_id then
		vim.fn.sign_unplace("mark-group", { id = mark_id })
	end

	local lnum = mark[1]
	if lnum > 0 then
		mark_id = vim.fn.sign_place(mark_id, "mark-group", "mark-" .. char, buf, { lnum = lnum, priority = 10 })
	end
	marks_table[char] = mark_id
	save_marks()
	vim.print("Created mark " .. char)
end

---@param char string
local delete_mark = function(char)
	vim.cmd { cmd = 'delm', args = { char } }

	local mark_id = marks_table[char]
	if not mark_id then
		print("Mark '" .. char .. "' not found.")
		return
	end
	-- vim.fn.sign_unplace("mark-group", { buffer = buf, lnum = line })
	vim.fn.sign_unplace("mark-group", { id = mark_id })
	marks_table[char] = nil
	save_marks()
	vim.print("Deleted mark " .. char)
end

local delete_all_marks = function()
	vim.fn.sign_unplace("mark-group")
	marks_table = {}
	save_marks()
end

vim.api.nvim_create_user_command("DeleteMarks", delete_all_marks, { desc = "Delete all marks" })

vim.keymap.set("n", "m", function()
	local char = string.char(vim.fn.getchar())
	create_mark(char)
end, { desc = "Create mark." })

vim.keymap.set("n", "dm", function()
	local char = string.char(vim.fn.getchar())
	delete_mark(char)
end, { desc = "Delete mark." })

load_marks()
