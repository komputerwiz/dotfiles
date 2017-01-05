let g:ctrlp_working_path_mode = 'ra'

" let .project file mark the root of a project directory
let g:ctrlp_root_markers = ['.project']

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard', 'find %s -type f']

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|[\/]cache|[\/]log|[\/]tmp$',
  \ 'file': '\v\.(exe|so|dat)$'
  \ }
