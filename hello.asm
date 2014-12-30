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
    msg db	"Hello, World!", `\n` ;using backquote for special character

section .bss

section .text
    global _start
_start:
    mov	rax, 1	; sys_write 
    mov rdi, 1
    mov rsi, msg; store pointer to msg at rsi; 2nd argument in sys_write
    mov rdx, 14	; length of string, 3rd argument in sys_write
    syscall
    mov rax, 60	; sys_exit
    mov rdi, 0  ; error code; '0' means program exits successfuly
    syscall

