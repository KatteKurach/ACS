.286
.model small
.stack 100h
.data
    a dd 0.0
    b dd 0.0
    c dd 0.0

    str1 db 13,"Enter a = ",'$'
    str2 db 13,"b = ",'$'
    str3 db 13,"c = ",'$'
    str_many db 13,"Infinit set of solutions.",'$'
    str_non db 13,"no any set of solutions ",'$'

    length dw 0
    after_poin dw 0
    fminus dw 0   
    arr_len dw 0
    mass dw 100 dup(0)
    

    two dd 2.0
    four dd 4.0
    ten dd 10.0
    zero dd 0.0 
    one dd 1.0
    minus_one dd -1.0
    temp dw 0
    outp dd 0
    ost dw 0
    to_steck dw 0
    fufu dd 0
.code


read_fun PROC
    mov ax, 0
    mov length, ax
    mov after_poin, ax
    mov fminus, ax

cin:
    mov ah, 08h
    int 21h

;Check length
    mov cx, length
    sub cx, fminus       ; if was minus, delete it from length
    cmp after_poin, 0    ; if was dot, delete ot from length
    jz no_dot_yet 		 ;=
        sub cx, 1
no_dot_yet:
    cmp cx, 10
    ja totaL_length     ; if count of numbers < 10 we can add one more, otherwise we can only delete or enter
 
;Check lengh

    cmp al, '0'
    jl next                       
    cmp al, '9'
    ja next                       
   
    push ax
    mov ah, 02h
    mov dl, al
    int 21h
    pop ax

    mov dl, '0'
    sub al, dl
    mov ah, 0
    
    mov di, offset mass
    add di, length         ;move to position
    add di, length

    mov dx, 1
    cmp fminus, dx
    jne goto3
        dec di
        dec di
    goto3:
    mov dx, 0
    cmp after_poin, dx
    je goto4
        dec di
        dec di
    goto4:
    mov [di], ax           ;указывает на ячейку в 2 байта
    inc length

    mov ax, 0
    cmp after_poin, ax
    je read                       ;=
    inc after_poin
    
read:
   jmp cin 

next:
    cmp al, '-'
    jne next_s
        jmp minus
    next_s:
    cmp al, '.'     
    je p


totaL_length:
    cmp al, 8      
    je bsckspace
    cmp al, 13
    jne cin
        jmp enter
bsckspace:
    mov ax, 1
    cmp fminus, ax
    jne check3

check2:
    mov ax, 1
    cmp length, ax
    je delete_minus
    
check3:
    mov ax, 1
    cmp after_poin, ax
    je del_poin
    
    mov ax, 0
    cmp length, ax
    ja out
    jmp cin
    
del_poin:
    mov ax, 0
    mov after_poin, ax
    jmp clear_screen

delete_minus:
    mov ax, 0
    mov fminus, ax
    jmp clear_screen
    
out:
    mov ax, 0
    cmp after_poin, ax
    je clear_screen
    dec after_poin

   
clear_screen:
    dec length

    xor ax, ax   
    xor bx, bx    
    xor dx, dx    

    mov ah, 03h    
    int 10h    

    xor ax, ax    
    mov ah, 02h    
    dec dl    
    int 10h    
    push dx    
        
    mov ah, 02h    
    mov dl, ' '   
    int 21h    

    pop dx  
    mov ah, 02h   
    int 10h    

    jmp cin    

p:
    mov ax, 0
    cmp after_poin, ax
    je next_ss                     ;==
        jmp cin
    next_ss:
   
    mov ax, 0
    cmp fminus, ax
    je check                    
    
    mov ax, 2
    cmp length, ax
    jge write_point

    jmp cin

check:
    mov ax, 0
    cmp length, ax
    jne write_point
    jmp cin

write_point:
    inc after_poin
    inc length
    mov ah, 02h
    mov dl, '.'
    int 21h
           
    jmp cin

minus:
    mov ax, 0
    cmp length, ax
    je go
        jmp cin
    go:
    mov ax, 0
    cmp fminus, ax
    je next_w
        jmp cin
    next_w:
    mov ax, 1
    mov fminus, ax
    inc length

    mov ah, 02h
    mov dl, '-'
    int 21h

    jmp cin
enter:
    cmp after_poin, 1     ; If there is a dot at the end
    jnz no_dot_at_the_end  
        jmp cin
