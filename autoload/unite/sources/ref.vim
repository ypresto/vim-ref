" unite source: ref
" Version: 0.1.0
" Author : thinca <thinca+vim@gmail.com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>

let s:save_cpo = &cpo
set cpo&vim

let s:source = {}



function! s:source.gather_candidates(args, context)  " {{{2
  return map(self.ref_source.complete(''), '{
  \   "word" : v:val,
  \   "kind" : "ref",
  \   "source" : self.name,
  \   "ref_source" : self.ref_source,
  \ }')
endfunction



function! s:define(ref_source)  " {{{2
  let source = copy(s:source)
  let source.name = 'ref/' . a:ref_source.name
  let source.ref_source = a:ref_source
  return source
endfunction



function! unite#sources#ref#define()  "{{{2
  return map(filter(values(ref#available_sources()), 'v:val.available()'),
  \          's:define(v:val)')
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
