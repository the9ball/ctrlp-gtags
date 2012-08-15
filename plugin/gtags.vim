command! CtrlPGtagsF cal ctrlp#init( ctrlp#gtags#f#id() )
command! CtrlPGtagsR cal ctrlp#init( ctrlp#gtags#r#id() )

nnoremap <C-t> :CtrlPGtagsR<CR>

