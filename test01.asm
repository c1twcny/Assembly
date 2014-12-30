; (print2console.asm)
; nasm -f elf -g -F stabs print2console.asm
; ld -o p2c print2console.o -melf_i385
; ./p2c

section .data
    nln: dd 0xA
    nln_len: equ $-nln
    val: dd 48
    val_len: equ $-val
    spacer: dd " "

section .bss
    valueToPrint: resd 1 ; 1 resd = 4 resb (Dword = 4 bytes)

section .text
    global _start
_start:
    nop		; necessary for ld linking?
    call _newline
    call _print_string
    call _newline
    call _print_decimal
    call _newline
    jmp _norm_exit

_print_string:
    mov eax, 4		; sys_write
    mov ebx, 1		; stdout
    mov ecx, val	; 
    mov edx, val_len
    int 0x80		; or use 'syscall'
    jmp _return

_print_decimal:
    push '$'		; designate a stack base, no other particular reason...
    mov eax, [val]	; [val] to decimal

.conversion:
    mov [val], eax
    xor edx, edx	; zero out edx; there are other way...
    mov ecx, 10		; mod out a base 10 place value
    idiv ecx 		; signed divid
    add edx, 0x30	; convert the remainder to ascii

.hexrange:
    push edx
    mov [val], eax
    cmp eax, 0
    jnz .conversion	; break from loop when eax == 0

.printpostfix:
    pop eax
    mov [valueToPrint], eax	; store contents of 'eax' in [valueToPrint]
    cmp eax, '$'
    je _return
    mov eax, 4		; sys_write
    mov ebx, 1		; stdout
    mov ecx, valueToPrint
    mov edx, 1
    int 0x80		; invoke kernel to perform instruction
    jmp .printpostfix

_spacer:
    mov eax, 4
    mov ebx, 1
    mov ecx, spacer
    mov edx, 1
    int 80h
    jmp _return

_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, nln
    mov edx, 1
    int 80h
    jmp _return

_return:
    ret

_norm_exit:
    mov eax, 1		; initiate 'exit' syscall
    mov ebx, 0		; exit with error code 0
    int 0x80		; invoke kernel
    nop
    nop

