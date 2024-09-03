"
" This file contains functions for handling windows.
"

function! flog#win#GetAllIds() abort
  let l:windows = []
  for l:tab in gettabinfo()
    let l:windows += l:tab.windows
  endfor
  return l:windows
endfunction

function! flog#win#Save() abort
  return {
        \ 'win_id': win_getid(),
        \ 'bufnr': bufnr(),
        \ 'view': winsaveview(),
        \ 'vcol': flog#win#GetVcol('.'),
        \ 'vcols': flog#win#GetVcol('$')
        \ }
endfunction

function! flog#win#Is(saved_win) abort
  return win_getid() == a:saved_win.win_id
endfunction

function! flog#win#Restore(saved_win) abort
  silent! call win_gotoid(a:saved_win.win_id)

  let l:new_win_id = win_getid()

  if flog#win#Is(a:saved_win)
    call winrestview(a:saved_win.view)
    call flog#win#RestoreVcol(a:saved_win)
  endif

  return l:new_win_id
endfunction

function! flog#win#RestoreTopline(saved_win) abort
  let l:view = a:saved_win.view

  if l:view.topline == 1
    return -1
  endif

  let l:topline = l:view.topline - l:view.lnum + line('.')

  call winrestview({ 'topline': l:topline })

  return l:topline
endfunction

function! flog#win#GetVcol(expr) abort
  return virtcol(a:expr)
endfunction

function! flog#win#SetVcol(line, vcol) abort
  if exists('*setcursorcharpos')
    return setcursorcharpos(a:line, a:vcol)
  endif

  let l:line = a:line
  if type(a:line) == v:t_string
    let l:line = line(a:line)
  endif

  return cursor(a:line, virtcol2col(win_getid(), l:line, a:vcol))
endfunction

function! flog#win#RestoreVcol(saved_win) abort
  let l:vcol = a:saved_win.vcol
  call flog#win#SetVcol('.', l:vcol)
  return l:vcol
endfunction

function! flog#win#IsTabEmpty() abort
  return winnr('$') == 1
        \ && line('$') == 1
        \ && !&modified
        \ && &filetype ==# ''
        \ && &buftype ==# ''
        \ && getline(1) ==# ''
        \ && bufname() ==# ''
endfunction
