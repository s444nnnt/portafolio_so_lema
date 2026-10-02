# Teoría · Semana 01

## 1.1 Bloques fundamentales

- **Programa almacenado (Von Neumann):** instrucciones y datos comparten la misma memoria, en binario, y se acceden por dirección.
- **Harvard:** memorias y buses separados para instrucciones y datos. Las CPU actuales usan **Harvard modificada**: cachés L1i y L1d separadas, memoria principal única.
- **Bloques:** CPU (unidad de control, ALU, registros), memoria principal, módulos de E/S y buses (datos, direcciones, control).
- **Cuello de botella de Von Neumann:** un solo bus para instrucciones y datos limita la velocidad.

### Registros principales

| Registro | Función |
|----------|---------|
| PC | Dirección de la próxima instrucción |
| IR | Instrucción en ejecución |
| MAR | Dirección de memoria a leer o escribir |
| MBR | Dato leído o por escribir |
| AC | Acumulador (resultado de la ALU) |
| PSW | Flags y modo usuario/núcleo |
| SP | Puntero de pila |

### Buses
- Con **n** bits de direcciones se direccionan **2ⁿ** posiciones. Ejemplo: 32 bits → 4 GiB; 36 bits → 64 GiB; 20 bits → 1 MiB.
- Ancho de banda = bytes por transferencia × transferencias por segundo.

## 1.2 Funcionamiento

### Ciclo de instrucción
Búsqueda (fetch) + ejecución, guiado por el PC:

```text
MAR ← PC
MBR ← M[MAR]
IR  ← MBR
PC  ← PC + 1
```

La ejecución puede ser: procesador ↔ memoria (LOAD, STORE), procesador ↔ E/S (IN, OUT), procesamiento de datos (ADD, SUB) o control (JMP, CALL).

### Interrupciones
- Tipos: de programa, de temporizador, de E/S y fallo de hardware.
- Se comprueban **al terminar cada instrucción**, nunca a la mitad.
- Ciclo de interrupción: guarda contexto (PC, PSW) → PC ← dirección de la ISR → ejecuta ISR → restaura contexto.
- Múltiples: **secuencial** (se deshabilitan durante la ISR) o **anidada por prioridad**.

### Técnicas de E/S

| | Programada | Por interrupciones | DMA |
|---|---|---|---|
| Quién mueve los datos | CPU | CPU (palabra a palabra) | Controlador DMA |
| ¿CPU espera? | Sí (polling) | No | No, solo inicia y recibe aviso |
| Uso típico | Dispositivos simples | Teclado, ratón | Discos, SSD, red |

### Modo usuario y modo núcleo
Un bit del PSW indica el modo. Las instrucciones privilegiadas solo corren en modo núcleo. Se entra al núcleo por traps (llamadas al sistema), interrupciones o excepciones.

## 1.3 Métricas de rendimiento

- **Latencia:** tiempo de UNA operación. **Throughput:** operaciones o datos por unidad de tiempo. Mejorar una no implica mejorar la otra.
- **Periodo de reloj:** Tc = 1 / f.

### Fórmulas

```text
CPI promedio = Σ (CPIi × frecuenciai)
T_CPU        = IC × CPI × Tc = IC × CPI / f
MIPS         = f / (CPI × 10^6)
Speedup      = 1 / [ (1 - f) + f / S ]        (Ley de Amdahl)
Límite       = 1 / (1 - f)                    (S → ∞)
AMAT         = t_hit + (1 - h) × penalización
```

### Ejemplos resueltos

- **Buses:** 36 bits de direcciones → 2³⁶ B = 64 GiB; bus de datos de 64 bits = 8 B por transferencia; a 100 M transf/s → 800 MB/s.
- **CPI:** 50 % aritmético (1), 30 % carga/almac. (2), 20 % saltos (3) → CPI = 0,5 + 0,6 + 0,6 = 1,7.
- **Amdahl:** f = 0,8, 8 núcleos → 1 / (0,2 + 0,1) = 3,33×. Máximo con infinitos núcleos: 5×.
- **AMAT:** t_hit = 1 ns, penalización = 100 ns, h = 99 % → 2 ns.

### Lección
Los GHz por sí solos no miden el rendimiento: importan IC, CPI y f juntos.

## Referencias
- Stallings, W. (2006). *Organización y arquitectura de computadores* (7.ª ed.). Caps. 1–3 y 7.
- Stallings, W. (2018). *Operating Systems: Internals and Design Principles* (9th ed.). Cap. 1.
- Tanenbaum, A. S. y Bos, H. (2022). *Modern Operating Systems* (5th ed.). Sec. 1.3.
