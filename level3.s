.intel_syntax noprefix
.global _start

.section .text

_start:
    mov rdi, 0x2 # AF_INET - Internet IP Protocol
    mov rsi, 0x1 # SOCK_STREAM - stream (connection) socket
    xor rdx, rdx # 0
    mov rax, 0x29 # 0x29 or 41 is the syscall value for socket()
    syscall # socket(AF_INET, SOCK_STREAM, 0)

    # struct sockaddr_in {
    #        sa_family_t     sin_family;     /* AF_INET */
    #        in_port_t       sin_port;       /* Port 80 */
    #        struct in_addr  sin_addr;       /* IPv4 address - 0.0.0.0 */
    #    };

    mov rdi, rax # socket file descriptor to rdi, the first parameter of bind()
    xor rax, rax
    push rax
    mov rbx, 0x0 # equivalent to 0.0.0.0
    push rbx
    movw [rsp-2], 0x5000 # Little endian for 0x0050, or 80
    movw [rsp-4], 0x2 # AF_INET = 0x2
    sub rsp, 4
    lea rsi, [rsp]
    mov rdx, 0x10 # address length
    mov rax, 0x31 # 0x31 or 49 is the syscall value for bind()
    syscall # bind an address to a socket

    xor rdi, rdi # 0
    mov rax, 0x3c # 0x3c or 60 is the syscall value for exit()
    syscall # exit(0)

.section .data
