#include <stdio.h>
#include <stdlib.h> // Para usar la función strtol
#include <string.h> // Para usar la función strlen

int esPalindromo(char *);

int main() {
    char input[100];
    printf("Ingrese un número: ");
    fgets(input, sizeof(input), stdin);

    // Eliminar el salto de línea al final del input ingresado por fgets
    if ((strlen(input) > 0) && (input[strlen(input) - 1] == '\n')) {
        input[strlen(input) - 1] = '\0';
    }

    // Verificar si el input está vacío (solo se presionó Enter)
    if (strlen(input) == 0) {
        printf("No ingresaste ningún número.\n");
        return 1; // Salir del programa con código de error
    }

    // Convertir el input a un número entero
    char *endptr;
    long int numero = strtol(input, &endptr, 10);

    // Verificar si la conversión fue exitosa
    if (*endptr != '\0') {
        printf("El input no es un número válido.\n");
        return 1; // Salir del programa con código de error
    }

    // Verificar si el número tiene más de 10 dígitos
    if ((numero > 9999999999) || (numero < -999999999)) {
        printf("El número ingresado tiene más de 10 dígitos.\n");
        return 1; // Salir del programa con código de error
    }

    // Llamar a la función esPalindromo si el input es un número válido
    int resultado = 0;
    __asm__ (
        "push %[numero]\n\t"
        "call esPalindromo\n\t"
        "mov %%eax, %[resultado]\n\t"
        "add $4, %%esp"
        : [resultado] "=g" (resultado)
        : [numero] "g" (numero)
        : "eax"
    );

    if (resultado) {
        printf("El número \"%ld\" es un palíndromo.\n", numero);
    } else {
        printf("El número \"%ld\" no es un palíndromo.\n", numero);
    }

    return 0;
}
