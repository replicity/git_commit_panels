"=============================================================================
" File: git_commit_panels.vim
" Author: Natsumi Kojima
" Description
" Created: 2016-09-24
"=============================================================================
scriptencoding utf-8

if exists('g:loaded_git_commit_panels')
  finish
endif
let g:loaded_git_commit_panels = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:test()

  execute 'belowright split bottom'
  set filetype=diff
  let result = system("git diff HEAD")
  call setline(1, split(result, "\n"))
  setlocal readonly bufhidden=wipe nonumber buftype=nofile

  execute 'botright vsplit right'
  let result = system("git log --all --graph --pretty='format: %h %s (%an) %d'")
  call setline(1, split(result, "\n"))
  setlocal readonly bufhidden=wipe nonumber buftype=nofile

endfunction


augroup plugin-git_commit_panels
  autocmd!
  autocmd BufReadPost COMMIT_EDITMSG,MERGE_MSG  call s:test()
  autocmd QuitPre COMMIT_EDITMSG,MERGE_MSG  only
augroup END


let &cpo = s:save_cpo
unlet s:save_cpo
