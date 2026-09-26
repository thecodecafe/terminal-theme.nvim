local M = {}

local palette = {
	background = "#000000",
	foreground = "#FFFFFF",
	keyword = "#FF7A00",
	punctuation = "#95999E",
}

local function set(groups, attributes)
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, attributes)
	end
end

local white = { fg = palette.foreground }
local black = { fg = palette.foreground, bg = palette.background }

function M.apply()
	-- Editor surfaces and text. The editor background is black throughout.
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
		"Todo",
	}, black)

	-- Keep interactive states legible using only black and white.
	set({ "Cursor" }, { fg = palette.foreground, bg = palette.background, bold = true })
	set({ "Visual", "Search", "IncSearch", "PmenuSel" }, {
		fg = palette.foreground,
		bg = palette.background,
		underline = true,
	})
	set({ "StatusLine", "TabLineSel" }, { fg = palette.foreground, bg = palette.background, bold = true })
	set({ "CursorLineNr" }, { fg = palette.foreground, bg = palette.background, bold = true })
	set({ "MatchParen" }, { fg = palette.punctuation, bg = palette.background, bold = true })

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

	-- Delimiters and operators share the supplied alpha color composited over black.
	set({
		"Operator",
		"Delimiter",
		"@operator",
		"@punctuation",
		"@punctuation.bracket",
		"@punctuation.delimiter",
		"@punctuation.special",
		"@tag.delimiter",
	}, { fg = palette.punctuation })

	-- All other built-in syntax groups stay white, including comments, literals,
	-- identifiers, types, function names, and strings.
	set({
		"Comment",
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
		"SpecialComment",
		"Debug",
		"Underlined",
		"Ignore",
		"@annotation",
		"@attribute",
		"@boolean",
		"@character",
		"@comment",
		"@constant",
		"@constant.builtin",
		"@constructor",
		"@error",
		"@function",
		"@function.builtin",
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
	}, white)

	-- Diagnostic text remains white; underline styling communicates severity
	-- without introducing colors that were not in the supplied palette.
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
		"LspInlayHint",
	}, white)
	set({
		"DiagnosticUnderlineError",
		"DiagnosticUnderlineWarn",
		"DiagnosticUnderlineInfo",
		"DiagnosticUnderlineHint",
		"DiagnosticUnderlineOk",
	}, { fg = palette.foreground, undercurl = true, sp = palette.foreground })
	set({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }, {
		fg = palette.foreground,
		bg = palette.background,
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
	}, black)
	set({ "TelescopeSelection", "BufferLineBufferSelected" }, {
		fg = palette.foreground,
		bg = palette.background,
		underline = true,
	})
	set({ "TelescopeMatching", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy" }, {
		fg = palette.foreground,
		bg = palette.background,
		bold = true,
	})
end

return M
