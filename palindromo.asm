section .text
global esPalindromo

esPalindromo:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]  ; Obtener el número entero
    mov ebx, eax        ; Copiar el número a ebx para su manipulación

    mov ecx, 0          ; Inicializar el contador
    mov edx, 0          ; Inicializar el reverso del número

    cmp eax, 0          ; Comprobar si el número es negativo
    jge check_palindrome_start ; Si no es negativo, continuar

    neg eax             ; Negar el número si es negativo
    jmp check_palindrome_start

check_palindrome_start:
    mov esi, 10         ; Divisor para obtener los dígitos
check_palindrome_loop:
    mov edx, 0          ; Limpiar edx para la división
    div esi             ; Dividir eax por 10, resultado en eax, residuo en edx
    add ecx, 1          ; Incrementar el contador de dígitos
    cmp eax, 0          ; Comprobar si eax es cero
    jz check_palindrome_end ; Si es cero, terminar el bucle
    jmp check_palindrome_loop ; Continuar el bucle

check_palindrome_end:
    mov esi, 10         ; Restaurar esi al divisor original

check_palindrome:
    cmp ecx, 1          ; Comprobar si solo hay un dígito
    jle es_palindrome   ; Si solo hay un dígito, es un palíndromo

    mov eax, ebx        ; Restaurar el número original a eax
    mov ecx, 0          ; Reinicializar el contador

reverse_loop:
    mov edx, 0          ; Limpiar edx para la división
    div esi             ; Dividir eax por 10, resultado en eax, residuo en edx
    imul ecx, esi      ; Multiplicar el reverso por 10
    add ecx, edx        ; Agregar el último dígito al reverso
    cmp eax, 0          ; Comprobar si eax es cero
    jz check_reverse_palindrome_end ; Si es cero, terminar el bucle
    jmp reverse_loop    ; Continuar el bucle

check_reverse_palindrome_end:
    cmp ebx, ecx        ; Comparar el número original con su reverso
    je es_palindrome    ; Si son iguales, es un palíndromo
    jmp not_palindrome  ; Si no son iguales, no es un palíndromo

not_palindrome:
    mov eax, 0          ; No es un palíndromo
    jmp end_palindrome

es_palindrome:
    mov eax, 1          ; Es un palíndromo

end_palindrome:
    pop ebp
    ret