no_dot_at_the_end:
    mov ax, 0
    cmp length, ax
    jne go1
        jmp cin
    go1:
        mov ax, 1
        cmp fminus, ax
        jne go2
        cmp length, ax
        jne go2
            jmp cin
    go2:
        fld zero
        mov ax, 1
        cmp fminus, ax
        jne goto
            dec length

        goto:
        mov ax, 0
        cmp after_poin, ax
        je goto2
            dec length
        goto2:
        mov cx, length
        mov di, offset mass
    
    loooop:
        fmul ten
        mov ax, [di]
        mov temp, ax
        fiadd temp
        add di, 2
    loop loooop
        mov ax, 0
        cmp after_poin, ax
        je exit

        dec after_poin
        fld one

        mov cx, after_poin
        loop1:
            fmul ten
        loop loop1
        fdivp 

      exit:
        mov ax, 1
        cmp fminus, ax
        jne exit2
        fmul minus_one
    exit2:
        fstp outp
        ret
read_fun  endp



count_x PROC
    fld b
    fmul b

    
if_1:
    fld a 
    fcomp zero
    fstsw ax
    sahf
    jne to1
        jmp else_1
    to1:
    xor ax, ax

    fld b
    fcomp zero
    fstsw ax
    sahf
    je else_2

    fld a
    fmul c
    fmul four
    fsubp

    fld zero
    fcomp 
    fstsw ax
    sahf
    jna to2   
        jmp else_4
    to2:

    fsqrt
    fld st(0)
    fmul minus_one

if_D:
    fld b
    fmul minus_one
    faddp
    fdiv two
    fdiv a
    fstp outp

    call output
    call eol_w

    fld b
    fmul minus_one
    faddp
    fdiv a
    fdiv two
    fstp outp

    call output

    ret
else_2:
    fld c
    fld a
    fdivp
    fld zero
    fcomp
    fstsw ax
    sahf
    jb else_4

    fmul minus_one   
    fsqrt            
    fstp outp

    call output

    ret

else_1:
    fld b
    fcomp zero
    fstsw ax
    sahf
    jz else_3

    fld c
    fmul minus_one
    fld b
    fdivp
    fstp outp

    call output

    ret

else_3:
    fld c
    fcomp zero
    fstsw ax
    sahf
    jne else_4
    
    mov ah, 09h
    mov dx, offset str_many
    int 21h

    ret
else_4:
    mov ah, 09h
    mov dx, offset str_non
    int 21h

    ret
count_x endp




output PROC
    mov cx, 0
    mov arr_len, cx

    fld outp

    fld zero
    fcomp
    fstsw ax
    sahf
    jbe  ln   ;  >= 
        jmp put_minus
    ln:
write_number:
    fld one
    fld st(1)
    fprem

    fld zero
    fcomp 
    fstsw ax
    sahf
    je zero_check 
        mov ost, 1
    zero_check:
        fxch st(2)
        fsub st(0), st(2)
        while:
            fcom zero
            fstsw ax
            sahf
            je end_while

            fld ten
            fld st(1)
            fprem
            fsub st(2), st(0)
            
            fistp to_steck ;достаем из стека с удалением
            mov bx, to_steck
            push bx
            inc arr_len
            fstp ten
            fdiv ten
        jmp while

end_while:
        mov cx, arr_len

        mov ax, 0
        cmp ax, arr_len
        je exit_zero

        away_steck:
            pop bx
           
            mov ah, 02h
            add bl, '0'
            mov dl, bl         
            int 21h
        loop away_steck
ost2:
        fstp zero
        fstp one  

        fcom zero
        fstsw ax
        sahf
        je exit3

        mov ah, 02h
        mov dl, '.'
        int 21h
    
    mov cx, 0
write_ost:
    fcom zero
    fstsw ax
    sahf
    je exit3
    
    cmp cx, 5
    jz exit3
    inc cx

    fmul ten
    fld one
    fld st(1)
    fprem
    fxch st(2)
    fsub st(0), st(2)
    
    fistp to_steck
    mov bx, to_steck
    fstp one

    mov ah,02h
    add bl, '0'
    mov dl, bl
    int 21h

jmp write_ost 
    ret 
put_minus:
    fmul minus_one
    
    mov ah, 02h
    mov dl, '-'
    int 21h
    
    jmp write_number
exit_zero:
    mov ah, 02h
    mov dl, '0'
    int 21h
    jmp ost2
exit3:
    fstp fufu
    ret
output endp



eol_w PROC
    mov dl, 10
    mov ah, 02h
    int 21h

    mov dl, 13
    mov ah, 02h
    int 21h
    ret
eol_w endp



start:
    mov ax, @data
    mov ds, ax
    mov es, ax

    mov ah, 09h
    mov dx, offset str1
    int 21h

    call read_fun
    fld outp
    fstp a
    call eol_w

    mov ah, 09h
    mov dx, offset str2
    int 21h

    call read_fun
    fld outp
    fstp b
    call eol_w

    mov ah, 09h
    mov dx, offset str3
    int 21h

    call read_fun
    fld outp
    fstp c
    call eol_w

    call count_x

    mov ax, 4c00h
    int 21h
end start
