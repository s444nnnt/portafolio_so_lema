#!/usr/bin/env bash
# =============================================================================
#  memoria.sh · Deber 2 (Semana 2) · Reporte de memoria del equipo (Linux)
#  Sistemas Operativos · EPN · FIEE
#  Autores:   <Integrante 1>, <Integrante 2>
#  Uso de IA: <declarar herramienta y para qué, o «No»>
#  Uso:       chmod +x memoria.sh && ./memoria.sh
#  Salida:    memoria_<equipo>.txt (junto al script)
#  Extra:     si existe ./matriz (gcc -O0 matriz.c -o matriz) añade sus tiempos.
# =============================================================================
carpeta="$(cd "$(dirname "$0")" && pwd)"
equipo="$(hostname -s 2>/dev/null || hostname)"
salida="$carpeta/memoria_${equipo}.txt"

{
  echo "== Equipo: $equipo   Fecha: $(date +%F)"
  . /etc/os-release 2>/dev/null && echo "== SO: ${PRETTY_NAME:-desconocido}"
  echo "== Arquitectura: $(uname -m)"
  lscpu | grep -i 'byte order'

  echo; echo "== Caches (lo que reporta el SO)"
  lscpu --caches 2>/dev/null || lscpu | grep -i cache

  echo; echo "== Conjuntos de la L1d: S = C / (L * A)"
  # sysfs: index0 suele ser L1d. Si no existe, se avisa.
  d=/sys/devices/system/cpu/cpu0/cache/index0
  if [ -r "$d/size" ] && [ -r "$d/ways_of_associativity" ] && [ -r "$d/coherency_line_size" ]; then
    c=$(( $(tr -dc '0-9' < "$d/size") * 1024 ))          # tamaño en bytes (valor en K)
    a=$(cat "$d/ways_of_associativity")
    l=$(cat "$d/coherency_line_size")
    echo "C = $c B, L = $l B, A = $a vias  ->  S = $(( c / (l * a) )) conjuntos"
  else
    echo "AVISO: este sistema no expone los datos de la L1d (WSL/VM)."
  fi

  echo; echo "== RAM y swap"; free -h

  echo; echo "== Discos (nombre, tipo, tamano)"
  lsblk -dn -e 7,11 -o NAME,ROTA,SIZE 2>/dev/null | while read -r n r s; do
    [ "$r" = "1" ] && t=HDD || t=SSD
    echo "$n  $t  $s"
  done

  echo; echo "== Extra: tiempos de matriz"
  if [ -x "$carpeta/matriz" ]; then "$carpeta/matriz"; "$carpeta/matriz" c
  else echo "AVISO: compila antes con: gcc -O0 matriz.c -o matriz"; fi
} | tee "$salida"

echo; echo "Reporte guardado en: $salida"
