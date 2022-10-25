local M = {}

M.ask_for_number = function(msg, default)
	if default ~= nil then
		msg = msg .. string.format(" (default: %s) ", default)
	end

	local input = vim.fn.input(msg)
	if input == "" then
		return tonumber(default)
	else
		return tonumber(input)
	end
end

M.ask_for_text = function(msg, default)
	if default ~= nil then
		msg = msg .. string.format(" (default: %s) ", default)
	end

	local input = vim.fn.input(msg)
	if input == "" and type(default) == "string" then
		return default
	elseif input == "" then
		return nil
	else
		return input
	end
end

M.create_autocmd = function(pattern, callback)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("BRun", { clear = false }),
		pattern = pattern,
		callback = callback,
	})
end

M.get_first_empty_buffer = function()
	local suggested_bufnr = nil
	for _, bufnr in pairs(vim.api.nvim_list_bufs()) do
		local buf = vim.fn.getbufinfo(bufnr)[1]
		if buf.hidden == 0 and buf.loaded == 1 and buf.name == "" then
			suggested_bufnr = string.format("%s", bufnr)
			break
		end
	end
	return suggested_bufnr
end

return M
