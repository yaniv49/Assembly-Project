TITLE ex3_q1  (ex3_q1.asm)
; Prints arrays using loop and recursion.
; Yaniv Sharabani, id: 308419472

INCLUDE Irvine32.inc
INCLUDE ex3_q1.inc
	
.code
myMain PROC
	mov edx, OFFSET STR1
	call writeString
	mov ecx, LENGTHOF ARR1				
	mov esi, OFFSET ARR1
	
	call print_arr_iter					;print array with loop			
	call print_arr_rec					;print array with recursion
	
	call CRLF
	mov edx, OFFSET STR2
	call writeString
	mov ecx, LENGTHOF ARR2				
	mov esi, OFFSET ARR2
	
	call print_arr_iter					;print array with loop
	call print_arr_rec					;print array with recursion				
	
	exit
myMain ENDP

print_arr_iter PROC USES eax ecx esi
		mov edx, OFFSET PRINT_ITER
		call writeString
		print_loop:
			mov eax,[esi]
			add esi, 4
			call writeInt
			mov al, ' '
			call writeChar
			loop print_loop
		call CRLF
		ret
print_arr_iter ENDP

print_arr_rec PROC USES eax ecx esi
	mov edx, OFFSET PRINT_REC
	call writeString
	mov edi, 0
	call arr_rec
	ret
print_arr_rec ENDP

arr_rec PROC
		mov eax,[esi]
		add esi, 4
		inc edi
		call writeInt
		mov al, ' '
		call writeChar
		cmp edi, ecx
		jne arr_rec
		call CRLF
		ret
arr_rec ENDP

END myMain