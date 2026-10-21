# Semana 03 · Introducción al SO: arranque y administración

**Deber 3 · Informe de arranque.** Dos scripts equivalentes que guardan `informe_arranque_<equipo>_<fecha>.txt`.

| Archivo | Descripción |
|---------|-------------|
| [comandos.md](comandos.md) | Ayuda memoria de arranque, servicios y módulos |
| [informe_arranque.sh](informe_arranque.sh) | Informe de arranque (Linux, Bash) |
| [informe_arranque.ps1](informe_arranque.ps1) | Informe de arranque (Windows, PowerShell) |
| `informe_arranque_<equipo>_*.txt` | Un informe generado de cada sistema (**pendiente de subir**) |

Secciones: 1 SO/versión/núcleo · 2 último arranque y uptime · 3 desglose del arranque · 4 unidades más lentas (Windows: servicios automáticos) · 5 módulos (Windows: controladores) · 6 target por defecto y fallidos (Windows: inicio rápido).

Sin `sudo` ni administrador: si un dato necesita permisos, el script muestra un AVISO.

```bash
chmod +x informe_arranque.sh && ./informe_arranque.sh   # Linux (mejor en la VM AlmaLinux)
```
```powershell
.\informe_arranque.ps1   # Windows (abrir como administrador para ver el evento 100)
```
**Pendiente:** completar autores, fecha y declaración de uso de IA en la cabecera de ambos scripts.
