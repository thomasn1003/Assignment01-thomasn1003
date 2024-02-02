;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Thomas Nguyen
;  Author email: thomasn1003@csu.fullerton.edu
;
;Program information
;  Program name: Average Driving Speed
;  Programming languages: One module in C, one in X86, and one in bash.
;  Date program began: 2024-Jan-11
;  Date of last update: 2024-Feb-22
;  Files in this program: driver.c, average.asm, r.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program is to calculate the average speed of Linda Garcia as she drives from Fullerton
;    to Santa Ana to Long Beach and back to Fullerton again
;
;This file:
;  File name: haverage.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -l hello.lis -o hello.o average.asm
;  Assemble (debug): nasm -g dwarf -l hello.lis -o average.o average.asm
;  Prototype of this function: double average();
; 
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


;Declaration section.
extern printf

extern fgets

extern stdin

extern strlen

extern scanf

global average

name_string_size equ 48


segment .data

prompt_your_name db "Please enter your first and last names: ", 0
prompt_your_title db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0
thank_you db "Thank you %s %s", 0ah, 0ah, 0

prompt_miles_fullerton_santaana db "Enter the number of miles travled from Fullerton to Santa Ana: ", 0
prompt_average_speed_fullerton_santaana db "Enter your average speed during that leg of the trip: ",0

prompt_miles_santaana_longbeach db 0ah, "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
prompt_average_speed_santaana_longbeach db "Enter your average speed during that leg of the trip: ", 0

prompt_miles_longbeach_fullerton db 0ah, "Enter the number of miles travled from Long Beach to Fullerton: ", 0
prompt_average_speed_longbeach_fullerton db "Enter your average speed during that leg of the trip: ", 0

processing_msg db 0ah, "The inputted data are being processed ", 0ah, 0ah, 0

result_total_distance db "The total distance traveled is %0.2lf miles. ", 10, 0
result_total_time db "The time of the trip is %0.2lf hours", 10, 0
result_average_speed db "The average speed during this trip is %0.2lf mph. ", 0ah, 0ah, 0

number_input db "%lf", 0
amount_of_speeds dq 3.0
total_distance dq 0.0
total_time dq 0.0
average_speed dq 0.0


segment .bss

align 64
backup_storage_area resb 832
user_name resb name_string_size
user_title resb name_string_size


segment .text
average:
    
;Back up the GPRs (General Purpose Registers)
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;Backup the registers other than the GPRs
mov rax,7
mov rdx,0
xsave [backup_storage_area]


;Introduction========================================================================

;Output prompt for your name
mov rax, 0
mov rdi, prompt_your_name
call printf

;Input your name 
mov rax, 0
mov rdi, user_name
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, user_name
call strlen
mov [user_name+rax-1], byte 0

;Output prompt for your title
mov rax, 0
mov rdi, prompt_your_title
call printf

;Input your title 
mov rax, 0 
mov rdi, user_title
mov rsi, name_string_size
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, user_title
call strlen
mov [user_title+rax-1], byte 0

;Output a personalized thank you message 
mov rax, 0
mov rdi, thank_you
mov rsi, user_title
mov rdx, user_name
call printf


;Fullerton to Santa Ana============================================================

;Output prompt miles traveled(Fullerton to Santa Ana)
mov rax, 0
mov rdi, prompt_miles_fullerton_santaana
call printf 

;Input miles traveled (Fullerton to Santa Ana)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;all fgets
call scanf
movsd xmm8, [rsp]
pop r9
pop r8

;Addition of first distance
mov rax, 0 
movsd xmm14, qword [total_distance]
addsd xmm14, xmm8


;Output prompt average speed(Fullerton to Santa Ana)
mov rax, 0
mov rdi, prompt_average_speed_fullerton_santaana
call printf 

;Input average speed(Fullerton to Santa Ana)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;call fgets
call scanf
movsd xmm9, [rsp]
pop r9
pop r8

;Addition of first average speed
mov rax, 0
movsd xmm15, qword[average_speed]
addsd xmm15, xmm9


;Santa Ana to Long Beach=========================================================

;Output prompt for miles traveled (Santa Ana to Long Beach)
mov rax, 0
mov rdi, prompt_miles_santaana_longbeach
call printf 

;Input miles traveled (Santa Ana to Long Beach)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;call fgets
call scanf
movsd xmm10, [rsp]
pop r9
pop r8

;Addition of second distance
mov rax, 0
addsd xmm14, xmm10

;Output prompt average speed(Santa Ana to Long Beach)
mov rax, 0
mov rdi, prompt_average_speed_santaana_longbeach
call printf 

;Input average speed(Santa Ana to Long Beach)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;call fgets
call scanf
movsd xmm11, [rsp]
pop r9
pop r8

;Addition of second speed 
mov rax, 0
addsd xmm15, xmm11


;Long Beach to Fullerton==========================================================

;Output prompt for miles traveled (Long Beach to Fullerton)
mov rax, 0
mov rdi, prompt_miles_longbeach_fullerton
call printf 

;Input miles traveled (Long Beach to Fullerton)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;call fgets
call scanf 
movsd xmm12, [rsp]
pop r9
pop r8

;Addition of third distance
mov rax, 0
addsd xmm14, xmm12

;Output prompt average speed(Long Beach to Fullerton)
mov rax, 0
mov rdi, prompt_average_speed_longbeach_fullerton
call printf 

;Input average speed(Long Beach to Fullerton)
mov rax, 0
mov rdi, number_input
push qword -9
push qword -9
mov rsi, rsp
;mov rdx, [stdin]
;call fgets
call scanf
movsd xmm13, [rsp]
pop r9
pop r8

;Addition of third speed 
mov rax, 0
addsd xmm15, xmm13


;Exit Outputs======================================================================

;Processing message 
mov rax, 0
mov rdi, processing_msg
call printf

; Output total distance
mov rax, 1
mov rdi, result_total_distance
movsd xmm0, xmm14
call printf

;Calculate total time
mov rax, 0
movsd xmm7, qword[amount_of_speeds]
divsd xmm15, xmm7
movsd xmm6, qword[total_time]
movsd xmm6, xmm14
divsd xmm14, xmm15

;Output total time
mov rax, 1
mov rdi, result_total_time
movsd xmm0, xmm14
call printf

; Output average speed
mov rax, 1
mov rdi, result_average_speed
movsd xmm0, xmm15
call printf

push qword 0
movsd [rsp], xmm15
;Return average speed to driver.c
;movsd xmm0, xmm15

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

movsd xmm0, [rsp]
pop rax

;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function average =====================================================