set nobackup       " no backup files
set nowritebackup  " seriously, stahp with the backup files
set noswapfile     " no swap files

set noexpandtab tabstop=4 shiftwidth=4

" highlight strings inside C comments
let c_comment_strings = 1

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
			\ 'sh',
			\ 'shell=sh',
			\ 'yaml' ]

" enable optional support for Perl's "method signatures" highlighting :D
let g:perl_sub_signatures = 1
