;; extends

; Capture scalar keys as properties even when their contents are numbers or booleans.
((block_mapping_pair
  key: (flow_node
    [
      (plain_scalar)
      (double_quote_scalar)
      (single_quote_scalar)
    ] @property))
 (#set! priority 130))

((flow_pair
  key: (flow_node
    [
      (plain_scalar)
      (double_quote_scalar)
      (single_quote_scalar)
    ] @property))
 (#set! priority 130))

; Merge operators remain punctuation rather than ordinary key labels.
((block_mapping_pair
  key: (flow_node
    (plain_scalar (string_scalar) @punctuation.special)))
 (#eq? @punctuation.special "<<")
 (#set! priority 140))

((flow_pair
  key: (flow_node
    (plain_scalar (string_scalar) @punctuation.special)))
 (#eq? @punctuation.special "<<")
 (#set! priority 140))
