;; extends

((selector_expression
  operand: (_) @variable.receiver)
 (#set! priority 130))

((method_declaration
  receiver: (parameter_list
    (parameter_declaration
      name: (identifier) @variable)))
 (#set! priority 130))

((field_declaration
  name: (field_identifier) @property.definition)
 (#set! priority 130))

((keyed_element
  key: (literal_element
    [
      (identifier)
      (interpreted_string_literal)
      (raw_string_literal)
    ] @property.definition))
 (#set! priority 130))

((pointer_type
  "*" @operator.pointer)
 (#set! priority 130))

((unary_expression
  [ "&" "*" ] @operator.pointer)
 (#set! priority 130))
