if exists('g:loaded_ctrlp_cmdmatch') && g:loaded_ctrlp_cmdmatch
  finish
endif
let g:loaded_ctrlp_cmdmatch = 1

let s:cmdmatch_var = {
\  'init':   'ctrlp#cmdmatch#init("")',
\  'accept': 'ctrlp#cmdmatch#accept',
\  'lname':  'cmdmatch',
\  'sname':  'cmdmatch',
\  'type':   'path',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:cmdmatch_var)
else
  let g:ctrlp_ext_vars = [s:cmdmatch_var]
endif

function! ctrlp#cmdmatch#init(arg)
  redir => cmds
  silent command
  redir END

  let has_default = exists('g:ctrlp_default_input')
  if has_default
    let old_default = get(g:, 'ctrlp_default_input', '')
  endif
  let g:ctrlp_default_input = a:arg
  call ctrlp#init(ctrlp#cmdmatch#id())
  if has_default
    let g:ctrlp_default_input = old_default
  else
    unlet g:ctrlp_default_input
  endif
  return map(split(cmds, "\n")[1:], 'matchstr(v:val, "^!\\?\\s*\\zs\\S\\+\\ze\\s")')
endfunc

function! ctrlp#cmdmatch#accept(mode, str)
  call ctrlp#exit()
	call feedkeys(':' . a:str)
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#cmdmatch#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
