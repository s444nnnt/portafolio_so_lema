# Semana 01 · Arquitectura de computadoras

Temas 1.1 – 1.3: bloques fundamentales de una computadora, funcionamiento (ciclo de instrucción, interrupciones y técnicas de E/S) y métricas de rendimiento.

Esta semana se automatiza un **inventario de hardware** con un script para Linux y otro para Windows. Cada script muestra el reporte en pantalla y lo guarda en `inventario_<equipo>.txt`.

## Contenido

| Archivo | Descripción |
|---------|-------------|
| [comandos.md](comandos.md) | Ayuda memoria de comandos Windows / Linux |
| [repolinux.sh](repolinux.sh) | Script de inventario de hardware (Linux, Bash) |
| [repowindows.ps1](repowindows.ps1) | Script de inventario de hardware (Windows, PowerShell) |
| `inventario_<equipo>.txt` | Captura de salida de cada script (una de Linux y una de Windows) |
| [teoria.md](teoria.md) | Resumen teórico y fórmulas |

## Qué incluye el reporte

- Nombre del equipo, fecha y sistema operativo
- CPU: modelo, núcleos, hilos y frecuencia
- Tamaños de caché L1, L2 y L3
- Memoria RAM total
- Discos: nombre, tipo y tamaño
- Extra: interfaces de red y dirección IP

## Cómo ejecutar

**Linux**
```bash
chmod +x repolinux.sh
./repolinux.sh
cat inventario_$(hostname).txt
```

**Windows (PowerShell)**
```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\repowindows.ps1
Get-Content "inventario_$env:COMPUTERNAME.txt"
```

## Notas

- En Linux, el tipo de disco se deduce de la columna `ROTA` de `lsblk` (1 = HDD, 0 = SSD).
- En Windows, la caché se lee de `Win32_CacheMemory`. En máquinas virtuales puede no estar disponible la L1.
- El script de Windows está escrito sin tildes a propósito para evitar problemas de codificación en PowerShell 5.1.
