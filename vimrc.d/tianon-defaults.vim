set nobackup       " no backup files
set nowritebackup  " seriously, stahp with the backup files
set noswapfile     " no swap files

set noexpandtab tabstop=4 shiftwidth=4
set nohlsearch

" highlight strings inside C comments
let c_comment_strings = 1

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
" don't add 'markdown' here until
" https://github.com/tpope/vim-markdown/issues/121 is resolved 😬

" https://github.com/bfrg/vim-jq#syntax-highlighting-options
let g:jq_highlight_objects = 1

" enable optional support for Perl's "method signatures" highlighting :D
let g:perl_sub_signatures = 1
