;; extends

((selector_expression
  operand: (_) @variable.receiver)
 (#set! priority 130))

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
