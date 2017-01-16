          bits    64

          section .data
msg:      db      'Hello.', 10, 0
msgl:     equ     $-msg


          section .text
          global  _start
_start:   mov     rax,1
          mov     rdi,1
          mov     rsi,msg
          mov     rdx,msgl
          syscall

          mov     rax,60
          mov     rdi,0
          syscall

