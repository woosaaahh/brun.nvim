local utils = require("brun.utils")
local M = {}

local function callback(bufnr, command, args)
	if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	if args ~= nil then
		command = string.gsub(command, "<file>", args.file)
		command = string.gsub(command, "<match>", args.match)
	end
	command = vim.split(command, " ")

	local append_data = function(_, data)
		if data then
			vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
		end
	end

	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "$ " .. table.concat(command, " ") })
	vim.fn.jobstart(command, {
		stdout_buffered = true,
		on_stdout = append_data,
		on_stderr = append_data,
	})
end

M.run = function()
	local file = vim.fn.expand("%")

	local bufnr = utils.ask_for_number("Buffer number ? ", utils.get_first_empty_buffer())
	local buflisted = pcall(vim.api.nvim_buf_get_option, bufnr, "buflisted")
	if type(bufnr) ~= "number" or buflisted == false then
		vim.api.nvim_err_writeln(string.format("Invalid buffer number : %s", bufnr))
		return
	end

	local command = utils.ask_for_text("Command ? ")
	if command == nil then
		vim.api.nvim_err_writeln("You must provide a command")
		return
	end
	command = string.gsub(command, "%%", "./" .. vim.fn.fnamemodify(file, ":~:."))

	local pattern = utils.ask_for_text("Pattern ?", file)
	if pattern == nil then
		vim.api.nvim_err_writeln("You must provide a pattern")
		return
	end

	utils.create_autocmd(pattern, function(args)
		callback(bufnr, command, args)
	end)
end

return M
