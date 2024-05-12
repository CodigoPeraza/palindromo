#include <stdio.h>

int esPalindromo(char *);

int main() {
    char palabra[100];
    printf("Ingrese una palabra: ");
    scanf("%s", palabra);

    int resultado = 0;
    __asm__ (
        "push %[palabra]\n\t"
        "call esPalindromo\n\t"
        "mov %%eax, %[resultado]\n\t"
        "add $4, %%esp"
        : [resultado] "=g" (resultado)
        : [palabra] "g" (palabra)
        : "eax"
    );

    if (resultado) {
        printf("La palabra \"%s\" es un palíndromo.\n", palabra);
    } else {
        printf("La palabra \"%s\" no es un palíndromo.\n", palabra);
    }

    return 0;
}