---@param x string
---@param cases table
---@return nil
local function switch(x, cases)
	local match = cases[x] or cases.default or function() end
	return match()
end

---@return integer[]
local get_visual = function()
	local _, row0, col0 = unpack(vim.fn.getpos('v'))
	local _, row1, col1 = unpack(vim.fn.getpos('.'))
	return { row0, col0, row1, col1 }
end

---@param input string
---@param row integer
---@param col integer
---@return nil
local insert = function(input, row, col)
	vim.api.nvim_buf_set_text(0, row, col, row, col, { input })
end

local surround = function()
	local c = vim.fn.getchar()
	if type(c) ~= "number" then
		vim.print("Invalid input character.")
		return
	end
	local char = string.char(c)
	local selection = get_visual()
	if selection == nil then
		vim.print("error")
		return
	end
	local row0, col0, row1, col1 = unpack(selection)
	if row0 > row1 or (row0 == row1 and col0 > col1) then
		row0, row1 = row1, row0
		col0, col1 = col1, col0
	end
	switch(char, {
		["("] = function()
			insert(" )", row1 - 1, col1)
			insert("( ", row0 - 1, col0 - 1)
		end,
		[")"] = function()
			insert(")", row1 - 1, col1)
			insert("(", row0 - 1, col0 - 1)
		end,
		["["] = function()
			insert(" ]", row1 - 1, col1)
			insert("[ ", row0 - 1, col0 - 1)
		end,
		["]"] = function()
			insert("]", row1 - 1, col1)
			insert("[", row0 - 1, col0 - 1)
		end,
		["{"] = function()
			insert(" }", row1 - 1, col1)
			insert("{ ", row0 - 1, col0 - 1)
		end,
		["}"] = function()
			insert("}", row1 - 1, col1)
			insert("{", row0 - 1, col0 - 1)
		end,
		["<"] = function()
			insert(" >", row1 - 1, col1)
			insert("< ", row0 - 1, col0 - 1)
		end,
		[">"] = function()
			insert(">", row1 - 1, col1)
			insert("<", row0 - 1, col0 - 1)
		end,
		["S"] = function()
			local input = vim.fn.input("Enter input: ")
			if string.sub(input, 1, 1) == "<" and string.sub(input, -1) == ">" then
				insert(string.sub(input, 1, 1) .. "/" .. string.sub(input, 2), row1 - 1, col1)
				insert(input, row0 - 1, col0 - 1)
			else
				insert(input, row1 - 1, col1)
				insert(input, row0 - 1, col0 - 1)
			end
		end,
		default = function()
			insert(char, row1 - 1, col1)
			insert(char, row0 - 1, col0 - 1)
		end
	})
end

vim.api.nvim_create_user_command("Surround", surround, { desc = "Surround selected text by the given input" })
vim.keymap.set("v", "S", "<cmd>Surround<CR>")
