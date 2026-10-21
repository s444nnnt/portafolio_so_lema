# Formulario · Sistemas Operativos (Semanas 1–3)

## Semana 1 · Rendimiento
- Período: **Tc = 1 / f** (3 GHz → 0,33 ns)
- **T_CPU = IC × CPI × Tc = IC × CPI / f**
- **CPI = Σ CPIᵢ × frecuenciaᵢ** (frecuencias como fracción, suman 1)
- **MIPS = f / (CPI × 10⁶)**
- Speedup entre máquinas: T_A / T_B (el más lento arriba)
- **Amdahl:** Speedup = 1 / [ (1 − f) + f / S ] · límite (S→∞): 1 / (1 − f)
  - Núcleos para un speedup objetivo X: despejar N: f/N = 1/X − (1 − f)
- **AMAT = t_acierto + (1 − h) × penalización** · veces más rápido = T_sin_caché / AMAT

## Semana 2 · Datos y caché
- Complemento a 2 (n bits): invertir bits y sumar 1 · rango **−2ⁿ⁻¹ … 2ⁿ⁻¹ − 1** · sin signo **0 … 2ⁿ − 1**
- 8 bits: 0x7F = 127 · 0x80 = −128 · 0x9C = 156 sin signo / −100 con signo · 0xFF = −1
- Banderas: **CF** acarreo (error sin signo) · **OF** mismo signo → resultado de signo contrario (error con signo) · **ZF** resultado 0 · **SF** bit más alto
- Endianness 0x12345678 en 0x1000: **little** 78 56 34 12 · **big** 12 34 56 78 (x86 y ARM: little; red: big)
- Caché: **S = C / (L · A)** conjuntos · A=1 directa · A=líneas totalmente asociativa · líneas = C / L
- Dirección de 32 bits: **desplazamiento = log₂ L** · **índice = log₂ S** · **etiqueta = 32 − índice − desplazamiento**
- **T_medio = Tc + (1 − h) · Tm** · 2 niveles: T = T1 + (1 − h1)·[ T2 + (1 − h2)·Tm ]
- Localidad: C guarda la matriz por filas; recorrer por filas usa toda la línea, por columnas salta N·4 B
- IEEE 754 simple: 1 bit signo, 8 exponente (sesgo 127), 23 mantisa · 0,1 + 0,2 ≠ 0,3

## Semana 3 · SO
- Multiprogramación: **U = 1 − pⁿ** (p = fracción de espera de E/S, n = procesos) · nunca llega a 100 %
- **n_max = ⌊(RAM − SO) / tamaño por proceso⌋** · **n ≥ ln(1 − U) / ln p**
- p medido: **p = 1 − (user + sys) / real**
- Arranque en 5 pasos: firmware → gestor (GRUB) → núcleo + initramfs → PID 1 → login/shell
- `systemd-analyze` (etapas) · `blame` (quién tardó) · `critical-chain` (quién hizo esperar a todos)
- Parada: SIGTERM → SIGKILL → sync → apagar (ACPI)
- Núcleos: monolítico (rápido, frágil; Linux) · microkernel (robusto, más lento; MINIX, QNX) · híbrido (Windows NT, macOS XNU) · módulos (.ko) corren en modo núcleo

## Ejemplos resueltos
- CPI = 0,5·1 + 0,3·2 + 0,2·3 = **1,7**; T = 4·10⁹ × 1,5 / 2 GHz = **3 s**
- Amdahl f = 0,8, S = 4 → 1 / (0,2 + 0,2) = **2,5×**
- AMAT h = 95 %: 1 + 0,05·100 = **6 ns**; h = 99 %: **2 ns**
- 8 bits: 120 + 10 = 1000 0010 → 130 sin signo (CF=0) · −126 con signo (**OF=1**, SF=1)
- C = 32 KiB, L = 64 B, A = 8 → S = 64; índice 6 bits, desplaz. 6, etiqueta 20
- 16 GiB, SO 4 GiB, proceso 1,5 GiB, p = 0,9 → n = ⌊12/1,5⌋ = 8; U = 1 − 0,9⁸ = **57 %**; para 90 %: n ≥ ln 0,1 / ln 0,9 = 21,9 → **22** (falta RAM, no CPU)
