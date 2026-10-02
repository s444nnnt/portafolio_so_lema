# Comandos · Semana 01

Comandos para verificar en un equipo real los bloques de la computadora.

## Tabla resumen

| Bloque | Linux (Bash) | Windows (PowerShell) |
|--------|--------------|----------------------|
| CPU | `lscpu` · `cat /proc/cpuinfo` | `Get-CimInstance Win32_Processor` |
| Memoria | `free -h` · `cat /proc/meminfo` | `Get-CimInstance Win32_PhysicalMemory` |
| Almacenamiento | `lsblk` · `df -h` | `Get-PhysicalDisk` · `Get-Volume` |
| Buses y E/S | `lspci` · `lsusb` | `Get-PnpDevice -PresentOnly` |
| Resumen | `sudo lshw -short` | `systeminfo` · `msinfo32` |

## Linux

### CPU
```bash
lscpu                          # arquitectura, núcleos, hilos, cachés
lscpu | grep -E 'Model name|Thread|Core|L1|L2|L3'
cat /proc/cpuinfo | head -30   # información por CPU lógica
nproc                          # número de CPU lógicas
```
Campos clave: `CPU(s)` = hilos totales; `Thread(s) per core` × `Core(s) per socket` = CPU lógicas; `L1d`/`L1i` separadas indica Harvard modificada.

### Memoria
```bash
free -h                        # RAM y swap en formato legible
cat /proc/meminfo | head -5    # detalle (MemTotal, MemFree, ...)
sudo dmidecode -t memory       # módulos físicos (requiere sudo)
```

### Almacenamiento
```bash
lsblk                          # discos y particiones
lsblk -d -o NAME,MODEL,SIZE,TYPE,ROTA   # ROTA=1 HDD, 0 SSD
df -h                          # espacio por sistema de archivos
```

### Buses y E/S
```bash
lspci                          # dispositivos PCI/PCIe (GPU, red, NVMe)
lspci -v | less                # detalle
lsusb                          # dispositivos USB
```

### Resumen y red
```bash
sudo lshw -short               # resumen de todo el hardware
uname -a                       # kernel y arquitectura
cat /etc/os-release            # distribución
ip -brief addr                 # interfaces de red e IP
hostname                       # nombre del equipo
```

## Windows (PowerShell)

### CPU
```powershell
Get-CimInstance Win32_Processor
Get-CimInstance Win32_Processor | Format-List Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed, L2CacheSize, L3CacheSize
```
`MaxClockSpeed` está en MHz; `L2CacheSize` y `L3CacheSize` en KB.

### Memoria
```powershell
Get-CimInstance Win32_PhysicalMemory | Format-Table Manufacturer, Capacity, Speed
(Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize / 1MB   # GB totales
```

### Almacenamiento
```powershell
Get-PhysicalDisk | Format-Table FriendlyName, MediaType, Size
Get-Volume
```

### Buses y E/S
```powershell
Get-PnpDevice -PresentOnly | Sort-Object Class | Format-Table Class, FriendlyName
```

### Resumen y red
```powershell
systeminfo
msinfo32                       # interfaz gráfica
Get-NetIPAddress -AddressFamily IPv4 | Format-Table InterfaceAlias, IPAddress
$env:COMPUTERNAME
```

## Utilidades para los scripts

| Tarea | Bash | PowerShell |
|-------|------|------------|
| Guardar salida en archivo | `comando > archivo.txt` | `comando \| Out-File archivo.txt` |
| Agregar al final | `comando >> archivo.txt` | `comando \| Out-File archivo.txt -Append` |
| Filtrar líneas | `grep -E 'patron'` | `Select-String 'patron'` |
| Fecha actual | `date` | `Get-Date` |
| Cabecera de salida | `head -n 2` | `Select-Object -First 2` |
