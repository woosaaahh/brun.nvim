local harpoon_term = require("harpoon.term")
local utils = require("brun.utils")
local M = {}

local function callback(termnr, command, args)
	if args ~= nil then
		command = string.gsub(command, "<file>", args.file)
		command = string.gsub(command, "<match>", args.match)
	end

	harpoon_term.sendCommand(termnr, command)
end

M.run = function()
	local file = vim.fn.expand("%")

	local termnr = utils.ask_for_number("Term number ? ", 1)
	if termnr == nil then
		vim.api.nvim_err_writeln("You must provide a terminal number")
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
		callback(termnr, command, args)
	end)
end

return M
