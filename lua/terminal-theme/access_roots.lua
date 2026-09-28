local M = {}

local namespace = vim.api.nvim_create_namespace("terminal-theme-access-roots")
local augroup = "TerminalThemeAccessRoots"
local theme_name = "terminal-theme"

local parsers = {
	go = "go",
	javascript = "javascript",
	javascriptreact = "tsx",
	lua = "lua",
	typescript = "typescript",
	typescriptreact = "tsx",
}

local function clear_buffer(buf)
	if vim.api.nvim_buf_is_valid(buf) then
		vim.api.nvim_buf_clear_namespace(buf, namespace, 0, -1)
	end
end

local function clear_all()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		clear_buffer(buf)
	end
end

local function receiver(node)
	local node_type = node:type()
	if node_type == "selector_expression" then
		return node:field("operand")[1]
	elseif node_type == "member_expression" then
		return node:field("object")[1]
	elseif node_type == "dot_index_expression" or node_type == "method_index_expression" then
		return node:field("table")[1]
	end
	return nil
end

local function member_name(node)
	local node_type = node:type()
	if node_type == "selector_expression" then
		return node:field("field")[1]
	elseif node_type == "member_expression" then
		return node:field("property")[1]
	elseif node_type == "dot_index_expression" then
		return node:field("field")[1]
	elseif node_type == "method_index_expression" then
		return node:field("method")[1]
	end
	return nil
end

local function root_expression(node)
	local root = receiver(node)
	while root and receiver(root) do
		root = receiver(root)
	end
	return root
end

local function mark(buf, node, hl_group, priority, seen)
	local start_row, start_col, end_row, end_col = node:range()
	local key = table.concat({ start_row, start_col, end_row, end_col }, ":")
	if seen[key] then
		return
	end

	seen[key] = true
	vim.api.nvim_buf_set_extmark(buf, namespace, start_row, start_col, {
		end_row = end_row,
		end_col = end_col,
		hl_group = hl_group,
		priority = priority,
	})
end

local function visit(buf, node, seen)
	local name = member_name(node)
	if name then
		-- Explicitly keep member labels smoky white even if another query still
		-- colors an enclosing receiver expression gray.
		mark(buf, name, "@variable", 200, seen.members)
	end

	if receiver(node) then
		local root = root_expression(node)
		if root then
			-- The root wins if it includes a member name, such as a parenthesized
			-- root expression.
			mark(buf, root, "@variable.receiver", 210, seen.roots)
		end
	end

	for index = 0, node:child_count() - 1 do
		visit(buf, node:child(index), seen)
	end
end

local function refresh(buf)
	if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
		return
	end
	clear_buffer(buf)

	if vim.g.colors_name ~= theme_name then
		return
	end

	local parser_name = parsers[vim.bo[buf].filetype]
	if not parser_name then
		return
	end

	local ok, parser = pcall(vim.treesitter.get_parser, buf, parser_name)
	if not ok or not parser then
		return
	end

	local parsed, trees = pcall(function()
		return parser:parse()
	end)
	if not parsed or not trees or not trees[1] then
		return
	end

	visit(buf, trees[1]:root(), { members = {}, roots = {} })
end

local function refresh_all()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		refresh(buf)
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup(augroup, { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "FileType", "TextChanged", "TextChangedI" }, {
		group = group,
		callback = function(args)
			refresh(args.buf)
		end,
	})
	vim.api.nvim_create_autocmd("ColorSchemePre", {
		group = group,
		callback = clear_all,
	})
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = function()
			if vim.g.colors_name == theme_name then
				refresh_all()
			end
		end,
	})
	refresh_all()
end

return M
