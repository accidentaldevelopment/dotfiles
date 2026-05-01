; extends

(block_mapping
  (block_mapping_pair
    key: (flow_node) @_key
    value: (block_node
      (block_scalar))) @injection.content
  (#match? @_key "\.json$")
  (#set! injection.include-children)
  (#set! injection.language "json")
  (#offset! @injection.content 1 0 0 0))

(block_mapping
  (block_mapping_pair
    key: (flow_node) @_key
    value: (flow_node
      (single_quote_scalar)) @injection.content)
  (#match? @_key "\.json$")
  (#set! injection.include-children)
  (#set! injection.language "json")
  (#offset! @injection.content 0 1 0 -1))
