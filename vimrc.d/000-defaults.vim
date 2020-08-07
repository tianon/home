" These settings are inspired by / taken from the "defaults.vim" file shipped
" with Vim upstream (which is the default Vim loads in the absense of a
" "~/.vimrc" file).
"
" See "/usr/share/vim/vim81/defaults.vim" or https://github.com/vim/vim/blob/8e1986e3896cc8c2a05fc6291a39ebb275e1cebf/runtime/defaults.vim

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" see also https://github.com/tpope/vim-sensible
" (which should be cloned inside ~/.vim/pack/tianon/start/vim-sensible)

" display incomplete commands
set showcmd

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=2

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
	set guioptions-=t
endif

if has('mouse')
	" disable the mouse by default, it's annoying
	set mouse=
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Put these in an autocmd group, so that you can revert them with:
	" ":augroup vimStartup | au! | augroup END"
	augroup vimStartup
		au!

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid, when inside an event handler
		" (happens when dropping a file on gvim) and for a commit message (it's
		" likely a different one than last time).
		autocmd BufReadPost *
			\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\ |   exe "normal! g`\""
			\ | endif

	augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
			\ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
	" Prevent that the langmap option applies to characters that result from a
	" mapping.  If set (default), this may break plugins (but it's backward
	" compatible).
	set nolangremap
endif
