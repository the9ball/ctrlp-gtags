if exists( 'g:loaded_ctrlp_gtags_x' ) && g:loaded_ctrlp_gtags_x
	finish
endif
let g:loaded_ctrlp_gtags_x = 1

let s:mark_var = {
	\  'init':   'ctrlp#gtags#x#init()',
	\  'exit':   'ctrlp#gtags#x#exit()',
	\  'accept': 'ctrlp#gtags#x#accept',
	\  'lname':  'gtags',
	\  'sname':  'gtags',
	\  'type':   'gtags',
	\  'sort':   0,
	\}
if exists( 'g:ctrlp_ext_vars' ) && !empty( g:ctrlp_ext_vars )
	let g:ctrlp_ext_vars = add( g:ctrlp_ext_vars, s:mark_var )
else
	let g:ctrlp_ext_vars = [s:mark_var]
endif

function! ctrlp#gtags#x#init()
	let l:s = input( 'Source:' )
	if empty( l:s )
		return []
	endif
	let l:s = system( 'global -x ' . l:s )
	return split( l:s, "\n" ) "[1:]
endfunction

function! ctrlp#gtags#x#accept( mode, str )
	call ctrlp#exit()
		let l:str = substitute( a:str, '\s\+', ' ', 'g' )
		let l:list = split( l:str, " " )
		execute 'edit +' . l:list[1] . ' ' . l:list[2]
endfunction

function! ctrlp#gtags#x#exit()
endfunction

let s:id = g:ctrlp_builtins + len( g:ctrlp_ext_vars )
function! ctrlp#gtags#x#id()
	return s:id
endfunction


