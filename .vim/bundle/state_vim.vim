let [plugins, ftplugin] = dein#load_cache_raw(['/Users/tuna/.vimrc'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/tuna/.vim/bundle'
let g:dein#_runtime_path = '/Users/tuna/.vim/bundle/.dein'
let &runtimepath = '/Users/tuna/.vim/bundle/repos/github.com/Shougo/neocomplete.vim,/Users/tuna/.vim/bundle/repos/github.com/Shougo/vimproc.vim,/Users/tuna/.vim/bundle/.dein,/Users/tuna/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/Users/tuna/.vim/after,/Users/tuna/.vim/bundle/repos/github.com/Shougo/dein.vim,/Users/tuna/.vim/bundle/.dein/after'
