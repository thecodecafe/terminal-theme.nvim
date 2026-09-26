local M = {}

local namespace = vim.api.nvim_create_namespace("terminal-theme-go-import-suffix")
local augroup = "TerminalThemeGoImportSuffix"
local theme_name = "terminal-theme"

local function field(node, name)
	local matches = node:field(name)
	return matches and matches[1]
end

local function final_segment_start(source)
	local quote = source:sub(1, 1)
	if (quote ~= '"' and quote ~= "`") or source:sub(-1) ~= quote then
		return nil
	end

	local content_end = #source
	local segment_start = 2
	local index = 2
	while index < content_end do
		local char = source:sub(index, index)
		if char == "/" then
			segment_start = index + 1
			index = index + 1
		elseif char == "\\" and quote == '"' then
			local escape = source:sub(index + 1, index + 1)
			local width = 2
			local value
			if escape == "x" then
				width = 4
				value = tonumber(source:sub(index + 2, index + 3), 16)
			elseif escape == "u" then
				width = 6
				value = tonumber(source:sub(index + 2, index + 5), 16)
			elseif escape == "U" then
				width = 10
				value = tonumber(source:sub(index + 2, index + 9), 16)
			elseif escape:match("^[0-7]$") then
				width = 4
				value = tonumber(source:sub(index + 1, index + 3), 8)
			end

			if value == 47 then
				segment_start = index + width
			end
			index = index + width
		else
			index = index + 1
		end
	end

	if segment_start >= content_end then
		return nil
	end
	return segment_start - 1
end

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

local function mark_import_suffix(buf, import_spec)
	if field(import_spec, "name") then
		return
	end

	local path = field(import_spec, "path")
	if not path then
		return
	end

	local start_row, start_col, end_row, end_col = path:range()
	if start_row ~= end_row then
		return
	end

	local source = table.concat(vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {}))
	local offset = final_segment_start(source)
	if not offset then
		return
	end

	vim.api.nvim_buf_set_extmark(buf, namespace, start_row, start_col + offset, {
		end_row = end_row,
		end_col = end_col - 1,
		hl_group = "@variable.receiver",
		priority = 200,
	})
end

local function visit(buf, node)
	if node:type() == "import_spec" then
		mark_import_suffix(buf, node)
	end

	for index = 0, node:child_count() - 1 do
		visit(buf, node:child(index))
	end
end

local function refresh(buf)
	if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
		return
	end
	if vim.g.colors_name ~= theme_name or vim.bo[buf].filetype ~= "go" then
		clear_buffer(buf)
		return
	end

	clear_buffer(buf)
	local ok, parser = pcall(vim.treesitter.get_parser, buf, "go")
	if not ok or not parser then
		return
	end

	local parsed, trees = pcall(function()
		return parser:parse()
	end)
	if not parsed or not trees or not trees[1] then
		return
	end

	visit(buf, trees[1]:root())
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
