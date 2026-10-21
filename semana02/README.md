# Semana 02 · Modelo de programación, memoria y datos

**Deber 2 · Reporte de memoria del equipo.** Cada script muestra el reporte y lo guarda en `memoria_<equipo>.txt`.

| Archivo | Descripción |
|---------|-------------|
| [comandos.md](comandos.md) | Ayuda memoria de comandos de memoria y caché (Linux / Windows) |
| [memoria.sh](memoria.sh) | Reporte de memoria (Linux, Bash) |
| [memoria.ps1](memoria.ps1) | Reporte de memoria (Windows, PowerShell) |
| [matriz.c](matriz.c) | Demo de localidad: recorrido por filas vs columnas (extra) |
| `memoria_<equipo>.txt` | Captura de salida de cada script (**pendiente de subir**) |

El reporte incluye: equipo, SO y fecha; arquitectura y orden de bytes; cachés L1d/L1i/L2/L3; conjuntos de la L1d (S = C / (L·A)); RAM total/libre y swap o paginación; discos (nombre, tipo, tamaño); y los tiempos de `./matriz` y `./matriz c`.

## Ejecutar
```bash
# Linux / WSL
gcc -O0 matriz.c -o matriz
chmod +x memoria.sh && ./memoria.sh
```
```powershell
# Windows
.\memoria.ps1
```
Al terminar, suban el `memoria_<equipo>.txt` generado en cada sistema (nombres distintos para no pisarse).
