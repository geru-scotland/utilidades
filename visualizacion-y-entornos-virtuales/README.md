# Introducción
`build_script.sh` es un script pensado para facilitar la compilación y gestión del proyecto de la asignatura de Visualización y Entornos Virtuales, el cual se basa en  ```CMake ``` y  ```Makefile ```. Permite compilar por programa o incluso el proyecto completo, también limpiar directorios de compilación, y ejecutar los programas resultantes tras la compilación. La idea es que agilizar el proceso de desarrollo de los ejercicios y/o proyecto y evitar la necesidad de cambiar de directorio y ejecutar múltiples comandos. Se irá mejorando e introduciendo nuevas funcionalidades conforme vayamos avanzando.

## Instalación y Ejecución
Para utilizar `build_script.sh`, primero se ha de otorgar permisos para que sea ejecutable. Con seguir estos pasos es sufciente:

1. **Hacer el script ejecutable:**
   ```bash
   chmod +x build_script.sh
   ```
2. **Ejecutar el script:**
   ```bash
   ./build_script.sh
   ```

   De manera alternativa, se puede ejecutar directamente con `sh`:
   ```bash
   sh build_script.sh
   ```

## Parámetros
Se aceptan varios parámetros para ejecutar sus diferentes funcionalidades:

1. **all**
   - Compila completamente el proyecto (puede llevar un tiempo).
   - Compila en los directorios root y `Math` (por ahora).
   - Ejemplo: `./build_script.sh all`

2. **clean**
   - Limpia los directorios de compilación con `make clean`.
   - Elimina ejecutables y otros archivos generados.
   - Ejemplo: `./build_script.sh clean`

3. **browser**, **browser_gobj**, **test**
   - Compila el objetivo específico:
   - `browser` y `browser_gobj`
   - `test` compila lo que se encuentre en el directorio `Math`.
   - Ejemplo: `./build_script.sh browser`

4. **start** (opcional)
   - Se usa como segundo parámetro.
   - Ejecuta el binario producido inmediatamente después de la compilación.
   - Aplicable solo con `browser`, `browser_gobj` o `test`.
   - Ejemplo: `./build_script.sh browser start`

## Ejemplos de Uso
Aquí algunos ejemplos de cómo usar `build_script.sh`:

- Compilar todo el proyecto:
  ```bash
  ./build_script.sh all
  ```
- Limpiar los directorios de compilación:
  ```bash
  ./build_script.sh clean
  ```
- Compilar y ejecutar el browser:
  ```bash
  ./build_script.sh browser start
  ```
- Compilar y ejecutar el programa test:
  ```bash
  ./build_script.sh test start
  ```

## Bugs y/o sugerencias
Para los que no estéis muy acostumbrados a GitHub y sistemas de incidencias, podéis utilizar el issue tracker para reportar bugs o hacer sugerencias:

https://github.com/geru-scotland/utilidades/issues

¡También podéis comentarme en clase!

## Mejoras pendientes
- Me gustaría mejorar el output y hacer que salga el porcentaje del progreso de compilación, y que esto fuera configurable con ```-v ``` (modo verbose o similar).
