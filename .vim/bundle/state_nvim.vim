let [plugins, ftplugin] = dein#load_cache_raw(['/Users/roof/dotfiles/.config/nvim/init.vim'], 1)
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/roof/.vim/bundle'
let g:dein#_runtime_path = '/Users/roof/.vim/bundle/.dein'
let &runtimepath = '/Users/roof/.vim/bundle/repos/github.com/Shougo/vimproc.vim,/Users/roof/.vim/bundle/.dein,/Users/roof/.config/nvim,/etc/xdg/nvim,/Users/roof/.local/share/nvim/site,/usr/local/share/nvim/site,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.1.4/share/nvim/runtime,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/roof/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/roof/.config/nvim/after,/Users/roof/.vim/bundle/repos/github.com/Shougo/dein.vim,/Users/roof/.vim/bundle/.dein/after'
filetype off
