.model small
.stack 100h
.data
        Dashes db "-------------------------------------------------------------------------------$"
        WelcomeMessage db 9,9,9,"Welcome to APU Cybersecurity Club$"
        CompetitionMessage db "Competition:",10,9
                           db "1. Capture the Flag",9,9,9,"RM10",10,9
                           db "2. Cyber Defense",9,9,9,"RM12",10,"$"
        WorkshopMessage db "Workshop:",10,9
                        db "3. Hacking Workshop",9,9,9,"RM5",10,9
                        db "4. Assembly Workshop",9,9,9,"RM7",10,"$"
        ActivityMessage db "Other Activity:",10,9
                        db "5. Simple Encryption",9,9,9,"RM8$"
        ChoiceMessage db "Which activity do you want to join?",10
                      db "<Other Input to EXIT>: $"
        ExitMessage db "Thank you and have a good day ._.$"
        TotalPriceMessage db "Total Price: RM$"
        RepeatMessage db "Do you want to repeat the activity selection process?",10
                      db "<Y - Yes / N - No>: $"
        MemberMessage db "Are you a club member? ",10
                      db "<Y - Yes / N - No>: $"
        totalPrice dw 0
        remainder db 0
        fifty_cents db 0
        two db 2
        ten db 10
        hundred db 100
.code

main:
        ;-----Set DS to point the data segment-----
        mov ax,@data
        mov ds, ax
        
        ;-----Display the Welcome Message-----
        call print_dashes
        mov ah, 09h
        lea dx, WelcomeMessage
        int 21h

loop1:
;-----Display the all the workshops,challenges and activities and its fee-----
        call print_dashes
        call next_line
        mov ah, 09h
        mov bl, 12 ; light red text
        mov cx, 12 ; 12 characters
        int 10h
        lea dx, CompetitionMessage
        int 21h

        mov bl, 10 ; light green text
        mov cx, 9  ; 9 characters
        int 10h
        lea dx, WorkshopMessage
        int 21h

        mov bl, 09 ; light blue text
        mov cx, 15  ; 15 characters
        int 10h
        lea dx, ActivityMessage
        int 21h
        call next_line
        call print_dashes

        ;-----Display the choice message
        call next_line
        mov ah, 09h
        lea dx, ChoiceMessage
        int 21h
        
        ;-----Ask for an input-----
        mov ah, 01h
        int 21h

        ;-----Compare input-----
        mov ah, 00
        cmp al, '1'
        je CaptureTheFlag
        cmp al, '2'
        je CyberDefenseCompetition
        cmp al, '3'
        je HackingWorkshop
        cmp al, '4'
        je AssemblyWorkshop
        cmp al, '5'
        je SimpleEncryption
        jmp fin

Repeat:
;-----Repeat process-----
        call next_line;
        call print_sum ; print current total price
       
        mov ah, 09h
        lea dx, RepeatMessage ; print repeat message
        int 21h

        mov ah, 01h ; get input
        int 21h

        mov ah, 00
        cmp al, 'y'
        je loop1
        cmp al, 'Y'
        je loop1
        jmp fin
CaptureTheFlag:
        ;-----Firse Activity-----
        mov ax, totalPrice
        add ax, 10
        mov totalPrice, ax
        jmp Repeat
CyberDefenseCompetition:
        ;-----Second Activity-----
        mov ax, totalPrice
        add ax, 12
        mov totalPrice, ax
        jmp Repeat
HackingWorkshop:
        ;-----Third Activity-----
        mov ax, totalPrice
        add ax, 5
        mov totalPrice, ax
        jmp Repeat
AssemblyWorkshop:
        ;------Fourth Activity-----
        mov ax, totalPrice
        add ax, 7
        mov totalPrice, ax
        jmp Repeat
SimpleEncryption:
        ;-----Fifth Activity-----
        mov ax, totalPrice
        add ax, 8
        mov totalPrice, ax
        jmp Repeat

print_sum PROC
        call next_line
        ;-----Print the sum PROCEDURE-----
        mov ah, 09h
        mov bl, 14 ; yellow text
        mov cx, 12 ; 12 character
        int 10h
        lea dx, TotalPriceMessage
        int 21h

        ;-----Compare the price-----
        mov ax, totalPrice
        cmp ax, 10
        jl LessThanHundred
        jmp MoreThanHundred

LessThanHundred:
        ;-----if the price is less than 100
        mov ah, 00
        div ten     ; al-integer, ah-remainder  

        mov dl, ah  ; store ah(remainder) to remainder
        mov remainder, dl

        mov dl, al
        add dl, 48  ; add 48 to display the number in ascii  
        mov ah, 02h
        int 21h

        mov dl, remainder ;copy remainder to dl
        add dl, 48  ; add 48 to display the number in ascii
        mov ah, 02h
        int 21h
        jmp Fifty_cent

MoreThanHundred:
        ;-----if the price is more than 100-----
        mov ah, 00
        div hundred

        mov dl, ah
        mov remainder, dl

        mov dl, al
        add dl, 48
        mov ah, 02h
        int 21h

        mov ah, 00
        mov al, remainder
        div ten
        mov dl, ah
        mov remainder, dl

        mov dl, al
        add dl, 48
        mov ah, 02h
        int 21h

        mov dl, remainder
        add dl, 48
        mov ah, 02h
        int 21h
        
Fifty_cent:
        ;-----If the price have 50 cents or not-----
        cmp fifty_cents, 1
        je Yes
        jmp No
Yes:
        mov ah, 02h
        mov dl, 46 ; print '.'
        int 21h

        mov dl, 53 ; print '5'
        int 21h

        mov dl, 48 ; print '0'
        int 21h

No:
        call next_line
        ret      ;return

print_sum ENDP

check_member PROC
        ;-----Check if the user is a member of not PROCEDURE-----
        call next_line
        call next_line
        mov ah, 09h
        lea dx, MemberMessage
        int 21h

        mov ah, 01h
        int 21h

        cmp al, 'Y'
        je YesMember
        cmp al, 'y'
        je YesMember
        jmp NoMember
YesMember:
        ;-----if user is a member-----
        mov ah, 00
        mov ax, totalPrice
        div two
        mov totalPrice, ax
        mov dl, ah            ;move remainder to dl
        mov fifty_cents, dl   ;store the remainder into fifty_cents(either 0 or 1)

NoMember:
        ;-----if user is not a member-----
        call next_line
        ret
check_member ENDP

next_line PROC
        ;-----move to the next line PROC-----
        mov ah, 02h
        mov dl, 10
        int 21h
        ret
next_line ENDP
                    
print_dashes PROC
        ;-----print a line of dashes PROC
        call next_line
        mov ah, 09h
        mov bl, 6 ; brown
        mov cx, 79 ; 79 characters
        int 10h
        lea dx, Dashes
        int 21h
        call next_line
        ret
print_dashes ENDP

fin:
        ;-----Check if the user is member or not-----
        call check_member
        ;-----Print the sum and exit the program-----
        call print_dashes
        call print_sum
        call next_line
        mov ah, 09h
        lea dx, ExitMessage
        int 21h
        call next_line
        call print_dashes
        mov ah, 4ch
        int 21h
end main
