local M = {}

---Switch function
---@param x string
---@param cases table
---@param run boolean
---@return function
local switch = function(x, cases, run)
	local match = cases[x] or cases.default or function() end
	if run then
		match()
	end
	return match
end

--- Validates that a range has exactly two positions, each containing two elements (row, col).
---@param range (table) A table containing two position tables:
---  - `range[1]` is the start position `{row, col}`.
---  - `range[2]` is the end position `{row, col}`.
---@return boolean
local validate_range = function(range)
	assert(range ~= nil, "Assertion Error: range is nil")
	assert(#range == 2, "Assertion Error: range must contain exactly two positions")
	assert(#range[1] == 2, "Assertion Error: range[1] must contain exactly two positions")
	assert(#range[2] == 2, "Assertion Error: range[2] must contain exactly two positions")
	return true
end

---Get user input character.
---@return integer
local get_input = function()
	local success, c = pcall(vim.fn.getchar)
	if not success then
		return 0
	end
	if type(c) ~= "number" then
		vim.print("Invalid input character.")
		return 0
	end
	return c
end

---Gets coordinates of Visual mode selection
---@return table
local get_visual = function()
	local _, row0, col0 = unpack(vim.fn.getpos("v"))
	local _, row1, col1 = unpack(vim.fn.getpos("."))
	return { { row0, col0 }, { row1, col1 } }
end

---Insert text at specific coordinates
---@param input string
---@param row integer
---@param col integer
local insert = function(input, row, col)
	if not pcall(vim.api.nvim_buf_set_text, 0, row, col, row, col, { input }) then
		vim.api.nvim_buf_set_text(0, row, col - 1, row, col - 1, { input })
	end
end

---@param opening string
---@param closing string
---@param range table
local insert_surround = function(opening, closing, range)
	validate_range(range)
	local row0, col0 = unpack(range[1])
	local row1, col1 = unpack(range[2])
	insert(closing, row1 - 1, col1)
	insert(opening, row0 - 1, col0 - 1)
end

---@param opening string
---@param closing string
---@param range table
local iter_surround_block = function(opening, closing, range)
	validate_range(range)
	local row0, col0 = unpack(range[1])
	local row1, col1 = unpack(range[2])
	for i = row0, row1 do
		insert_surround(opening, closing, { { i, col0 }, { i, col1 } })
	end
end

---Surround Visual Block mode selection with the given character or use additional functionality.
---@param char string
---@param range table
---@return function
local surround_block = function(char, range)
	validate_range(range)
	local row0, col0 = unpack(range[1])
	local row1, col1 = unpack(range[2])
	if row0 > row1 then
		row0, row1 = row1, row0
	end
	if col0 > col1 then
		col0, col1 = col1, col0
	end
	range = { { row0, col0 }, { row1, col1 } }
	local surround_map = {
		["("] = function()
			iter_surround_block("( ", " )", range)
		end,
		[")"] = function()
			iter_surround_block("(", ")", range)
		end,
		["["] = function()
			iter_surround_block("[ ", " ]", range)
		end,
		["]"] = function()
			iter_surround_block("[", "]", range)
		end,
		["{"] = function()
			iter_surround_block("{ ", " }", range)
		end,
		["}"] = function()
			iter_surround_block("{", "}", range)
		end,
		["<"] = function()
			iter_surround_block("< ", " >", range)
		end,
		[">"] = function()
			iter_surround_block("<", ">", range)
		end,
		["S"] = function()
			local input = vim.fn.input("Enter input: ")
			if string.sub(input, 1, 1) == "<" and string.sub(input, -1) == ">" then
				iter_surround_block(input, string.sub(input, 1, 1) .. "/" .. string.sub(input, 2), range)
			else
				iter_surround_block(input, input, range)
			end
		end,
		default = function()
			iter_surround_block(char, char, range)
		end,
	}
	return switch(char, surround_map, true)
end

---Surround Visual mode selection with the given character or use additional functionality.
local surround = function()
	local c = get_input()
	if c == 0 then
		return
	end
	local char = string.char(c)
	local selection = get_visual()
	validate_range(selection)

	-- top left to bottom right
	local row0, col0 = unpack(selection[1])
	local row1, col1 = unpack(selection[2])
	if row0 > row1 or (row0 == row1 and col0 > col1) then
		row0, row1 = row1, row0
		col0, col1 = col1, col0
	end
	local range = { { row0, col0 }, { row1, col1 } }
	local surround_map = {
		["("] = function()
			insert_surround("( ", " )", range)
		end,
		[")"] = function()
			insert_surround("(", ")", range)
		end,
		["["] = function()
			insert_surround("[ ", " ]", range)
		end,
		["]"] = function()
			insert_surround("[", "]", range)
		end,
		["{"] = function()
			insert_surround("{ ", " }", range)
		end,
		["}"] = function()
			insert_surround("{", "}", range)
		end,
		["<"] = function()
			insert_surround("< ", " >", range)
		end,
		[">"] = function()
			insert_surround("<", ">", range)
		end,
		["B"] = function()
			local newC = get_input()
			if newC == 0 then
				return
			end
			return surround_block(string.char(newC), selection)
		end,
		["S"] = function()
			local input = vim.fn.input("Enter input: ")
			if string.sub(input, 1, 1) == "<" and string.sub(input, -1) == ">" then
				insert(string.sub(input, 1, 1) .. "/" .. string.sub(input, 2), row1 - 1, col1)
				insert(input, row0 - 1, col0 - 1)
			else
				insert_surround(input, input, range)
			end
		end,
		default = function()
			insert_surround(char, char, range)
		end,
	}
	switch(char, surround_map, true)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
end

vim.api.nvim_create_user_command("Surround", surround, { desc = "Surround selected text by the given input" })
vim.keymap.set("v", "S", "<cmd>Surround<CR>")
