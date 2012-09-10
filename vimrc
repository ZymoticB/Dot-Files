call pathogen#infect()
call pathogen#helptags()

" Highlight characters after the 80th column
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%>80v.\+/

set background=dark
set ts=4
"This allows buffers with changes to have their windows closed.
set hidden
" One backspace to delete a 4 space tab
set softtabstop=4
set encoding=utf-8
set laststatus=2
syntax enable
" Disable escape key delay
set noesckeys
" Lower timeout
set timeout timeoutlen=1000 ttimeoutlen=100

colorscheme solarized

" Improve completion
set completeopt+=longest,menuone
" Some wierd shit with the popup completion menu
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

let Tlist_Inc_Winwidth=0
let Tlist_Display_Prototype=1
let Tlist_Use_Horiz_Window=1
let Tlist_GainFocus_On_ToggleOpen=1
map <leader>tw :set nowrap!<CR>

nmap <leader>B :ConqueTermSplit bpython<CR>
filetype plugin indent on

" Make NERDTree like janus
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

" Default mapping, <leader>n
map <leader>n :NERDTreeToggle<CR>
noremap [14~ :set invpaste paste?<CR>
noremap <F5> :GundoToggle<CR> 
set pastetoggle=[14~ 
augroup AuNERDTreeCmd
autocmd AuNERDTreeCmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

let g:pymode_lint_write=0
let g:pymode_folding = 0

"Diff file before saving
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Powerline stuff	
let g:Powerline_symbols = 'fancy'

