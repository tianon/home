scriptencoding utf-8
" ^^ this should be the first line, always

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

set nobackup       " no backup files
set nowritebackup  " seriously, stahp with the backup files
set noswapfile     " no swap files

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

set noexpandtab tabstop=4 shiftwidth=4

" highlight strings inside C comments
let c_comment_strings=1

" RAINBOWS (see https://github.com/luochen1990/rainbow)
let g:rainbow_active = 1

" if it's .sh, it's bash
let g:bash_is_sh = 1
let g:is_bash = 1

" highlight fenced languages in markdown!
let g:markdown_fenced_languages = [
			\ 'bash=sh',
			\ 'console=sh',
			\ 'dockerfile',
			\ 'go',
			\ 'html',
			\ 'ini=dosini',
			\ 'perl',
			\ 'python',
			\ 'shell=sh',
			\ 'yaml' ]

colorscheme jellybeans

" adjust markdown code colors
au FileType markdown highlight markdownCode ctermfg=DarkGreen guifg=DarkGreen

" visual (and colorful) whitespace
if has('multi_byte')
	set list listchars=tab:»·,nbsp:_,extends:¬
	if &t_Co == 256
		au BufEnter * highlight SpecialKey ctermfg=Green ctermbg=Black guifg=Green guibg=Black
	else
		au BufEnter * highlight SpecialKey ctermfg=DarkGreen ctermbg=DarkBlue guifg=DarkGreen guibg=DarkBlue
	endif
endif

" allow Ctrl+C to be magic
map <C-c> "+yy
map <C-v> "+p
map <C-x> "+dd
imap <C-c> <esc>"+yya
imap <C-v> <esc>"+pa
imap <C-x> <esc>"+dda
vmap <C-c> "+y
vmap <C-v> d"+P
vmap <C-x> "+d
