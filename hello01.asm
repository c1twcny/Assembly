;
; Created by: TWC
; Date:	Dec. 2014
; Version: 0.1.0
;
; =============================================================================
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
; ============================================================================= 
;



section .data
    msg db	"Hello there, it's really a beautiful world!", `\n` ;using backquote for special character
    msglen equ $-msg
    %define sys_write 1 ;macro definition of 'sys_write'
    %define sys_exit 60 ;macro definition of 'sys_exit'

section .bss

section .text
    global _start
_start:
    ;mov rax, 1	;sys_write <x86_64>
    mov rax, sys_write ;64-bit sys_write using macro  
    mov rdi, 1
    mov rsi, msg ;store pointer to msg at rsi; 2nd argument in sys_write
    mov rdx, msglen
    syscall	 ;kernel call: write output on a console
    jmp _norm_exit ;
    ;mov rax, sys_exit  ;sys_exit using macro; same as 'mov rax, 60'
    ;mov rdi, 0  ;error code; '0' means program exits successfuly
    ;syscall

_norm_exit:
    mov rax, sys_exit ;64-bit sys_exit using macro
    mov rdi, 0
    syscall
    nop

