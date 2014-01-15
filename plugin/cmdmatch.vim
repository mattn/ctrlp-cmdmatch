cno <plug>(ctrlp-cmdmatch) <c-f>^"vyg_dd:q<cr>:call ctrlp#cmdmatch#init(split(@v, '\s')[0])<cr>

if !hasmapto('<Plug>(ctrlp-cmdmatch)')
\  && (!exists('g:ctrlp_cmdmatch_no_default_key_mappings')
\      || !g:ctrlp_cmdmatch_no_default_key_mappings)
  silent! cmap <unique> <c-o> <plug>(ctrlp-cmdmatch)
endif
