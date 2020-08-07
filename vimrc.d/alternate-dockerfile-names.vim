" match more filename variations as Dockerfiles
au BufNewFile,BufRead [Dd]ockerfile,[Dd]ockerfile*.*,*.*[Dd]ockerfile setlocal filetype=dockerfile
