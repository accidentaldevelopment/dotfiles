" Subject line. Only matches on first line.
syn match jjType "\%1l^[a-z]\+" nextgroup=jjScope,jjBreaking,jjSeparator
syn region jjScope matchgroup=jjType start="(" end=")" contained nextgroup=jjBreaking,jjSeparator
syn match jjBreaking "!" contained nextgroup=jjSeparator
syn match jjSeparator ": " contained nextgroup=jjDescription
syn match jjDescription ".\+$" contained nextgroup=jjDescription

" Breaking changes marker, after the second line.
syn match jjBreakingBody "\%>2l^BREAKING CHANGES\?:"

hi def link jjType Keyword
hi def link jjScope Type
hi def link jjBreaking Error
hi def link jjSeparator Delimiter
hi def link jjDescription String
hi def link jjBreakingBody Error
