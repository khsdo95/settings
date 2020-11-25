call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'git://git.wincent.com/command-t.git'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-abolish'
Plug 'Lokaltog/vim-easymotion'
Plug 'ronakg/quickr-cscope.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

filetype on
syntax on
set nu
set sw=2
set tabstop=2
set softtabstop=2
set expandtab
set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
set nocindent
set et
set modeline

au BufWritePost,BufFilePost solve.py call system("chmod +x ".expand("%"))
autocmd BufNewFile solve.py 0put =
\\"#!/usr/bin/python\<nl>
\from pwn import *
\\<nl>\<nl>
\context.terminal \= \['tmux', 'splitw', '-h'\]\<nl>
\context.log_level \= 'debug'\<nl>
\local = True\<nl>
\elf = ELF()\<nl>\<nl>
\if local:\<nl>
\  libc = ELF()\<nl>
\  p = process()\<nl>
\else:\<nl>
\  libc = ELF()\<nl>
\  p = remote()\<nl>\<nl>
\def r(delim\='\\n'):\<nl>
\  p.recvuntil(delim)\<nl>\<nl>
\def s(st, line\=True):\<nl>
\  if line:\<nl>
\    p.sendline(st)\<nl>
\  else:\<nl>
\    p.send(st)\<nl>
\\"|$

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

