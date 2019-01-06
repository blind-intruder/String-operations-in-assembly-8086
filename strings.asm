;macro to print a variable
print macro var 
mov ah,09h
mov dx,offset var 
int 21h
endm
;macro end
.model small
.data
.stack 100h
take db 10,13, "Enter String:$"
take2 db 10,13, "Enter second String:$"
choice1 db 10,13, "Enter choice:$"
show db 10,13, "string:$"
reversed db 10,13, "reversed string:$"
cequal db 10,13, "Both are equal$"
nequal db 10,13, "Both are not equal$"
error db 10,13, "Enter corect choice:$"
found db 10,13, "Character is present:$"
nfound db 10,13, "Character is not present:$"
char db 10,13, "Enter character:$"
new_line db 10,13, "$"
menu db 10,13, "Menu:"
        db 10,13, "1) Reverse a string"
        db 10,13, "2) Compare two strings"
        db 10,13, "3) Scan a character in string"
        db 10,13, "0) Exit$"
string1 db 20 dup('$') 
string3 db 20 dup('$')
str1 db 25,?,25 dup(?) 
string2 db 20 dup("$")
.code
start:
mov ax,@data
mov ds,ax
mov es,ax

;take string from user
print take
mov ah,0ah
mov dx,offset string1
int 21h
;input end

call choice

;function to take choice of user
choice proc
print menu
print new_line
print choice1
call get_char
cmp al,'1'
je reverse
cmp al,'2'
je call_compare
cmp al,'3'
je scan
cmp al,'0'
je exit
print new_line
print error
ret
choice endp
;function end

exit:
mov ah, 4ch
int 21h

;label for reversing a string
reverse:
print take
mov ah,0ah
mov dx,offset str1
int 21h
lea si,str1+10
lea di,string2
std
mov cx,9
move:
movsb
add di,2
loop move
print new_line
print reversed
print new_line
print string2
call get_char
call choice
;label end

call_compare:
jmp compare


;label to scan a character
scan:
print char
mov ah,01
int 21h
lea si,string1+1
check:
inc si
cmp byte ptr[si],al
je cfound
cmp byte ptr[si],"$"
jne check
jmp notfound
cfound:
print found
call get_char
call choice
notfound:
print nfound
call get_char
call choice
;label end

;label to compare strings
compare:
print take2
mov ah,0ah
mov dx,offset string3
int 21h
lea si,string3
lea di,string1
mov bx,00
mov bl,string3+1
mov bh,string1+1
cmp bl,bh
jne l1
add si,2
add di,2
l2:
mov bl,byte ptr[si]
cmp byte ptr[di],bl
jne l1
inc si
inc di
cmp byte ptr[di],"$"
jne l2
print cequal
jmp l5
l1:
print nequal
l5:
print new_line
call get_char
call choice
;label end

;function to take choice from user
get_char proc
mov ah,01
int 21h
ret
get_char endp
;function end
end start
