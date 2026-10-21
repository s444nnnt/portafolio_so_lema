# Formulario de ejercicios · Sistemas Operativos (Semanas 1–3)

| Fórmula | Cuándo usarla |
|---|---|
| **Tc = 1 / f** | Te dan GHz y piden el período (3 GHz → 0,33 ns). |
| **CPI = Σ CPIᵢ · frecuenciaᵢ** | Hay una mezcla de instrucciones (50 % tipo 1, 30 % tipo 2…). Frecuencias como fracción: suman 1. |
| **T_CPU = IC · CPI · Tc = IC · CPI / f** | Tiempo de ejecución de un programa. IC = nº de instrucciones. |
| **Speedup = T_A / T_B** | Comparar dos máquinas o diseños (el tiempo mayor va arriba). |
| **MIPS = f / (CPI · 10⁶)** | Piden millones de instrucciones por segundo. |
| **Speedup = 1 / [ (1−f) + f/S ]** (Amdahl) | Mejoras solo una fracción f del programa (S = factor de mejora o nº de núcleos). |
| **Speedup máx = 1 / (1−f)** | Piden el límite con infinitos núcleos o mejora infinita. |
| **N = f / (1/X − (1−f))** | Piden cuántos núcleos para un speedup X (se despeja N de Amdahl). |
| **AMAT = t_acierto + (1−h) · penalización** | Una caché con tasa de aciertos h. Penalización = tiempo de RAM (T_m). |
| **T = T₁ + (1−h₁)·[T₂ + (1−h₂)·T_m]** | Dos niveles de caché (L1 y L2). |
| **Veces más rápido = T_sin caché / AMAT** | Piden cuánto mejora la caché frente a no tenerla. |
| **líneas = C / L** · **S = C / (L · A)** | Número de conjuntos. A=1 directa; A = líneas, totalmente asociativa. |
| **desplaz. = log₂ L** · **índice = log₂ S** · **etiqueta = 32 − índice − desplaz.** | Dividir una dirección en campos. Dirección de n bits: usa n en lugar de 32. |
| **conjunto = (dirección / L) mod S** | Saber en qué conjunto cae una dirección. |
| **Rango con signo: −2ⁿ⁻¹ … 2ⁿ⁻¹−1** · **sin signo: 0 … 2ⁿ−1** | ¿Cabe un número en n bits? |
| **−x = invertir bits + 1** | Escribir un negativo en complemento a 2. Para leer uno con bit alto 1: restar 2ⁿ (0x9C = 156 − 256 = −100). |
| **CF · OF · ZF · SF** | CF: acarreo (error sin signo). OF: dos operandos del mismo signo dan resultado de signo contrario (error con signo). ZF: resultado 0. SF: bit más alto. |
| **Little-endian: byte menos significativo en la dirección menor** | Guardar 0x12345678: little 78 56 34 12 · big 12 34 56 78. |
| **n_max = ⌊(RAM − SO) / tamaño del proceso⌋** | ¿Cuántos procesos caben en la RAM? |
| **U = 1 − pⁿ** | Uso de CPU con n procesos que esperan E/S una fracción p del tiempo. |
| **n ≥ ln(1−U) / ln p** | ¿Cuántos procesos para alcanzar un uso U? (redondear hacia arriba). |
| **p = 1 − (user + sys) / real** | Calcular p a partir de `time`. |

**Conversiones:** 1 KiB = 2¹⁰ B · 1 MiB = 2²⁰ B · 1 GiB = 2³⁰ B · 1 ns = 10⁻⁹ s · 1 GHz = 10⁹ Hz · hex: 1 dígito = 4 bits.

**Ejemplos:** CPI 0,5·1+0,3·2+0,2·3 = 1,7 · Amdahl f=0,8, S=4 → 2,5× · AMAT h=95 %, 1+0,05·100 = 6 ns · 120+10 en 8 bits = 130 sin signo (CF=0), −126 con signo (OF=1) · 32 KiB, L=64, A=8 → S=64, índice 6, desplaz. 6, etiqueta 20 · 16 GiB, SO 4, proceso 1,5, p=0,9 → n=8, U=57 %; U≥90 % → n=22.
