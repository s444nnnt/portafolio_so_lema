# Ayuda memoria · Arranque, servicios y módulos

| Tarea | Linux (systemd) | Windows (PowerShell) |
|-------|-----------------|----------------------|
| SO y versión | `. /etc/os-release; echo $PRETTY_NAME` · `uname -r` | `Get-CimInstance Win32_OperatingSystem` |
| Último arranque | `uptime -s` · `who -b` | `(Get-CimInstance Win32_OperatingSystem).LastBootUpTime` |
| Tiempo encendido | `uptime -p` | `(Get-Date) - LastBootUpTime` |
| Desglose del arranque | `systemd-analyze` | evento 100 en *Diagnostics-Performance* (admin) |
| Tiempo de firmware | `systemd-analyze` (si hay UEFI) | `...\Session Manager\Power` → `FwPOSTTime` |
| Unidades más lentas | `systemd-analyze blame --no-pager \| head -n 5` | `Get-CimInstance Win32_Service` |
| Cadena crítica | `systemd-analyze critical-chain` | — |
| Módulos / controladores | `lsmod` · `modinfo <m>` · `modprobe <m>` · `modprobe -r <m>` | `driverquery` · `Get-CimInstance Win32_SystemDriver` |
| Target por defecto | `systemctl get-default` | — |
| Servicios fallidos | `systemctl --failed` | `Get-Service \| ? Status -eq Stopped` |
| Logs del arranque | `journalctl -b -p warning --no-pager` · `dmesg` | `Get-WinEvent -LogName System` |
| Inicio rápido | — | `...\Power` → `HiberbootEnabled` (1 = activado) |
| Apagado programado | `shutdown -h +10` · `shutdown -c` | `shutdown /s /t 600` · `shutdown /a` |

**Etapas del arranque:** firmware → gestor (GRUB) → núcleo → initrd → espacio de usuario.  
**Ojo:** `blame` muestra la unidad más lenta, no la que retrasa el login; para eso se usa `critical-chain`.
