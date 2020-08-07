scriptencoding utf-8
" ^^ this should be the first line, always

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
