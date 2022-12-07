
source $VIMRUNTIME/defaults.vim

set number
set numberwidth=1
set laststatus=2
set background=dark

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors


packadd auto-pairs
packadd vimcdoc
packadd coc.nvim
"packadd copilot


function! Guienter()
	if has('win32')
		set guifont=JetBrains\ Mono:h15
		set guifontwide=Lxgw\ Wenkai\ Mono:h15
	elseif has('unix')
		set guifont=JetBrains\ Mono\ 20
		set guifontwide=Lxgw\ Wenkai\ Mono\ 20
	endif
	set guioptions-=m
	set guioptions-=T
	highlight Normal guibg=black guifg=white
endfunc

augroup guienter
	autocmd!
	autocmd GUIEnter * call Guienter()
augroup END



function! Cinit()
	if exists('g:did_coc_loaded') || v:version < 800
		inoremap <buffer> ; ;<c-r>=CocActionAsync('format')<cr>
		if has('win32')
			nnoremap <buffer> É :call CocActionAsync('format')<cr>
		elseif has('unix')
			nnoremap <buffer> I :call CocActionAsync('format')<cr>
		endif
	endif

	if exists('g:AutoPairs')
		let g:AutoPairs['/*']='*/'
	endif

	setlocal foldmethod=syntax
endfunc

function! AddMacroInH()
	let l:fn=substitute(toupper(expand('%')),'/','_',"g")
	let l:fn=substitute(l:fn,'\.','_','g')
	let l:fn=substitute(l:fn,'-','_','g')
	let l:fn=substitute(l:fn,'\','_','g')
	execute "normal i#ifndef __".l:fn."\<esc>"
	execute "normal o#define __".l:fn."\<esc>"
	execute "normal o\<cr>\<cr>\<cr>#endif\<esc>kk"
endfunc

function! Hinit()
	call AddMacroInH()
endfunc

augroup ftinit
	autocmd!
	autocmd FileType c,cpp call Cinit()
	autocmd BufNewFile *.h call Hinit()
augroup END



augroup optinit
	autocmd!
	autocmd FileType vim,nasm,asm setlocal foldmethod=indent
	autocmd FileType vim,nasm,c,asm normal zR
	autocmd FileType nasm,asm setlocal autoindent
	autocmd FileType markdown,html,css,yaml inoremap <buffer> <esc> <esc>:w<cr>
augroup END
