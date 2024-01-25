#!/bin/bash

# ==================================================
# Author: Aingeru Garcia
# Date: 24th of January, 2024
# Github: https://github.com/geru-scotland
# Guide: https://github.com/geru-scotland/utilidades/tree/master/visualizacion-y-entornos-virtuales
# ==================================================

# ============= #
#  PARAMETERS   #
# ============= #
readonly PARAM_BROWSER="browser"
readonly PARAM_BROWSER_OBJ="browser_gobj"
readonly PARAM_TEST="test"

# 2º argumento, si queremos que el programa sea ejecutado
# después de la compilación
readonly PARAM_START="start"

# Limpieza y compilación completa.
readonly PARAM_CLEAN="clean"
readonly PARAM_ALL="all"

# ============= #
#  CMAKE FILES  #
# ============= #
readonly CMAKELISTS_FILE="CMakeLists.txt"
readonly CMAKE_CACHE="CMakeCache.txt"

# ============= #
#  EXEC FILES   #
# ============= #
# Nombres de ejecutables (cambiar con los nombres que tengáis en vuestro CMakeLists.txt)
# de manera que concidan con los definidos en add_executable y target_link_libraries.
readonly EXEC_BROWSER="browser_bin"
readonly EXEC_BROWSER_OBJ="browser_gobj"
readonly EXEC_TEST="test"

readonly DIR_MATH="Math"

echo -e "\033[1;35mIniciando script...\033[0m"

# Obtener directorio root del proyecto.
ROOT_DIR=$(pwd)

# Ejecuta make clean y luego compila en el directorio actual
# Nota: si quieres ver todos los mensajes quita:
# > /dev/null y > /dev/null 2> >(grep -v 'warning:' >&2)
build_current(){
    delete_cache
    echo -e "\033[33mEjecutando CMake...\033[0m"
    cmake $CMAKELISTS_FILE > /dev/null
    echo -e "\033[33mCompilando...\033[0m"
    make > /dev/null 2> >(grep -v 'warning:' >&2)

    # Compruebo si make ha petado.
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo -e "\033[1;31mError de compilación. Abortando...\033[0m"
        exit 1
    else
        local components=$@
        echo -e "\033[1;33mCompilación de ${components} en $(pwd) completada con éxito.\033[0m"
    fi
}

# Make clean en el directorio root y en Math
clean_builds() {
    echo -e "\033[33mLimpiando $(pwd)...\033[0m"
    make clean
    cd "$DIR_MATH"
    echo -e "\033[33mLimpiando $(pwd)...\033[0m"
    make clean
    cd "$ROOT_DIR"
}

# Borra caché de cmake
delete_cache() {
    if [ -f $CMAKE_CACHE ]; then
        echo -e "\033[33mBorrando $(pwd)/$CMAKE_CACHE...\033[0m"
        rm $CMAKE_CACHE
    fi
}

# Ejecuta programa en función del parámetro
execute_bin() {
    case $1 in
        $PARAM_BROWSER) ./$EXEC_BROWSER ;;
        $PARAM_BROWSER_OBJ) ./$EXEC_BROWSER_OBJ ;;
        $PARAM_TEST) ./$EXEC_TEST ;;
    esac
}

# Muestra la ayuda, intento rápido de estilo manual man
show_help() {
    echo "Uso de build_script.sh"
    echo ""
    echo "Introducción:"
    echo "Herramienta simple que facilita la compilación y gestión de ejecutables en el proyecto de la asignatura de Visualización y Entornos Virtuales."
    echo ""
    echo "Formato de Uso:"
    echo "./build_script.sh [param1] [param2]"
    echo ""
    echo "Parámetros:"
    echo "1. param1:"
    echo "   - all: Realiza la compilación completa del proyecto (directorio root y Math, por ahora). Puede llevar un tiempo."
    echo "   - clean: Limpia los directorios de compilación: elimina los ejecutables y otros archivos generados."
    echo "   - browser, browser_gobj, test: Compila el objetivo específico (test, compilará lo que exista en el directorio Math)"
    echo ""
    echo "2. param2 (opcional):"
    echo "   - start: Ejecuta el binario compilado inmediatamente después de la compilación. Solo aplicable si param1 es browser,"
    echo "     browser_gobj o test."
    echo ""
    echo "Ejemplo de Uso:"
    echo "./build_script.sh all           # Compila todo el proyecto"
    echo "./build_script.sh clean         # Limpia los directorios de compilación"
    echo "./build_script.sh browser start # Compila y ejecuta el browser"
    echo ""
    echo "Nota: Este script debe ser ejecutado desde el directorio raíz del proyecto."
}

# ============= #
#  MAIN LOGIC   #
# ============= #

# Si queremos compilar todo:
if [ "$1" = "$PARAM_ALL" ]; then
    build_current $EXEC_BROWSER " y " $EXEC_BROWSER_OBJ
    cd "$DIR_MATH"
    build_current $EXEC_TEST
    cd "$ROOT_DIR"
    echo -e "\033[1;35mScript finalizado satisfactoriamente.\033[0m"
    exit 0
fi

# Si únicamente queremos hacer make clean
if [ "$1" = "$PARAM_CLEAN" ]; then
    clean_builds
    echo -e "\033[1;35mScript finalizado satisfactoriamente.\033[0m"
    exit 0
fi

# Check del primer parámetro para ver qué compila
if [ "$1" = "$PARAM_TEST" ]; then
    cd "$DIR_MATH"
    build_current $EXEC_TEST
elif [ "$1" = "$PARAM_BROWSER" ] || [ "$1" = "$PARAM_BROWSER_OBJ" ]; then
    build_current $EXEC_BROWSER " y " $EXEC_BROWSER_OBJ
fi

echo -e "\033[1;35mScript finalizado satisfactoriamente.\033[0m"

# Si se le ha pasado start como segundo argumento
if [ "$2" = "$PARAM_START" ]; then
  execute_bin "$1"
fi

# Si no hay parámetros, muestro ayuda man
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

cd "$ROOT_DIR"

