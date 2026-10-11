;; extends

; The bundled query highlights whole headings and code blocks. Give their
; visible syntax markers a higher priority than the surrounding content.
([
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @punctuation.special
  (#set! priority 110))

((fenced_code_block_delimiter) @punctuation.special
  (#set! priority 110)
  (#set! conceal "")
  (#set! conceal_lines ""))
