syntax region FixmeRegion start=+\\fixme{+ end=+}+ keepend contains=FixmeContent
syntax match FixmeContent contained /\\fixme{\zs[^}]*/
highlight FixmeRegion guifg=#959333
highlight FixmeContent guifg=#c59777 gui=bold

augroup LatexFixmeHighlight
  autocmd!
  autocmd FileType tex syntax enable
augroup END
