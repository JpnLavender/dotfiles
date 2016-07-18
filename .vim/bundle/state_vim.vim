let [plugins, ftplugin] = dein#load_cache_raw(['/Users/roof/.vimrc'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/roof/.vim/bundle'
let g:dein#_runtime_path = '/Users/roof/.vim/bundle/.dein'
let &runtimepath = '/Users/roof/.vim/bundle/repos/github.com/Shougo/neocomplete.vim,/Users/roof/.vim/bundle/repos/github.com/Shougo/vimproc.vim,/Users/roof/.vim/bundle/.dein,/Users/roof/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim74,/usr/local/share/vim/vimfiles/after,/Users/roof/.vim/after,/Users/roof/.vim/bundle/repos/github.com/Shougo/dein.vim,/Users/roof/.vim/bundle/.dein/after'
