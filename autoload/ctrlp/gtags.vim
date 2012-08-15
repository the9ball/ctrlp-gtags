if exists( 'g:loaded_ctrlp_gtags' ) && g:loaded_ctrlp_gtags
	finish
endif
let g:loaded_ctrlp_gtags = 1

let s:mark_var = {
	\  'init':   'ctrlp#gtags#init()',
	\  'exit':   'ctrlp#gtags#exit()',
	\  'accept': 'ctrlp#gtags#accept',
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

function! ctrlp#gtags#init()
	let s = ''
	redir => s
	!global -f %
	redir END
	return	split( s, '\n' )[1:]
endfunction

function! ctrlp#gtags#accept( mode, str )
	call ctlp#exit()
endfunction

function! ctrlp#gtags#exit()
endfunction

if !exists( 'g:ctlp_buildlines' )
	let g:ctlp_buildlines = 0
endif
let s:id = g:ctlp_buildlines + len( g:ctrlp_ext_vars )
function! ctrlp#gtags#id()
	return s:id
endfunction

