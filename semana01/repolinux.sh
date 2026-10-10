#!/usr/bin/env bash
# repolinux.sh · Sistemas Operativos · Semana 1
# Genera un inventario de hardware y lo guarda en inventario_<equipo>.txt
# (en la misma carpeta del script) y tambien lo muestra en pantalla.
#
# Uso:
#   chmod +x repolinux.sh
#   ./repolinux.sh

# Carpeta donde esta el script (para dejar ahi el .txt)
carpeta="$(cd "$(dirname "$0")" && pwd)"
equipo="$(hostname)"
salida="$carpeta/inventario_${equipo}.txt"

# Devuelve el valor de un campo de lscpu (ej: "Model name")
campo() { lscpu | awk -F: -v k="$1" '$1 == k { sub(/^[ \t]+/, "", $2); print $2; exit }'; }

{
  echo "===== INVENTARIO DE HARDWARE (Linux) ====="
  echo
  echo "== Equipo, fecha y sistema operativo"
  echo "Equipo : $equipo"
  echo "Fecha  : $(date '+%Y-%m-%d %H:%M:%S')"
  echo "SO     : $(. /etc/os-release 2>/dev/null; echo "${PRETTY_NAME:-desconocido}")"
  echo "Kernel : $(uname -r)"

  echo
  echo "== CPU"
  echo "Modelo   : $(campo 'Model name')"
  echo "Nucleos  : $(campo 'Core(s) per socket') por socket x $(campo 'Socket(s)') socket(s)"
  echo "Hilos    : $(campo 'CPU(s)') CPU logicas ($(campo 'Thread(s) per core') hilo(s) por nucleo)"
  frec="$(campo 'CPU max MHz')"
  # En maquinas virtuales "CPU max MHz" no existe: se usa /proc/cpuinfo
  [ -z "$frec" ] && frec="$(awk -F: '/cpu MHz/ { print $2; exit }' /proc/cpuinfo | tr -d ' ')"
  echo "Frecuencia (MHz): ${frec:-no disponible}"

  echo
  echo "== Cache"
  echo "L1d : $(campo 'L1d cache')"
  echo "L1i : $(campo 'L1i cache')"
  echo "L2  : $(campo 'L2 cache')"
  echo "L3  : $(campo 'L3 cache')"

  echo
  echo "== Memoria RAM"
  echo "Total : $(free -h | awk '/^Mem:/ { print $2 }')"

  echo
  echo "== Discos (nombre, tipo, tamano)"
  printf '%-12s %-6s %-10s %s\n' "NOMBRE" "TIPO" "TAMANO" "MODELO"
  lsblk -dn -e 7,11 -o NAME,SIZE,ROTA,MODEL | while read -r nombre tam rota modelo; do
    if [ "$rota" = "1" ]; then tipo="HDD"; else tipo="SSD"; fi
    printf '%-12s %-6s %-10s %s\n' "$nombre" "$tipo" "$tam" "$modelo"
  done

  echo
  echo "== EXTRA: interfaces de red y direccion IP"
  if command -v ip >/dev/null 2>&1; then
    ip -brief addr
  else
    echo "IP: $(hostname -I 2>/dev/null)"
  fi
} | tee "$salida"

echo
echo "Reporte generado: $salida"
