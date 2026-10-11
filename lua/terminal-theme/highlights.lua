local M = {}

local palette = {
	background = "#191B1C",
	foreground = "#D6D6D6",
	keyword = "#FE8010",
	punctuation = "#6C7278",
	highlight = "#34383B",
}

local function set(groups, attributes)
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, attributes)
	end
end

local white = { fg = palette.foreground }
local surface = { fg = palette.foreground, bg = palette.background }

function M.apply()
	-- Use an opaque black surface throughout the editor.
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
	set({ "Cursor" }, { fg = palette.foreground, bg = palette.background, bold = true })
	set({ "Visual", "Search", "IncSearch", "PmenuSel" }, {
		fg = palette.foreground,
		bg = palette.highlight,
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

	-- Configuration keys reveal document structure without coloring their values.
	set({
		"@property.json",
		"@property.jsonc",
		"@property.yaml",
		"jsonKeyword",
		"yamlMappingKey",
		"yamlBlockMappingKey",
		"yamlFlowMappingKey",
		"yamlBlockMappingKeyString",
		"TerminalThemeYamlKey",
		"TerminalThemeYamlQuotedKey",
	}, { fg = palette.keyword })
	set({
		"jsonString",
		"jsonQuote",
		"jsonEscape",
		"jsonNumber",
		"jsonBoolean",
		"jsonNull",
		"yamlPlainScalar",
		"yamlBlockString",
		"yamlString",
		"yamlFlowString",
		"yamlFlowStringDelimiter",
		"yamlEscape",
		"yamlSingleEscape",
		"yamlConstant",
		"yamlBool",
		"yamlNull",
		"yamlInteger",
		"yamlFloat",
		"yamlTimestamp",
		"yamlAnchor",
		"yamlAlias",
		"@label.yaml",
	}, white)
	set({
		"jsonNoise",
		"jsonBraces",
		"jsonComment",
		"jsonLineComment",
		"jsonCommentTodo",
		"yamlComment",
		"yamlTodo",
		"yamlMappingKeyStart",
		"yamlMappingMerge",
		"yamlKeyValueDelimiter",
		"yamlFlowIndicator",
		"yamlFlowMappingKeyStart",
		"yamlFlowMappingMerge",
		"yamlFlowMappingDelimiter",
		"yamlBlockMappingKeyStart",
		"yamlBlockMappingMerge",
		"yamlBlockMappingDelimiter",
		"yamlBlockCollectionItemStart",
		"yamlBlockScalarHeader",
		"yamlDocumentStart",
		"yamlDocumentEnd",
		"TerminalThemeYamlPunctuation",
	}, { fg = palette.punctuation })

	-- Markdown uses orange for document structure and navigation, while prose
	-- and code retain the foreground color. Scope Tree-sitter captures to the
	-- Markdown parsers so other markup formats keep their existing appearance.
	set({ "@markup.heading.1.markdown", "@markup.heading.2.markdown", "markdownH1", "markdownH2" }, {
		fg = palette.keyword,
		bold = true,
	})
	set({
		"@markup.heading.markdown",
		"@markup.heading.3.markdown",
		"@markup.heading.4.markdown",
		"@markup.heading.5.markdown",
		"@markup.heading.6.markdown",
		"markdownH3",
		"markdownH4",
		"markdownH5",
		"markdownH6",
	}, { fg = palette.keyword })
	set({
		"@markup.link.label.markdown",
		"@markup.link.label.markdown_inline",
		"markdownLinkText",
		"markdownId",
		"markdownIdDeclaration",
		"markdownFootnote",
		"markdownFootnoteDefinition",
	}, {
		fg = palette.keyword,
		underline = true,
	})
	set({
		"@markup.link.url.markdown",
		"@markup.link.url.markdown_inline",
		"markdownUrl",
		"markdownAutomaticLink",
	}, { fg = palette.foreground, underline = true })
	set({ "@markup.strong.markdown_inline", "markdownBold" }, { fg = palette.foreground, bold = true })
	set({ "@markup.italic.markdown_inline", "markdownItalic" }, { fg = palette.foreground, italic = true })
	set({ "markdownBoldItalic" }, { fg = palette.foreground, bold = true, italic = true })
	set({ "@markup.strikethrough.markdown_inline", "markdownStrike" }, {
		fg = palette.punctuation,
		strikethrough = true,
	})
	set({ "@markup.raw.markdown_inline", "markdownCode" }, {
		fg = palette.foreground,
		bg = palette.highlight,
		bold = true,
	})
	set({ "@markup.raw.block.markdown", "@markup.quote.markdown", "markdownCodeBlock" }, white)
	set({ "@markup.list.checked.markdown", "TerminalThemeMarkdownTaskChecked" }, { fg = palette.keyword })
	set({
		"@markup.list.markdown",
		"@markup.list.unchecked.markdown",
		"@markup.link.markdown_inline",
		"@conceal.markdown_inline",
		"markdownHeadingDelimiter",
		"markdownHeadingRule",
		"markdownH1Delimiter",
		"markdownH2Delimiter",
		"markdownH3Delimiter",
		"markdownH4Delimiter",
		"markdownH5Delimiter",
		"markdownH6Delimiter",
		"markdownListMarker",
		"markdownOrderedListMarker",
		"markdownBlockquote",
		"markdownRule",
		"markdownLinkTextDelimiter",
		"markdownLinkDelimiter",
		"markdownIdDelimiter",
		"markdownUrlDelimiter",
		"markdownUrlTitleDelimiter",
		"markdownCodeDelimiter",
		"markdownItalicDelimiter",
		"markdownBoldDelimiter",
		"markdownBoldItalicDelimiter",
		"markdownStrikeDelimiter",
		"TerminalThemeMarkdownTaskUnchecked",
	}, { fg = palette.punctuation })

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
		underline = true,
	})
	set({ "TelescopeMatching", "CmpItemAbbrMatch", "CmpItemAbbrMatchFuzzy" }, {
		fg = palette.foreground,
		bg = palette.background,
		bold = true,
	})
end

return M
