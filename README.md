<div align="center">

# Palíndromo en C + Ensamblador x86

**Verificador de números palíndromos que combina validación en C con la lógica del algoritmo en ensamblador x86 de 32 bits.**

![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white)
![Ensamblador x86](https://img.shields.io/badge/x86-Assembly-6E4C13?style=for-the-badge&logo=assemblyscript&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![GCC](https://img.shields.io/badge/GCC-A42E2B?style=for-the-badge&logo=gnu&logoColor=white)

</div>

## Descripción

Proyecto académico de integración entre C y ensamblador. El programa solicita un número al usuario, valida la entrada desde C y delega la comprobación del palíndromo a una función escrita en ensamblador x86 de 32 bits.

El objetivo es demostrar cómo conviven dos niveles de abstracción en un mismo binario: la gestión de entrada/salida y validación en un lenguaje de alto nivel, y la manipulación aritmética de registros y pila en ensamblador.

## Cómo funciona

1. `fgets` lee la entrada y se elimina el salto de línea.
2. Se rechazan entradas vacías, con más de 10 caracteres o con caracteres que no sean dígitos.
3. `strtol` convierte la cadena a `long int`.
4. C invoca `esPalindromo` mediante ensamblador inline.
5. La función en ensamblador cuenta los dígitos, construye el reverso del número y lo compara con el original.
6. El resultado se devuelve en `eax` (`1` = palíndromo, `0` = no palíndromo) y C imprime el mensaje final.

## Estructura

```text
palindromo/
├── palindromo.c      # Entrada, validación y llamada a la función ASM
├── palindromo.asm    # Implementación de esPalindromo en x86 de 32 bits
└── README.md
```

## Stack técnico

- **C** para la interfaz de consola, validación y conversión de datos.
- **Ensamblador x86 (NASM, `elf32`)** para la lógica del palíndromo.
- **Ensamblador inline de GCC** para el puente entre ambos lenguajes.
- **Linux** como entorno de compilación y ejecución.

## Requisitos

- GCC con soporte para compilación de 32 bits (`gcc-multilib` en Debian/Ubuntu).
- NASM.
- Sistema Linux x86 o un entorno compatible con binarios de 32 bits.

## Compilación y ejecución

```bash
nasm -f elf32 palindromo.asm -o palindromo_asm.o
gcc -m32 palindromo.c palindromo_asm.o -o palindromo
./palindromo
```

### Ejemplos

```text
Ingrese un número: 12321
El número "12321" es un palíndromo.
```

```text
Ingrese un número: 12345
El número "12345" no es un palíndromo.
```

## Decisiones técnicas destacadas

- **Separación de responsabilidades:** C gestiona la interacción con el usuario y el ensamblador concentra el algoritmo numérico.
- **Convención de llamada cdecl:** el argumento se recibe en `[ebp + 8]`, el retorno se entrega en `eax` y el llamador limpia la pila con `add $4, %esp`.
- **Uso de `div` e `imul`:** la reversión del número se construye dígito a dígito usando división y multiplicación por 10.
- **Validación defensiva:** se comprueba longitud, tipo de carácter y conversión antes de llamar al código de bajo nivel.
- **Ensamblador inline con restricciones:** se declaran entradas, salida y registros afectados (`eax`) para que el compilador mantenga la coherencia.

## Limitaciones conocidas

- La lógica en ensamblador opera con registros de 32 bits; aunque la entrada permite hasta 10 dígitos, valores fuera del rango de 32 bits pueden producir resultados incorrectos.
- El proyecto no incluye pruebas automatizadas.
- La compilación está pensada para Linux con soporte de 32 bits.

## Estado del proyecto

Funcional y orientado al aprendizaje de integración C/ASM, convenciones de llamada y aritmética a nivel de registros.

## Autor

**Francisco Javier Peraza** · [GitHub](https://github.com/CodigoPeraza) · [contacto.peraza@gmail.com](mailto:contacto.peraza@gmail.com)
