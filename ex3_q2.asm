TITLE ex3_q2  (ex3_q2.asm)
; Gets, sorts and prints an array.
; Yaniv Sharabani, id: 308419472

INCLUDE Irvine32.inc
INCLUDE ex3_q2.inc

.data
	N DWORD ?
	
.code
myMain PROC
	
	call read_arr_sort_print
	
	exit
myMain ENDP

read_arr_sort_print PROC
	n1 = -4
	n2 = n1 - 4
	mov edx, OFFSET MSG1
	call writeString
	call readInt
	mov N, eax
	
	mov ecx, N			;גודל המערך
	mov esi, esp	  	;כתובת תחילת המערך	
	
	mov edx, OFFSET MSG2
	call writeString
 	sub esp, N
 	sub esp, N
	push ebp
    mov ebp, esp
	sub esp, 8
	mov [ebp + n1], ecx  ;גודל המערך
	mov [ebp + n2], esi  ;כתובת תחילת המערך	
 	call read_arr
	
	mov edx, OFFSET MSG3
	call writeString
	call print_arr

	call sort_arr
	
	mov edx, OFFSET MSG4
	call writeString
	call print_arr
	
	mov esp, esi
	pop ebp
	ret
read_arr_sort_print ENDP

read_arr PROC
	NUM1 = 8
	NUM2 = NUM1 + 4
	push ebp
	mov ebp, esp
	
	mov ecx, [ebp + NUM2]	;גודל המערך
	push ecx
	mov esi, [ebp + NUM1]	;כתובת תחילת המערך
	push esi
	push_loop:
	   call readInt
	   mov [esi], ax
	   sub esi, 2
	   loop push_loop
	call CRLF
	
	pop esi
	pop ecx
	mov esp, ebp
	pop ebp
	ret
read_arr ENDP

sort_arr PROC uses esi ecx
	n1 = -4
	n2 = n1 - 4
	push ebp
	mov ebp, esp
	sub esp, 8
	mov ebx, esi					;שמירת כתובת ההתחלה של המערך
	mov edx, 0						;מונה מערך חיצוני
	mov edi, 0						;מונה מערך פנימי

 	loop1:
 		mov eax, N					;ARR_SIZE
		dec eax						;ARR_SIZE-1
 		cmp edx, eax   				;end of the array?  /i == ARR_SIZE-1
 		je done						;end of outer loop
		
		loop2:
			mov eax, N				;arr_size
			sub eax, edx			;arrsize-i
			dec eax					;arrsize-i-1
			cmp edi ,eax   			;end of the array?   /  j == ARR_SIZE-i-1
			je jump1				;end of inner loop
			
			mov [ebp + n1], esi
			mov ax, [esi]     		;arr[j]
			sub esi, 2			 	;j+1			
			mov [ebp + n2], esi
			
			cmp ax, [esi]  			;arr[j] > arr[j+1]
			jg swap1                ;swap if >
			jmp jump2				;new itr of inner loop
			
		jump1:
			inc edx					;i++
			mov esi, ebx			;הזזה לכתובת תחילת המערך
			mov edi, 0				;j=0
			jmp loop1				;new itr of outer loop
		jump2:
			inc edi					;j++
			jmp loop2				;new itr of inner loop
		swap1: call Swap
			  jmp jump2
	done:
		mov esp, ebp
		pop ebp
		ret
sort_arr ENDP

Swap PROC
	xptr = 8
	yptr = xptr + 4
	
	push ebp
	mov ebp, esp
	push edx
	push ecx
	push ebx
	
	mov edx, [ebp + xptr]
	mov ax, [edx]
	mov ebx, [ebp + yptr]
	mov cx, [ebx]
	mov [ebx], ax
	mov [edx], cx
	
	pop ebx
	pop ecx
	pop edx
	mov esp, ebp
	pop ebp
	ret
Swap ENDP

print_arr PROC USES ecx esi
	print_loop:
		mov bx, [esi]
		movsx eax, bx
		call WriteInt
		mov al, ' '
		call writeChar
		sub esi, 2
		loop print_loop
	call CRLF
	ret
print_arr ENDP

END myMain