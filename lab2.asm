.286
.model small
.stack 100h
.data
    str1 db 13,"Enter a = ",'$'
    str2 db 13,"Enter b = ",'$'
    str3 db 13,"Enter h = ",'$'
    str4 db 13,"Enter E = ",'$'
    str_error db 13,"Please, write a correct data.",'$'

    str_X db "x:",'$'
    str_Y db "Y(x):",'$'
    str_S db "S(x):",'$'
    str_N db "n:",'$'

    y dt 1000 dup(0.0)
    s dt 1000 dup(0.0)
    x dt 1000 dup(0.0)
    n dw 1000 dup(0)

    i dw 0
    k dw 0

    a dd 0.0
    b dd 0.0
    e dd 0.0
    h dd 0.0

    minus_two dd -2.0
    one dd 1.0
    zero dd 0.0
    two dd 2.0
    minus_one dd -1.0
    temp1 dd 0.0
    hundred dd 100.0
    fiftyh dd 500.0
    little_e dd 0.000001

    length dw 0
    after_poin dw 0
    fminus dw 0   
    arr_len dw 0
    mass dw 100 dup(0)
    

    four dd 4.0
    ten dd 10.0
    temp dw 0
    outp dd 0
    ost dw 0
    to_steck dw 0
    fufu dd 0

.code

count_y PROC
    mov ax, 0
    mov i, ax

    fld a
    loop11:
        fcom b
        fstsw ax
        sahf
        ja exit11

        fld st[0]
        fmul st[0], st[0]
        fdiv minus_two
        fadd one

        fld st[1]
        .386
        fcos
        .286
        fmulp

        fld st[1]
        .386
        fsin
        .286

        fld st[2]
        fdiv minus_two
        fmulp
        faddp

        call count_s
        mov si, offset y
        add si, i
        fstp tbyte ptr [si]
        
        mov si, offset x
        add si, i
        fstp tbyte ptr [si]
        fld tbyte ptr [si]

        mov bx, i
        add bx, 10
        mov i, bx
        fadd h
        jmp loop11

    exit11:
        ret
count_y endp


count_s PROC
    fld zero
    mov ax, 0
    mov k, ax

    loop22:
        fld st[0]
        fsub st[0], st[2]
        fabs
        
        fcomp e
        fstsw ax
        sahf

        jb exit22
        fld one
        mov cx, k
        add cx, k

        loop44:
            cmp cx, 0
            je go111
            fmul st[0], st[3]
        loop loop44

        go111: 
        fld one
        mov cx, k
        add cx, k
        loop33:
            cmp cx, 0 
            je next11
            mov temp, cx
            fimul temp
        loop loop33

        next11:
            fild k
            fimul k
            fmul two
            fadd one
            fmulp st[2], st[0]

            mov ax, k
            and ax, 1
            cmp ax, 1
            jne next22
            fmul minus_one

            next22:
                fdivp
                faddp
                inc k
                jmp loop22
    exit22:
         mov si,offset s
         add si, i
         fstp tbyte ptr [si]

         dec k

         mov bx, k
         mov si, offset n
         add si, i
         mov [si], bx
    
    ret
count_s endp


data_table PROC
    mov ax, 0
    mov i, ax
    mov bx, 0

    fld a

    call eol_w

    mov dx, 0
    mov ah, 03h ;cur position of cursor
    int 10h

    push dx

    mov ah, 09h ;output x
    mov dx, offset str_X
    int 21h

    pop dx
    
    mov ax, 0
    mov ah, 02h ; move position of cursor to 15 symbols
    add dl, 15
    int 10h

    push dx
    
    mov ah, 09h
    mov dx, offset str_Y
    int 21h

    pop dx

    xor ax, ax
    mov ah, 02h
    add dl, 15
    int 10h

    push dx

    mov ah, 09h
    mov dx, offset str_S
    int 21h

    pop dx

    xor ax, ax
    mov ah, 02h
    add dl, 15
    int 10h

    mov ah, 09h
    mov dx, offset str_N
    int 21h

    call eol_w

    loop55:
        fcom b
        fstsw ax
        sahf
        ja exit33
        
        mov si, offset x
        add si, i
        fld tbyte ptr [si]
        
        mov ah, 03h;cur pos of cursor
        int 10h

        push dx

        fstp outp
        call output

        pop dx

        mov ah, 02h;move to 15
        add dl, 15
        int 10h

        push dx

        mov si, offset y
        add si, i
        fld tbyte ptr [si]

        fstp outp
        call output

        pop dx
        
        mov ah, 02h
        add dl, 15
        int 10h
        
        push dx

        mov si, offset s
        add si, i
        fld tbyte ptr [si]

        fstp outp
        call output

        pop dx
        
        mov ah, 02h
        add dl, 15
        int 10h
        
                
        push dx

        mov si, offset n
        add si, i
        fild dword ptr [si]

        fstp outp
        call output

        pop dx
        
        mov ah, 02h
        add dl, 15
        int 10h
        
        call eol_w

        fadd h
        mov cx, i
        add cx, 10;whyyyyyy
        mov i, cx
        jmp loop55

    exit33:
       ret
data_table endp


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
    sub cx, fminus       
    cmp after_poin, 0    
    jz no_dot_yet 
        sub cx, 1
no_dot_yet:
    cmp cx, 10
    ja totaL_length      ; if count of numbers < 10 we can add one more, otherwise we can only delete or enter

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
    add di, length        
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
    mov [di], ax    ;указывает на ячейку в 2 байта
    inc length

    mov ax, 0
    cmp after_poin, ax
    je read              ;=
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
    je next_ss      ;==
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




output PROC
    mov cx, 0
    mov arr_len, cx

    fld outp

    fld zero
    fcomp
    fstsw ax
    sahf
    jbe  ln   ; >= 
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
            
            fistp to_steck 
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
    fadd little_e
    fstp b
    call eol_w

    mov ah, 09h
    mov dx, offset str3
    int 21h

    call read_fun
    fld outp
    fstp h
    call eol_w

    mov ah, 09h
    mov dx, offset str4
    int 21h

    call read_fun
    fld outp
    fstp e
    call eol_w
    

    fld a
    fcomp b
    fstsw ax
    sahf
    ja main_exit
    
    fld h
    fcomp zero
    fstsw ax
    sahf
    jb main_exit

    fld e
    fcomp little_e
    fstsw ax
    sahf
    jb main_exit

    fld b
    fsub a
    fdiv h
    fcomp fiftyh
    fstsw ax
    sahf
    ja main_exit

    call count_y
    call data_table

    
    mov ax, 4c00h
    int 21h

    main_exit:

    mov ah, 09h
    mov dx, offset str_error
    int 21h

    mov ax, 4c00h
    int 21h

end start

