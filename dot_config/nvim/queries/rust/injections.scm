; extends

; Inject a SQL parser into `sqlx` macros/functions that expect SQL.
([(macro_invocation
    macro: [(scoped_identifier
      name: (_) @_name)
        (identifier) @_name]
      (token_tree
        (_ (string_content) @injection.content)))
  (call_expression
    function: (scoped_identifier
      path: (identifier)
      name: (identifier) @_func)
    arguments: (arguments
      (_ (string_content) @injection.content)))]
  (#any-of? @_name "query" "query_as")
  (#set! injection.language "sql"))

; Mark parser injection points with with a `lang=$lang` comment.
; Example:
; ```rust
; // lang=sql
; let sql = r"SELECT * FROM table"; // this will be highlighted as sql.
; ```
((line_comment) @injection.language
 .
 (let_declaration
  value: [(call_expression
            arguments: (arguments
              (_ (string_content) @injection.content)))
          (_ (string_content) @injection.content)])
  (#lua-match? @injection.language "//%s*lang=%S+")
  (#gsub! @injection.language "//%s*lang=(%S+).*" "%1"))
