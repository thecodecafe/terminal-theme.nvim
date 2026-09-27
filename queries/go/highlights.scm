;; extends

((qualified_type
  package: (package_identifier) @variable.receiver)
 (#set! priority 150))

((import_spec
  name: (package_identifier) @variable.receiver)
 (#set! priority 150))

((method_declaration
  receiver: (parameter_list
    (parameter_declaration
      name: (identifier) @variable)))
 (#set! priority 130))

((pointer_type
  "*" @operator.pointer)
 (#set! priority 130))

((unary_expression
  [ "&" "*" ] @operator.pointer)
 (#set! priority 130))
