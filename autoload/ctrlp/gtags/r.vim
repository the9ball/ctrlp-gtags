if exists( 'g:loaded_ctrlp_gtags_r' ) && g:loaded_ctrlp_gtags_r
	finish
endif
let g:loaded_ctrlp_gtags_r = 1

let s:mark_var = {
	\  'init':   'ctrlp#gtags#r#init()',
	\  'exit':   'ctrlp#gtags#r#exit()',
	\  'accept': 'ctrlp#gtags#r#accept',
	\  'lname':  'gtags -r',
	\  'sname':  'gtags -r',
	\  'type':   'gtags -r',
	\  'sort':   0,
	\}
if exists( 'g:ctrlp_ext_vars' ) && !empty( g:ctrlp_ext_vars )
	let g:ctrlp_ext_vars = add( g:ctrlp_ext_vars, s:mark_var )
else
	let g:ctrlp_ext_vars = [s:mark_var]
endif

function! ctrlp#gtags#r#init()
	let l:s = input( 'Source ( empty : '.s:word.' ) : ' )
	if empty( l:s )
		let l:s = s:word
	endif
	let l:s = system( 'global -xr ' . l:s )
	return split( l:s, "\n" ) "[1:]
endfunction

function! ctrlp#gtags#r#accept( mode, str )
	call ctrlp#exit()
		let l:str = substitute( a:str, '\s\+', ' ', 'g' )
		let l:list = split( l:str, " " )
		execute 'edit +' . l:list[1] . ' ' . l:list[2]
endfunction

function! ctrlp#gtags#r#exit()
endfunction

let s:word = ''
let s:id = g:ctrlp_builtins + len( g:ctrlp_ext_vars )
function! ctrlp#gtags#r#id()
	let s:word = expand('<cword>')
	return s:id
endfunction

