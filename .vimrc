set nu
set ts=4
set et
" One backspace to delete a 4 space tab
set softtabstop=4

" Highlight characters after the 80th column
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>80v.\+/

" colorscheme 3dglasses
syntax on
set autoindent

" Make backspace work over some ssh
map!  
" Make arrow keys not print lame shit
"map! OA ka
"map! OB ja
"map! OC la
"map! OD ha
