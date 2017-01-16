; nasm -f elf -F stabs test.asm -l test.lst
; ld ld -o test.exe test.o -lcygwin -lkernel32

  ;        extern  _cygwin_crt0
  ;        extern  _write
  ;        extern  _exit
          extern  _GetStdHandle@4
          extern  _WriteFile@20
          extern  _ExitProcess@4

          segment .data
string    db      'Hello.', 0Ah, 0h

stdout    dw      0




; Execution begins at the start of the .text section, here.

          segment .text
entry:    push    -11                  ; Request standard output handle
          call    _GetStdHandle@4
          mov     [stdout],eax

;         Use WriteFile to emit our message

          push    0                    ; no overlapped structure
          push    0                    ; no returned length written
          mov     esi,string
          call    len
          push    ecx
          push    string
          push    dword [stdout]
          call    _WriteFile@20

;         Exit

          push    0                    ; exit code 0
          call    _ExitProcess@4


; Assembly code prototyping for Oberon code generation

          mov     eax,[123]
          mov     eax,[eax+123]
          mov     eax,[ecx+123]
          mov     eax,[edx+123]
          mov     eax,[ebx+123]
          mov     eax,[esp+123]
          mov     eax,[ebp+123]
          mov     eax,[esi+123]
          mov     eax,[edi+123]
          mov     eax,[eax]
          mov     eax,[ecx]
          mov     eax,[edx]
          mov     eax,[ebx]
          mov     eax,[esp]
          mov     eax,[ebp]
          mov     eax,[esi]
          mov     eax,[edi]

          mov     [eax],eax
          mov     [ecx],eax
          mov     [edx],eax
          mov     [ebx],eax
          mov     [esp],eax
          mov     [ebp],eax
          mov     [esi],eax
          mov     [edi],eax

          add     eax,[eax]
          or      eax,[eax]
          adc     eax,[eax]
          sbb     eax,[eax]
          and     eax,[eax]
          sub     eax,[eax]
          xor     eax,[eax]

          add     ax,[eax]
          add     al,[eax]
          add     ah,[eax]

          push    eax
          push    ecx
          push    edx
          push    ebx
          push    esp
          push    ebp
          push    esi
          push    edi

          pop     eax
          pop     ecx
          pop     edx
          pop     ebx
          pop     esp
          pop     ebp
          pop     esi
          pop     edi

          mov     eax,[esp+4]

          push    ebp
          mov     ebp,esp

          pop     ebp




;;        len - return length of string
;
;         entry   esi - address of string
;
;         exit    ecx - length of string

len:      mov     ecx,esi

len2:     lodsb
          test    al,al
          jnz     len2

          xchg    ecx,esi
          sub     ecx,esi
          dec     ecx
          ret






; ; Now use the cygwin / C run time system to write our message
;
;
; initcrt:  push    _main2               ; Initialize the C runtime
;           call    _cygwin_crt0
;
;
;           global  _main2
; _main2:   mov     esi,string
;           call    len
;           push    ecx
;           push    string
;           push    1
;           call    _write
;           add     esp,12
;
;           call    _exit
;
;           ret

