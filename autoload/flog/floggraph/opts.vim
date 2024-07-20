"
" This file contains functions for modifying options in "floggraph" buffers.
"

function! flog#floggraph#opts#Toggle(name) abort
  call flog#floggraph#buf#AssertFlogBuf()
  let l:opts = flog#state#GetBufState().opts

  let l:val = !l:opts[a:name]
  let l:opts[a:name] = l:val

  call flog#floggraph#buf#Update()

  return l:val
endfunction

function! flog#floggraph#opts#ToggleAll() abort
  return flog#floggraph#opts#Toggle('all')
endfunction

function! flog#floggraph#opts#ToggleBisect() abort
  return flog#floggraph#opts#Toggle('bisect')
endfunction

function! flog#floggraph#opts#ToggleFirstParent() abort
  return flog#floggraph#opts#Toggle('first_parent')
endfunction

function! flog#floggraph#opts#ToggleMerges() abort
  return flog#floggraph#opts#Toggle('merges')
endfunction

function! flog#floggraph#opts#ToggleReflog() abort
  return flog#floggraph#opts#Toggle('reflog')
endfunction

function! flog#floggraph#opts#ToggleReverse() abort
  return flog#floggraph#opts#Toggle('reverse')
endfunction

function! flog#floggraph#opts#ToggleGraph() abort
  return flog#floggraph#opts#Toggle('graph')
endfunction

function! flog#floggraph#opts#TogglePatch() abort
  call flog#floggraph#buf#AssertFlogBuf()
  let l:opts = flog#state#GetBufState().opts

	if l:opts.patch == v:false
		let l:opts.patch = v:null
	else
		let l:opts.patch = v:false
	endif

	call flog#floggraph#buf#Update()

	return l:opts.patch
endfunction

function! flog#floggraph#opts#CycleOrder() abort
  call flog#floggraph#buf#AssertFlogBuf()
  let l:opts = flog#state#GetBufState().opts

  let l:default_order = l:opts.graph ? 'topo' : 'date'

  let l:order = l:opts.order
  if empty(l:order)
    let l:order = l:default_order
  endif

  let l:order_type = flog#global_opts#GetOrderType(l:order)

  if empty(l:order_type)
    let l:order = g:flog_order_types[0].name
  else
    let l:order_index = index(g:flog_order_types, l:order_type)

    if l:order_index == len(g:flog_order_types) - 1
      let l:order = g:flog_order_types[0].name
    else
      let l:order = g:flog_order_types[l:order_index + 1].name
    endif
  endif

  let l:opts.order = l:order

  call flog#floggraph#buf#Update()

  return l:order
endfunction
