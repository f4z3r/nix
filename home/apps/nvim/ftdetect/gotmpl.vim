" helm specific
autocmd BufRead,BufNewFile */templates/*.tpl  setl ft=gotmpl
autocmd BufRead,BufNewFile */templates/*.yaml setl ft=gotmpl
autocmd BufRead,BufNewFile helmfile.yaml      setl ft=gotmpl
