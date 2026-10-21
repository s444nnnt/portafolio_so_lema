# Ayuda memoria · Memoria y caché

| Tarea | Linux | Windows (PowerShell) |
|-------|-------|----------------------|
| Arquitectura | `uname -m` | `$env:PROCESSOR_ARCHITECTURE` |
| Orden de bytes | `lscpu \| grep 'Byte Order'` | `[BitConverter]::IsLittleEndian` |
| Cachés | `lscpu --caches` | `Get-CimInstance Win32_CacheMemory` |
| Datos de L1d | `/sys/devices/system/cpu/cpu0/cache/index0/` | (no expuesto de forma simple) |
| RAM total/libre | `free -h` | `(Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize` / `.FreePhysicalMemory` (KB) |
| Swap / paginación | `swapon --show` | `Get-CimInstance Win32_PageFileUsage` |
| Discos y tipo | `lsblk -d -o NAME,ROTA,SIZE` (ROTA 1 = HDD) | `Get-PhysicalDisk` |
| Compilar la demo | `gcc -O0 matriz.c -o matriz` | `gcc -O0 matriz.c -o matriz.exe` (MinGW) o WSL |

**Conjuntos de una caché:** `S = C / (L · A)`. Ej.: 32 KiB, línea 64 B, 8 vías → S = 64.  
**Tiempo medio de acceso:** `T = Tc + (1 − h) · Tm`.
