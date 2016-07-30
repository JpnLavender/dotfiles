" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
autocmd BufNewFile,BufRead *._coffee set filetype=coffee

function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectCoffee()
au BufRead,BufNewFile *.ex,*.exs call s:setf('elixir')
au BufRead,BufNewFile *.eex call s:setf('eelixir')
au BufRead,BufNewFile * call s:DetectElixir()

au FileType elixir,eelixir setl sw=2 sts=2 et iskeyword+=!,?

function! s:setf(filetype) abort
  let &filetype = a:filetype
endfunction

function! s:DetectElixir()
  if getline(1) =~ '^#!.*\<elixir\>'
    call s:setf('elixir')
  endif
endfunction
function! s:DetectJS()
    if getline(1) =~# '^#!.*/bin/\(env\s\+\)\?node\>'
        setfiletype javascript
    endif
endfunction
autocmd BufNewFile,BufRead * call s:DetectJS()
augroup rmarkdown
    au! BufRead,BufNewFile *.Rmd  setfiletype rmarkdown
augroup END
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif
" Detect vimshell rc file.
autocmd BufNewFile,BufRead *.vimsh,.vimshrc,vimshrc set filetype=vimshrc
