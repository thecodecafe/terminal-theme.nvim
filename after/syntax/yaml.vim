" Override contained string/number syntax only inside keys recognized by Vim.
" Boolean keywords take precedence over matches, so keep scalar types in values.
syntax cluster yamlScalarWithSpecials contains=yamlPlainScalar
syntax cluster yamlConstant contains=NONE
syntax match TerminalThemeYamlKey /./ contained containedin=yamlBlockMappingKey,yamlFlowMappingKey,yamlBlockMappingKeyString

" Vim otherwise treats quoted keys in flow mappings as ordinary string values.
syntax match TerminalThemeYamlQuotedKey /"\%([^"\\]\|\\.\)*"\ze\s*:/ contained containedin=yamlFlowMapping
syntax match TerminalThemeYamlQuotedKey /'\%([^']\|''\)*'\ze\s*:/ contained containedin=yamlFlowMapping

syntax match TerminalThemeYamlPunctuation /[&*]/ contained containedin=yamlAnchor,yamlAlias
syntax match TerminalThemeYamlPunctuation /,/ contained containedin=yamlFlowCollection,yamlFlowMapping

highlight default link TerminalThemeYamlKey yamlMappingKey
highlight default link TerminalThemeYamlQuotedKey yamlMappingKey
highlight default link TerminalThemeYamlPunctuation Delimiter
