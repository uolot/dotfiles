" Fix Terraform plan diff output by moving diff marks to the start of line
command TerraformDiff :%s/^\(\s\+\)\(+\|-\|\~\)/\2\1/

" jump between terraform sections
let tf_sections = '^\(resource\|module\|data\|locals\|variable\|output\)'
autocmd FileType terraform nnoremap <silent> ]] :silent! call search(tf_sections, '')<cr>
autocmd FileType terraform nnoremap <silent> [[ :silent! call search(tf_sections, 'b')<cr>


