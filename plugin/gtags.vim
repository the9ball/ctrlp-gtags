command! CtrlPGtags cal ctrlp#init( ctrlp#gtags#id() )
command! CtrlPGtagsF cal ctrlp#init( ctrlp#gtags#f#id() )
command! CtrlPGtagsR cal ctrlp#init( ctrlp#gtags#r#id() )

nnoremap <C-t> :CtrlPGtags<CR>

