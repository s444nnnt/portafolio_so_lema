# Guía de repaso · Ejercicios de cálculo (Semanas 1–3)

Un problema resuelto por tipo, con números propios de práctica. Fórmulas en [../formulario.md](../formulario.md).

## 1. Tiempo de CPU, MIPS y speedup
**Cuándo:** comparar dos procesadores con frecuencia y CPI distintos. **Fórmulas:** T = IC·CPI/f · MIPS = f/(CPI·10⁶) · Speedup = T_lento/T_rápido.

IC = 8×10⁹. X: 2,5 GHz, CPI 1,5. Y: 3,5 GHz, CPI 2,4.
- T_X = 8×10⁹·1,5 / 2,5×10⁹ = **4,80 s**; T_Y = 8×10⁹·2,4 / 3,5×10⁹ = **5,49 s**
- MIPS_X = 2500/1,5 = **1666,67**; MIPS_Y = 3500/2,4 = **1458,33**
- X es más rápido: 5,49/4,80 = **1,14×**. Más GHz no implica más rendimiento si el CPI sube.

## 2. Ley de Amdahl
**Cuándo:** se mejora solo una fracción f del programa. **Fórmula:** 1/[(1−f) + f/S] · máximo 1/(1−f).

f = 0,6 y S = 5 → 1/(0,4 + 0,12) = **1,92×**. Máximo posible: 1/0,4 = **2,5×**.

## 3. AMAT con dos niveles de caché
**Cuándo:** hay L1, L2 y RAM, con tasas de fallo locales. **Fórmula:** AMAT = t₁ + m₁·(t₂ + m₂·t_RAM).

L1: 2 ns, fallos 6 %. L2: 10 ns, fallos locales 30 %. RAM: 100 ns.
- Con L2: 2 + 0,06·(10 + 0,30·100) = **4,40 ns**
- Sin L2: 2 + 0,06·100 = **8,00 ns** → empeora 8/4,4 = **1,82×**

## 4. Campos de la dirección en una caché
**Cuándo:** piden conjuntos, bits y descomponer una dirección. **Fórmulas:** S = C/(L·A) · desplaz. = log₂L · índice = log₂S · etiqueta = 32 − índice − desplaz.

C = 32 KiB, L = 64 B, A = 4 vías → S = 32768/(64·4) = **128**; desplaz. **6**, índice **7**, etiqueta 32 − 13 = **19** bits.
Dirección 0x1234ABCD: desplazamiento = **13**, conjunto = **47**, etiqueta = **0x91A5**.
(Truco: dividir la dirección entre L, el resto es el desplazamiento; el cociente módulo S es el conjunto; el resto del cociente es la etiqueta.)

## 5. Endianness y complemento a 2
**Cuándo:** un volcado hexadecimal de una máquina little-endian. En el desplazamiento 8 están los bytes `38 FF`.
- Little-endian: el byte menos significativo va primero → entero = **0xFF38**
- Sin signo: **65336**. Con signo: 65336 − 65536 = **−200**
- Mismos bits, distinta interpretación: con signo el bit más alto pesa −2¹⁵.

## 6. Uso de CPU y procesos (U = 1 − pⁿ)
**Cuándo:** `time` da real/user/sys y hay varias copias del programa. **Fórmulas:** p = 1 − (user+sys)/real · U = 1 − pⁿ · n ≥ ln(1−U)/ln p · n_max = ⌊(RAM−SO)/tamaño⌋.

real 5,0 s, user 0,8 s, sys 0,2 s → p = 1 − 1/5 = **0,80** (limitado por E/S).
- 4 copias: U = 1 − 0,8⁴ = **59,0 %**
- Para U ≥ 95 %: n ≥ ln0,05/ln0,8 = 13,4 → **14 procesos** (U = 95,6 %)
- RAM 16 GiB, SO 2 GiB, proceso 1 GiB → caben ⌊14/1⌋ = **14**: sí se alcanza el 95 %.

## 7. Análisis de `systemd-analyze`
**Cuándo:** suman etapas y piden porcentaje o mejora. Total = suma de todas las etapas; % = parte/total.

firmware 3,0 + loader 1,0 + kernel 1,5 + initrd 2,5 + userspace 12,0 = **20,0 s**.
- Etapa que más pesa: userspace, 12/20 = **60 %**
- Un servicio de la cadena crítica baja de 8 s a 1 s → ahorro 7 s → nuevo total **13,0 s** → reducción **35 %**
