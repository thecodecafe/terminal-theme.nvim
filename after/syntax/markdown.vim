" Vim's Markdown syntax leaves task markers as ordinary text.
syntax cluster markdownBlock add=TerminalThemeMarkdownTaskChecked,TerminalThemeMarkdownTaskUnchecked
syntax region TerminalThemeMarkdownTaskChecked matchgroup=markdownListMarker start=/^\s*\%([-*+]\|\d\+[.)]\)\s\+\ze\[[xX]\]/ matchgroup=TerminalThemeMarkdownTaskChecked end=/\[[xX]\]/ oneline keepend
syntax region TerminalThemeMarkdownTaskUnchecked matchgroup=markdownListMarker start=/^\s*\%([-*+]\|\d\+[.)]\)\s\+\ze\[ \]/ matchgroup=TerminalThemeMarkdownTaskUnchecked end=/\[ \]/ oneline keepend

highlight default link TerminalThemeMarkdownTaskChecked markdownListMarker
highlight default link TerminalThemeMarkdownTaskUnchecked markdownListMarker
