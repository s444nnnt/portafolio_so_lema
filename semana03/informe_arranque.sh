#!/usr/bin/env bash
# =============================================================================
#  Deber 3 · Informe de arranque (Linux)             COMPLETO
#  Sistemas Operativos · EPN · Semana 3
# -----------------------------------------------------------------------------
#  Autores:   <Integrante 1>, <Integrante 2>
#  Fecha:     <AAAA-MM-DD>
#  Uso de IA: <Declara aquí si usaste IA generativa y para qué, o escribe «No».>
# -----------------------------------------------------------------------------
#  Qué debe hacer: reunir en un archivo de texto cómo arrancó esta máquina.
#    Secciones 1, 2 y 3  → las empiezan en el Taller 2 (parte D).
#    Secciones 4, 5 y 6  → las terminan en casa.
#  Uso:       chmod +x informe_arranque.sh && ./informe_arranque.sh
#             (no debe necesitar sudo)
#  Entrega:   guárdalo como semana03/informe_arranque.sh en el repositorio
#             de la pareja y súbelo a GitHub (instrucciones al final).
#
#  Cómo completar: (completado) cada sección reemplaza el antiguo «PENDIENTE» por los comandos
#  que piden las pistas. Ejecuta el script después de cada sección.
# =============================================================================

set -u

EQUIPO="$(hostname -s 2>/dev/null || echo equipo)"
SALIDA="informe_arranque_${EQUIPO}_$(date +%Y%m%d_%H%M).txt"

titulo() {
    printf '\n=== %s ===\n' "$1"
}

tiene() {
    command -v "$1" >/dev/null 2>&1
}

# --- 1 · SO, versión y núcleo ------------------------- (Taller 2) ----------
seccion1() {
    titulo "1 · Sistema operativo, versión y núcleo"
    # Pista: el archivo /etc/os-release tiene la variable PRETTY_NAME.
    #        Puedes cargarlo con «. /etc/os-release» y luego usar $PRETTY_NAME.
    # Pista: «uname -r» da la versión del núcleo y «uname -m» la arquitectura.
    . /etc/os-release 2>/dev/null
    echo "Sistema operativo: ${PRETTY_NAME:-desconocido}"
    echo "Nucleo (kernel):   $(uname -r)"
    echo "Arquitectura:      $(uname -m)"
}

# --- 2 · Último arranque y uptime --------------------- (Taller 2) ----------
seccion2() {
    titulo "2 · Último arranque y tiempo encendido"
    # Pista: «uptime -s» da la fecha y hora del arranque; «uptime -p», cuánto
    #        tiempo lleva encendida en palabras.
    echo "Ultimo arranque:   $(uptime -s 2>/dev/null || who -b)"
    echo "Tiempo encendido:  $(uptime -p 2>/dev/null || uptime)"
}

# --- 3 · Desglose del arranque ------------------------ (Taller 2) ----------
seccion3() {
    titulo "3 · Desglose del arranque (systemd-analyze)"
    # Pista: «systemd-analyze time» imprime una línea con el tiempo de cada
    #        etapa (kernel, initrd, userspace). Muestra esa línea.
    # Reto:  si systemd-analyze no existe (usa la función «tiene»), muestra un
    #        aviso en lugar de fallar.
    if tiene systemd-analyze; then
        if sal="$(systemd-analyze time 2>/dev/null)"; then
            echo "$sal" | head -n 2
        else
            echo "AVISO: systemd no es el init de este equipo (WSL/contenedor); sin desglose."
        fi
    else
        echo "AVISO: systemd-analyze no esta disponible (WSL, contenedor o sin systemd)."
    fi
}

# --- 4 · Cinco unidades más lentas -------------------- (en casa) -----------
seccion4() {
    titulo "4 · Las 5 unidades que más tardaron en arrancar"
    # Pista: «systemd-analyze blame --no-pager» ordena las unidades de la más
    #        lenta a la más rápida. Quédate con las 5 primeras (head).
    if tiene systemd-analyze; then
        if sal="$(systemd-analyze blame --no-pager 2>/dev/null)"; then
            echo "$sal" | head -n 5
        else
            echo "AVISO: no hay datos de blame (systemd no es el init de este equipo)."
        fi
    else
        echo "AVISO: systemd-analyze no esta disponible."
    fi
}

# --- 5 · Módulos del núcleo --------------------------- (en casa) -----------
seccion5() {
    titulo "5 · Módulos del núcleo cargados"
    # Pista: «lsmod» lista los módulos; la primera línea es el encabezado.
    #        Cuenta los módulos (tail -n +2, wc -l) y muestra los 5 de mayor
    #        tamaño (columna 2: sort -k2,2 -n -r).
    if tiene lsmod; then
        echo "Modulos cargados: $(lsmod | tail -n +2 | wc -l)"
        echo "Los 5 de mayor tamano (modulo, bytes):"
        lsmod | tail -n +2 | sort -k2,2 -n -r | head -n 5 | awk '{printf "  %-24s %s\n", $1, $2}'
    else
        echo "AVISO: lsmod no esta disponible."
    fi
}

# --- 6 · Target por defecto y servicios fallidos ------ (en casa) -----------
seccion6() {
    titulo "6 · Target por defecto y servicios fallidos"
    # Pista: «systemctl get-default» da el target con el que arranca.
    #        «systemctl --failed --no-legend --plain» lista los servicios que
    #        fallaron. Si no hay ninguno, escribe «ninguno».
    if tiene systemctl; then
        echo "Target por defecto: $(systemctl get-default 2>/dev/null || echo desconocido)"
        fallidos="$(systemctl --failed --no-legend --plain 2>/dev/null)"
        echo "Servicios fallidos: ${fallidos:-ninguno}"
    else
        echo "AVISO: systemctl no esta disponible."
    fi
}

{
    echo "Informe de arranque · $EQUIPO · $(date '+%Y-%m-%d %H:%M')"
    seccion1
    seccion2
    seccion3
    seccion4
    seccion5
    seccion6
} | tee "$SALIDA"

echo
echo "Informe guardado en: $SALIDA"

# -----------------------------------------------------------------------------
#  Subir al portafolio (GitHub), desde la carpeta del repositorio de la pareja:
#    git pull
#    git add semana03/informe_arranque.sh
#    git commit -m "Semana 3: informe de arranque (Linux), secciones 1-3"
#    git push
#  Haz un commit al terminar el taller y otro al terminar en casa.
#  Cada integrante hace al menos un commit con su parte (criterio de la rúbrica).
# -----------------------------------------------------------------------------
