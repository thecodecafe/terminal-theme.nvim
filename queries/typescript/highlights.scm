;; extends

((member_expression
  object: (_) @variable.receiver)
 (#set! priority 130))

((property_signature
  name: [
    (property_identifier)
    (private_property_identifier)
    (string)
    (number)
  ] @property.definition)
 (#set! priority 130))

((public_field_definition
  name: [
    (property_identifier)
    (private_property_identifier)
    (string)
    (number)
  ] @property.definition)
 (#set! priority 130))
