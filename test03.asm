;
; nasm program contains three (3) sections:
; .data: declares constants
; .bss: declares variables
; .text: code; it must start with "global _start" for ld to locate the 
;        execution entry point of the program
;
; nasm source code line contains combination of the following fields:
; {label:} instruction {operands} {; comment}
; everything in {} is an optional field
;
; Note:
; (1) Following codes are for X86_64 architecture
; (2) Reference https://filippo.io/linux-syscall-table/ for detail info on
;     syscall/rax opcode mapping
; 



section .data
    msg: db 'Display 10 stars', `\n` ;using backquote for special character
    len: equ $-msg
    s2:  times 10 db '*'
    s3:  db `\n`

section .bss

section .text
    global _start
_start:
;Wiret 'Display 9 starts' on the screen
    mov	eax, 4 	;sys_write
    mov ebx, 1  ;fd (stdout)
    mov ecx, msg
    mov edx, len
    int 0x80	;call kernel

;Write 9 x '*' on the screen
    mov eax, 4	;sys_write
    mov ebx, 1	;fd (stdout)
    mov ecx, s2
    mov edx, 10 
    int 0x80

;Put the newline character at the end of '*'
    mov eax, 4
    mov ebx, 1
    mov ecx, s3
    mov edx, 1
    int 0x80	;call kernel

;End the execution
    mov eax, 1	;sys_exit
    int 0x80	;call kernel
 

