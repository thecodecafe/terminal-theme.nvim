local M = {}

function M.load()
	vim.o.background = "dark"
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end

	require("terminal-theme.highlights").apply()
	vim.g.colors_name = "terminal-theme"
	require("terminal-theme.go_imports").setup()
	require("terminal-theme.access_roots").setup()
end

return M
