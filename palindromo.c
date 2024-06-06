#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h> // Para usar la función isdigit

int esPalindromo(char *);

int main() {
    char entrada[100];
    printf("Ingrese un número: ");
    fgets(entrada, sizeof(entrada), stdin);

    // Eliminar el salto de línea al final de la entrada ingresada
    if ((strlen(entrada) > 0) && (entrada[strlen(entrada) - 1] == '\n')) {
        entrada[strlen(entrada) - 1] = '\0';
    }

    // Verificar si la entrada está vacía
    if (strlen(entrada) == 0) {
        printf("No ingresaste ningún número.\n");
        return 1; // Salir del programa con código de error
    }

    // Verificar si la entrada tiene más de 10 dígitos
    if (strlen(entrada) > 10) {
        printf("El número ingresado tiene más de 10 dígitos.\n");
        return 1; // Salir del programa con código de error
    }

    // Verificar que todos los caracteres sean dígitos
    for (int i = 0; i < strlen(entrada); i++) {
        if (!isdigit(entrada[i])) {
            printf("La entrada contiene caracteres no válidos.\n");
            return 1; // Salir del programa con código de error
        }
    }

    // Convertir la entrada a un número entero
    char *finPtr;
    long int numero = strtol(entrada, &finPtr, 10);

    // Verificar si la conversión fue exitosa
    if (*finPtr != '\0') {
        printf("La entrada no es un número válido.\n");
        return 1; // Salir del programa con código de error
    }

    // Llamar a la función esPalindromo en ensamblador
    int resultado = 0;
    __asm__ (
        "push %[numero]\n\t"     // Pasar el número a la pila
        "call esPalindromo\n\t"  // Llamar a la función esPalindromo
        "mov %%eax, %[resultado]\n\t" // Mover el resultado a la variable resultado
        "add $4, %%esp"          // Ajustar el puntero de la pila
        : [resultado] "=g" (resultado)
        : [numero] "g" (numero)
        : "eax"
    );

    // Imprimir el resultado
    if (resultado) {
        printf("El número \"%ld\" es un palíndromo.\n", numero);
    } else {
        printf("El número \"%ld\" no es un palíndromo.\n", numero);
    }

    return 0;
}
