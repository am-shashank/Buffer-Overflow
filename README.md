# Buffer-Overflow
Simple illustration of a buffer overflow attack to hack a naive buggy Login program written in C and spawn a interactive shell using shell code.

-------------------------------------------------------------
# Attack Methodology
-------------------------------------------------------------

The folowing piece of assembly code is used as the shellcode:


needle0: jmp there
here:    pop %rdi
         xor %rax, %rax
         movb $0x3b, %al
         xor %rsi, %rsi
         xor %rdx, %rdx
         syscall
there:   call here
.string \"/bin/sh\"
needle1: .octa 0xdeadbeef

In the above assembly code, the string "/bin/sh" is placed right after the call so that it is pushed on to the stack after the call. This is then popped onto rdi.
Afer a little bit of work, finally the interrupt gets called and the shell is loaded to memory using the "execv" system call or the "0x3b system call number".

Reference: http://crypto.stanford.edu/~blynn/rop/

The object dump of this shell code is taken and is overflown appropriately in the program as described below.

Stack contents before buffer overflow:

-----------------------
        password







-------------------------
        name






-------------------------
    evil        good
-------------------------
 base ptr   return addr
 
-------------------------

Stack contents after buffer overflow:

-------------------------
1234567\0







-------------------------
1234567\0
        NOP
     shell code






-------------------------
    0        0
-------------------------
addr of name addr of name

-------------------------

'name' and 'password' are given the same NULL terminated strings so that welcome() is called (and not evil() in which case, the program will exit)
Since, the original return address now has the address of name which has the shell code. The instruction pointer loads these instructions in memory
and executes them. The exec system call essentially replaces the image of the badbuf program in memory with the image of /bin/sh. So, we now have
a interactive terminal and the exploit has bene executed successfully.


-----------------------------------------------------------------------------------------------------------
Source Files
-----------------------------------------------------------------------------------------------------------

- badbuf.c - Program vulnerable to the buffer overflow attack

- badbuf_dummy.c - Auxillary C program which prints the address of the varibale on stack used as offset to calculate
the address of name. The output of this program is piped to the python program for further processing.

- generate_input.py - This program recevies the pointer address from the badbuf_dummy C program, calcualtes offset
and generates the appropriate input such that return address is overflown with the address of name.

- input - The output of the python program is written to this file which is fed as input to the badbuf program.
However, it is very important to note that the EOF has been removed from the input file using an additional cat command so that the shell doesn't
close it's stdin.

It is also important to note that the exploit works only on systems with stack protection and few other security features disabled.

