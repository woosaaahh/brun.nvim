local default = require("brun.default")
local brun_harpoon = require("brun.harpoon")

local all_runners = {
	harpoon = brun_harpoon.run,
}

local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("BRun", function(args)
		local run = all_runners[args.args]

		if type(run) == "function" then
			run()
		else
			default.run()
		end
	end, { nargs = "?" })
end

return M
