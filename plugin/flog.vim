let g:flog_instance_counter = 0

" used to delineate format specifiers used to retrieve commit data
let g:flog_format_start = '__FSTART__'
let g:flog_format_separator = '__FSEP__'
let g:flog_format_end = '__FEND__'
" used to delineate which part of the log to display to the user
let g:flog_display_commit_start = '__DSTART__'
let g:flog_display_commit_end = '__DEND__'
" information about specifiers for use with --pretty=format:*
let g:flog_format_specifiers = {
      \ 'short_commit_hash': '%h',
      \ 'author_name': '%an',
      \ 'author_relative_date': '%ar',
      \ 'ref_names_unwrapped': '%D',
      \ 'subject': '%s',
      \ }
" the specifiers to use to retrieve data
let g:flog_log_data_format_specifiers = [
      \ 'ref_names_unwrapped',
      \ 'short_commit_hash',
      \ 'author_name',
      \ 'author_relative_date',
      \ 'subject',
      \ ]

" Errors {{{

let g:flog_missing_state = 'flog: could not find state'
let g:flog_not_a_fugitive_buffer = 'flog: not a fugitive buffer'
let g:flog_no_log_output = 'flog: error parsing commits: no git output'
let g:flog_no_commits = 'flog: error parsing commits: no commits found'
let g:flog_missing_commit_start = 'flog: error parsing commits: could not find start of commit'

" }}}

" Commands {{{

command! -nargs=* Flog call flog#open([<f-args>])

" }}}

" vim: set et sw=2 ts=2 fdm=marker:
