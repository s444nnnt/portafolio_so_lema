# Semana 03 · Teoría

## Qué es un sistema operativo
Programa con privilegios especiales (**modo núcleo**) que administra el hardware y ofrece a los programas una forma cómoda y segura de usarlo. Aporta protección de memoria y separa **modo usuario** de **modo núcleo**.

## Por qué surgió y qué tipos hay
Serie (la CPU espera la E/S) → lotes (monitor residente) → multiprogramación → tiempo compartido (respuesta rápida).
- **Multiprogramación:** U = 1 − pⁿ; p es la fracción de tiempo esperando E/S y n el número de procesos. Da rendimientos decrecientes, nunca llega al 100 % y la RAM es el límite. Se mide con p = 1 − (user+sys)/real.
- **Tipos:** escritorio/móvil (respuesta, batería), servidor (muchos clientes, estabilidad), embebido (una función, pocos recursos), tiempo real duro/blando (plazos garantizados / casi siempre).

## Estructura del núcleo
- **Monolítico:** todo en modo núcleo; rápido pero frágil (Linux, FreeBSD).
- **Microkernel:** lo mínimo en modo núcleo; robusto, más lento por los cruces de frontera (MINIX 3, QNX).
- **Híbrido:** Windows NT, macOS XNU.
- **Módulos (.ko):** código cargado en caliente (`modprobe`), corre en modo núcleo. Un error en un controlador causa kernel panic (Linux) o pantalla azul (Windows); en un microkernel solo se reinicia ese proceso.

## Arranque en 5 pasos
1. **Firmware** (BIOS/UEFI) · 2. **Gestor de arranque** (GRUB) · 3. **Núcleo + initramfs** · 4. **PID 1** (systemd) · 5. **Login y shell**.
- Pantalla `No bootable device` → firmware. `grub rescue>` → gestor. `Kernel panic ... unable to mount root fs` → núcleo. `dracut ... emergency mode` → initrd. `Failed to mount ...` / emergency tras `Reached target` → espacio de usuario.
- Medición: `systemd-analyze` (etapas), `blame` (quién tardó), `critical-chain` (quién hizo esperar a todos; una unidad lenta fuera de la cadena no retrasa el login). En Windows: `LastBootUpTime`, evento 100.
- **Inicio rápido (Windows):** «Apagar» hiberna el núcleo y `LastBootUpTime` no cambia; «Reiniciar» sí hace arranque completo.

## Parada
SIGTERM (avisar) → SIGKILL (forzar) → `sync` (mesada a bodega) → apagar (ACPI). Un corte de energía pierde lo no vaciado. Programar: `shutdown -r +5` / `-c`; en Windows `shutdown /r /t 300` / `/a`.
