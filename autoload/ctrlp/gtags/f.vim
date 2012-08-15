if exists( 'g:loaded_ctrlp_gtags_f' ) && g:loaded_ctrlp_gtags_f
	finish
endif
let g:loaded_ctrlp_gtags_f = 1

let s:mark_var = {
	\  'init':   'ctrlp#gtags#f#init()',
	\  'exit':   'ctrlp#gtags#f#exit()',
	\  'accept': 'ctrlp#gtags#f#accept',
	\  'lname':  'gtags -f',
	\  'sname':  'gtags -f',
	\  'type':   'gtags -f',
	\  'sort':   0,
	\}
if exists( 'g:ctrlp_ext_vars' ) && !empty( g:ctrlp_ext_vars )
	let g:ctrlp_ext_vars = add( g:ctrlp_ext_vars, s:mark_var )
else
	let g:ctrlp_ext_vars = [s:mark_var]
endif

function! ctrlp#gtags#f#init()
	let l:s = input( 'Source:' )
	if empty( l:s )
		"let l:s = expand( '%' )
		return []
	endif
	let l:s = system( 'global -f ' . l:s )
	return split( l:s, "\n" ) "[1:]
endfunction

function! ctrlp#gtags#f#accept( mode, str )
	call ctrlp#exit()
		let l:str = substitute( a:str, '\s\+', ' ', 'g' )
		let l:list = split( l:str, " " )
		execute 'edit +' . l:list[1] . ' ' . l:list[2]
endfunction

function! ctrlp#gtags#f#exit()
endfunction

let s:id = g:ctrlp_builtins + len( g:ctrlp_ext_vars )
function! ctrlp#gtags#f#id()
	return s:id
endfunction

