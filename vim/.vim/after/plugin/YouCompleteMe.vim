" tone down identifier autocompletion triggering; I can type fast enough
let g:ycm_min_num_of_chars_for_completion = 5
let g:ycm_min_num_identifier_candidate_chars = 7

" don't show preview YCM window
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
