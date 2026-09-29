local M = {}

local palette = {
	background = "#000000",
	foreground = "#D6D6D6",
	keyword = "#FE8010",
	punctuation = "#6C7278",
}

local function set(groups, attributes)
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, attributes)
	end
end

local white = { fg = palette.foreground }
local surface = { fg = palette.foreground, bg = palette.background, blend = 95 }

function M.apply()
	-- Use a nearly transparent black surface so the terminal background remains visible.
	set({
		"Normal",
		"NormalNC",
		"NormalFloat",
		"SignColumn",
		"FoldColumn",
		"EndOfBuffer",
		"NonText",
		"Whitespace",
		"LineNr",
		"CursorLineNr",
		"CursorLine",
		"CursorColumn",
		"ColorColumn",
		"Folded",
		"FloatBorder",
		"WinSeparator",
		"VertSplit",
		"Pmenu",
		"PmenuSbar",
		"PmenuThumb",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"Directory",
		"Title",
		"Question",
		"MoreMsg",
		"WarningMsg",
		"ErrorMsg",
		"Error",
	}, surface)

	-- Use a dark gray background to distinguish interactive states.
	set({ "Cursor" }, { fg = palette.foreground, bg = palette.background, blend = 95, bold = true })
	set({ "Visual", "Search", "IncSearch", "PmenuSel" }, {
		fg = palette.foreground,
		bg = "#34383B",
	})
	set({ "StatusLine", "TabLineSel" }, { fg = palette.foreground, bg = palette.background, blend = 95, bold = true })
	set({ "CursorLineNr" }, { fg = palette.foreground, bg = palette.background, blend = 95, bold = true })
	set({ "MatchParen" }, { fg = palette.punctuation, bg = palette.background, blend = 95, bold = true })

	-- Language keywords and declaration/control-flow words.
	set({
		"Statement",
		"Conditional",
		"Repeat",
		"Label",
		"Keyword",
		"Exception",
		"PreProc",
		"Include",
		"Define",
		"Macro",
		"PreCondit",
		"StorageClass",
		"@keyword",
		"@keyword.conditional",
		"@keyword.directive",
		"@keyword.exception",
		"@keyword.function",
		"@keyword.import",
		"@keyword.modifier",
		"@keyword.operator",
		"@keyword.repeat",
		"@keyword.return",
		"@keyword.storage",
		"@conditional",
		"@repeat",
		"@label",
		"@exception",
		"@preproc",
		"@include",
		"@define",
		"@storageclass",
	}, { fg = palette.keyword })
	set({ "@operator.pointer" }, { fg = palette.keyword })

	-- Delimiters and operators share the supplied alpha color composited over black.
	set({
		"Operator",
		"Delimiter",
		"@operator",
		"@variable.receiver",
		"@variable.parameter",
		"Comment",
		"SpecialComment",
		"Todo",
		"@comment",
		"@comment.documentation",
		"@comment.todo",
		"@comment.note",
		"@comment.warning",
		"@comment.error",
		"@punctuation",
		"@punctuation.bracket",
		"@punctuation.delimiter",
		"@punctuation.special",
		"@tag.delimiter",
	}, { fg = palette.punctuation })

	-- All other built-in syntax groups stay white, including literals,
	-- identifiers, types, function names, and strings.
	set({
		"Constant",
		"String",
		"Character",
		"Number",
		"Boolean",
		"Float",
		"Identifier",
		"Function",
		"Type",
		"Structure",
		"Typedef",
		"Special",
		"SpecialChar",
		"Debug",
		"Underlined",
		"Ignore",
		"@annotation",
		"@attribute",
		"@boolean",
		"@character",
		"@constant",
		"@constant.builtin",
		"@constructor",
		"@error",
		"@function",
		"@function.builtin",
		"@function.call",
		"@function.method",
		"@function.method.call",
		"@number",
		"@number.float",
		"@property",
		"@string",
		"@string.escape",
		"@tag",
		"@tag.attribute",
		"@type",
		"@type.builtin",
		"@variable",
		"@variable.builtin",
		"@variable.member",
	}, white)

	-- Diagnostic text and underlines use the theme's gray.
	set({
		"DiagnosticError",
		"DiagnosticWarn",
		"DiagnosticInfo",
		"DiagnosticHint",
		"DiagnosticOk",
		"DiagnosticVirtualTextError",
		"DiagnosticVirtualTextWarn",
		"DiagnosticVirtualTextInfo",
		"DiagnosticVirtualTextHint",
		"DiagnosticVirtualTextOk",
	}, { fg = palette.punctuation })
	set({ "LspInlayHint" }, white)
	set({
		"DiagnosticUnderlineError",
		"DiagnosticUnderlineWarn",
		"DiagnosticUnderlineInfo",
		"DiagnosticUnderlineHint",
		"DiagnosticUnderlineOk",
	}, { fg = palette.punctuation, undercurl = true, sp = palette.punctuation })
	set({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }, {
		fg = palette.foreground,
		bg = palette.background,
		blend = 95,
		underline = true,
	})

	-- Common plugin groups follow the same palette rules.
	set({
		"TelescopeBorder",
		"TelescopeNormal",
		"TelescopePromptNormal",
		"TelescopePromptBorder",
		"TelescopeSelection",
		"TelescopeMatching",
		"CmpItemAbbr",
		"CmpItemAbbrDeprecated",
		"CmpItemAbbrMatch",
		"CmpItemAbbrMatchFuzzy",
		"CmpItemKind",
		"CmpItemMenu",
		"lualine_a_normal",
		"lualine_b_normal",
		"lualine_c_normal",
		"lualine_a_inactive",
		"lualine_b_inactive",
		"lualine_c_inactive",
		"lualine_a_insert",
		"lualine_b_insert",
		"lualine_c_insert",
		"lualine_a_visual",
		"lualine_b_visual",
		"lualine_c_visual",
		"lualine_a_replace",
		"lualine_b_replace",
		"lualine_c_replace",
		"lualine_a_command",
		"lualine_b_command",
		"lualine_c_command",
		"BufferLineBufferVisible",
		"BufferLineBufferSelected",
		"BufferLineFill",
	}, surface)
	set({ "TelescopeSelection", "BufferLineBufferSelected" }, {
		fg = palette.foreground,
		bg = palette.background,
		blend = 95,
		underline = true,
	})
	set({ "TelescopeMatching", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy" }, {
		fg = palette.foreground,
		bg = palette.background,
		blend = 95,
		bold = true,
	})
end

return M
