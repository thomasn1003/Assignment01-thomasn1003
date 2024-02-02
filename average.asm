extern printf

extern fgets

extern stdin

extern strlen

global average

name_string_size equ 48



segment .data
    prompt_your_name db "Please enter your first and last names: ", 0
    prompt_your_title db "Please enter your title such as Lieutenant, Chief, Mr, Ms, Influencer, Chairman, Freshman, Foreman, Project Leader, etc: ", 0
    thank_you db "Thank you %s%s", 10,0

    prompt_miles_fullerton_santaana db "Enter the number of miles travled from Fullerton to Santa Ana: ", 0
    prompt_average_speed_fullerton_santaana db "Enter your average speed during that leg of the trip: ",0

    prompt_miles_santaana_longbeach db 0ah, "Enter the number of miles traveled from Santa Ana to Long Beach: ", 0
    prompt_average_speed_santaana_longbeach db "Enter your average speed during that leg of the trip: ", 0

    prompt_miles_longbeach_fullerton db 0ah, "Enter the number of miles travled from Long Beach to Fullerton: ", 0
    prompt_average_speed_longbeach_fullerton db "Enter your average speed during that leg of the trip: ", 0

    processing_msg db 0ah, "The inputted data are being processed ", 0ah, 0ah, 0

    total_distances db "The total distance traveled is %1.8lf miles. ", 10, 0
    total_time db "The time of the trip is %1.8lf hours", 10, 0
    average_speed db "The average speed during this trip is %1.8lf mph. ", 0ah, 0ah, 0

segment .bss
    align 64
    backup_storage_area resb 832

    user_name resb name_string_size
    user_title resb name_string_size
    number_input resb name_string_size
    miles1 resq 1
    speed1 resq 1
    miles2 resq 1
    speed2 resq 1
    miles3 resq 1
    speed3 resq 1
    total_distance resq 1
    time_of_trip resq 1
    average_speed_value resq 1

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

;Output a personalized thank you message 
mov rax, 0
mov rdi, thank_you
mov rsi, user_title
mov rdx, user_name
call printf


;Output prompt miles traveled(Fullerton to Santa Ana)
mov rax, 0
mov rdi, prompt_miles_fullerton_santaana
call printf 

;Input miles traveled (Fullerton to Santa Ana)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [miles1], xmm10

;Output prompt average speed(Fullerton to Santa Ana)
mov rax, 0
mov rdi, prompt_average_speed_fullerton_santaana
call printf 

;Input average speed(Fullerton to Santa Ana)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [speed1], xmm10


;Output prompt for miles traveled (Santa Ana to Long Beach)
mov rax, 0
mov rdi, prompt_miles_santaana_longbeach
call printf 

;Input miles traveled (Santa Ana to Long Beach)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [miles2], xmm10

;Output prompt average speed(Santa Ana to Long Beach)
mov rax, 0
mov rdi, prompt_average_speed_santaana_longbeach
call printf 

;Input average speed(Santa Ana to Long Beach)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [speed2], xmm10

;Output prompt for miles traveled (Long Beach to Fullerton)
mov rax, 0
mov rdi, prompt_miles_longbeach_fullerton
call printf 

;Input miles traveled (Long Beach to Fullerton)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [miles3], xmm10

;Output prompt average speed(Long Beach to Fullerton)
mov rax, 0
mov rdi, prompt_average_speed_longbeach_fullerton
call printf 

;Input average speed(Long Beach to Fullerton)
mov rax, 0
mov rdi, number_input
mov rsi, name_string_size
mov rdx, [stdin]
call fgets
mov rdi, number_input
movq xmm10, [rdi]
movsd [speed3], xmm10

;Processing message 
mov rax, 0
mov rdi, processing_msg
call printf

;Calculate total distance
mov rax, 0
movsd xmm10, [miles1]
addsd xmm10, [miles2]
addsd xmm10, [miles3]
movsd [total_distance], xmm10

;Calculate time of the trip
movsd xmm2, [speed1]
divsd xmm1, xmm2
movsd xmm3, [speed2]
divsd xmm1, xmm3
movsd xmm4, [speed3]
divsd xmm1, xmm4
movsd [time_of_trip], xmm1

; Calculate average speed
movsd xmm5, [total_distance]
divsd xmm5, [time_of_trip]
movsd [average_speed_value], xmm5

; Output total distance
mov rax, 0
mov rdi, total_distances
movq xmm10, [total_distance]
call printf

; Output time of the trip
mov rax, 0
mov rdi, total_time
movq xmm10, [time_of_trip]
call printf

; Output average speed
mov rax, 0
mov rdi, average_speed
movq xmm10, [average_speed_value]
call printf

;Restore the values to non-GPRs
mov rax,7
mov rdx,0
xrstor [backup_storage_area]

;Send back the number of characters
mov rax,r15

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