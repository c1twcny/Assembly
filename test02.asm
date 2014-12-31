section  .data ;Data segment
    userMsg db 'Please enter a number: ' ;Ask the user to enter a number
    lenUserMsg equ $-userMsg             ;The length of the message
    dispMsg db 'You have entered: '
    lenDispMsg equ $-dispMsg
    s3: db `\n`                 

section .bss            ;Uninitialized data
    num resb 5		;reserve 5 bytes:see www.nasm.us/doc/nasmdoc3.html
section .text           ;Code Segment
       global _start
       _start:
       ;User prompt
       mov eax, 4       ;sys_write <x86>
       mov ebx, 1       ;fd (stdio)
       mov ecx, userMsg
       mov edx, lenUserMsg
       int 0x80

       ;Read and store the user input
       mov eax, 3      ;sys_read <x86>
       mov ebx, 2
       mov ecx, num  
       mov edx, 5       ;5 bytes (numeric, 1 for sign) of that information
       int 0x80
       ;Output the message 'The entered number is: '
       mov eax, 4       ;sys_write <x86>
       mov ebx, 1       ;fd (stdout)
       mov ecx, dispMsg
       mov edx, lenDispMsg
       int 0x80  

       ;Output the number entered
       mov eax, 4       ;sys_write <x86>
       mov ebx, 1       ;fd (stdout)
       mov ecx, num
       mov edx, 5
       int 0x80
       
       mov eax, 4
       mov ebx, 1
       mov ecx, s3
       mov edx, 1
       int 0x80
       jmp _normal_exit
  
; Exit code
_normal_exit:
       mov eax, 1    ;sys_exit code <x86>
       mov ebx, 0    ;error code <x86>
       int 0x80	     ;invoke kernel

