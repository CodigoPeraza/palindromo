section .text
global esPalindromo

esPalindromo:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]  ; Obtener el número entero
    mov ebx, eax        ; Copiar el número a ebx para su manipulación

    mov ecx, 0          ; Inicializar el contador de dígitos
    mov edx, 0          ; Inicializar el reverso del número

inicio_verificacion_palindromo:
    mov esi, 10         ; Divisor para obtener los dígitos
bucle_verificacion_palindromo:
    mov edx, 0          ; Limpiar edx para la división
    div esi             ; Dividir eax por 10, resultado en eax, residuo en edx
    add ecx, 1          ; Incrementar el contador de dígitos
    cmp eax, 0          ; Comprobar si eax es cero
    jz fin_verificacion_palindromo ; Si es cero, terminar el bucle
    jmp bucle_verificacion_palindromo ; Continuar el bucle

fin_verificacion_palindromo:
    mov esi, 10         ; Restaurar esi al divisor original

comprobar_palindromo:
    cmp ecx, 1          ; Comprobar si solo hay un dígito
    jle es_palindromo   ; Si solo hay un dígito, es un palíndromo

    mov eax, ebx        ; Restaurar el número original a eax
    mov ecx, 0          ; Reinicializar el contador

bucle_reverso:
    mov edx, 0          ; Limpiar edx para la división
    div esi             ; Dividir eax por 10, resultado en eax, residuo en edx
    imul ecx, esi       ; Multiplicar el reverso por 10
    add ecx, edx        ; Agregar el último dígito al reverso
    cmp eax, 0          ; Comprobar si eax es cero
    jz fin_comprobar_reverso_palindromo ; Si es cero, terminar el bucle
    jmp bucle_reverso   ; Continuar el bucle

fin_comprobar_reverso_palindromo:
    cmp ebx, ecx        ; Comparar el número original con su reverso
    je es_palindromo    ; Si son iguales, es un palíndromo
    jmp no_palindromo   ; Si no son iguales, no es un palíndromo

no_palindromo:
    mov eax, 0          ; No es un palíndromo
    jmp fin_palindromo

es_palindromo:
    mov eax, 1          ; Es un palíndromo

fin_palindromo:
    pop ebp
    ret
