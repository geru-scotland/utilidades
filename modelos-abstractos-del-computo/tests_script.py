"""
#################################################################################
#################### SCRIPT PARA MOSTRAR RESULTADOS DE TESTS ####################
#################################################################################

Autor: Aingeru Garcia
Github: https://github.com/geru-scotland

Uso:
    python3 tests_script.py

Requisitos:
    - Python 3
    - El script lab08-random_3SAT.py debe estar en el mismo directorio o se debe
      proporcionar su ruta completa.

Este script es una utilidad para ejecutar múltiples veces otro script que contenga tests.
En nuestro caso, resuelven instancias del problema 3SAT Random en el laboratorio 8.
Su propósito es verificar si los asserts pasan debido a la aleatoriedad en las posibles
configuraciones de las variables o literales.

Utilizo código de retorno para comprobar si el test ha sido válido - pero depende del sistema
éste método puede no funcionar. No obstante se podría generalizar si simplemente introducimos
en el fichero que contenga los tests y donde corresponda:

    - print("TEST_PASSED")

Y después comprobamos el resultado de la ejecución mediante algo como:

    - if "TEST_PASSED" in result.stdout:

Los resultados serán mostrados en consola y, de manera adicional se creará un fichero llamado "tests_output.txt"
con output completo de los tests.

#################################################################################
#################################################################################
"""

import subprocess
import sys

# Definición de colores ANSI para el output en consola
ANSI_GREEN = "\u001b[32m"
ANSI_RED = "\u001b[31m"
ANSI_RESET = "\u001b[0m"


def run_tests(script_name, num_runs, output_file) -> None:
    """
    Ejecuta un script Python específico @num_runs veces y cuenta los tests pasados y fallidos.
    Muestra en tiempo real las estadísticas. De manera adicional, escribe el output en un fichero.

    :param script_name:  Nombre o ruta del script Python a ejecutar.
    :param num_runs: Número de veces que se ejecutará el script.
    :param output_file: Fichero donde se escribirá el output de los tests
    """
    tests_passed = 0
    tests_failed = 0

    with open(output_file, 'w') as file:
        for _ in range(num_runs):
            # Ejecuta el script Python especificado y captura tanto su salida estándar como los errores.
            # stdout=subprocess.PIPE redirige la salida estándar del script (normalmente se muestra en consola) para
            # que pueda ser capturada por el script.
            # stderr=subprocess.STDOUT redirige los errores estándar (mensajes de error) a la misma salida que stdout,
            # permitiendo capturar ambos. Redirección de errores es fundamental para evitar spam en consola.
            # text=True asegura que la salida se trate como texto (cadena decaracteres) en lugar de bytes.
            result = subprocess.run(['python3', script_name], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

            # Ver ejemplo en docstring para posibles alternativas al codigo de retorno.
            if result.returncode == 0:
                tests_passed += 1
            else:
                tests_failed += 1

            # Escribo en fichero el output del test actual, y actualizo la línea en la consola en lugar de imprimir
            # una nueva linea.
            file.write(result.stdout)
            sys.stdout.write(f"\r{ANSI_GREEN}TEST PASSED: {tests_passed}{ANSI_RESET} | {ANSI_RED}TEST FAILED: {tests_failed}{ANSI_RESET}")
            sys.stdout.flush()
        print()


# Parámetros
script = "lab08-random_3SAT.py"
output = "tests_output.txt"
runs = 200

# Ejecuto, se encarga de mostrar los contadores "a tiempo real".
print(f"Ejecutando {runs} tests...")
run_tests(script, runs, output)
print("Todos los tests finalizados.")
