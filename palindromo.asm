section .text
global esPalindromo

esPalindromo:
    push ebp
    mov ebp, esp
    mov esi, [ebp + 8]  ; Obtener el puntero a la cadena de caracteres
    mov edi, esi        ; Apuntar al principio de la cadena

    ; Encontrar el final de la cadena
    xor ecx, ecx        ; Inicializar contador
    xor eax, eax        ; Clear EAX
    cld                 ; Dirección ascendente
    not ecx             ; ECX = -1
    mov ebx, ecx        ; Guardar el valor de -1 en EBX
    repne scasb         ; Buscar el final de la cadena
    not ecx             ; Invertir el resultado para obtener la longitud de la cadena
    dec esi             ; Retroceder un byte para apuntar al último carácter

    ; Mover edi al final de la cadena
    mov edi, esi
    add edi, ecx        ; Edi ahora apunta al final de la cadena

    ; Verificar si es un palíndromo
check_palindrome:
    cmp esi, edi        ; Si hemos llegado al centro
    jae es_palindrome   ; Si es un palíndromo

    ; Comparar caracteres simétricos
    mov al, [esi]
    mov ah, [edi]
    cmp al, ah
    jne not_palindrome  ; No es un palíndromo

    ; Incrementar esi y decrementar edi al mismo tiempo
    inc esi
    dec edi

    jmp check_palindrome

not_palindrome:
    mov eax, 0          ; No es un palíndromo
    jmp end_palindrome

es_palindrome:
    mov eax, 1          ; Es un palíndromo

end_palindrome:
    pop ebp
    ret
