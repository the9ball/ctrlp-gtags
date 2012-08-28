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
	" 入力ソース
	let l:s = input( 'Source ( empty : '.s:filename.' ) : ' )
	if empty( l:s )
		let l:s = s:filename
	endif

	" GTAGSファイルの場所を指定する。
	let l:p = $GTAGSROOT
	if empty( l:p )
		let l:p = s:cdir
	endif

	" コマンドを生成して実行
	let l:c = "GTAGSROOT=\'" . l:p . "\' global -af " . l:s
	let l:s = system( l:c )

	" リスト化して返す
	return split( l:s, "\n" )
endfunction

function! ctrlp#gtags#f#accept( mode, str )
	call ctrlp#exit()
		let l:str = substitute( a:str, '\s\+', ' ', 'g' )
		let l:list = split( l:str, " " )
		execute 'edit +' . l:list[1] . ' ' . l:list[2]
endfunction

function! ctrlp#gtags#f#exit()
endfunction

let s:filename = ''
let s:cdir = ''
function! ctrlp#gtags#f#id()
	" カレントファイル名
	let s:filename = expand('%:p')

	" カレントディレクトリ
	redir => s:cdir
	pwd
	redir END
	let s:cdir = substitute( s:cdir, "\n", "", "g" )

	" ID
	return g:ctrlp_builtins + len( g:ctrlp_ext_vars )
endfunction

