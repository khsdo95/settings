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
let hi = 'tt'
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

set tags=/root/test/tags