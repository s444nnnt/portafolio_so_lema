# Semana 02 · Teoría

## Datos en binario
- **Complemento a 2:** el bit más alto indica el signo. Para negar: invertir bits y sumar 1. Rango con n bits: −2ⁿ⁻¹ … 2ⁿ⁻¹−1. Sin signo: 0 … 2ⁿ−1. Los bits no traen tipo: 0x9C es 156 sin signo o −100 con signo.
- **La ALU suma igual** con y sin signo; el programa decide qué bandera mirar.
- **Banderas:** CF (acarreo, error si son números sin signo), OF (desbordamiento: dos operandos del mismo signo dan resultado de signo contrario), ZF (resultado cero), SF (copia el bit más alto).
- **Ejemplo 8 bits:** 120 + 10 = 1000 0010 → 130 sin signo (CF=0); con signo es −126 (OF=1). En C, el desbordamiento de `int` con signo es comportamiento indefinido.
- **Endianness:** orden de bytes en memoria. 0x12345678 en little-endian: 78 56 34 12 (x86-64, ARM); en big-endian: 12 34 56 78 (orden de red, TCP/IP).
- **UTF-8:** 1 a 4 bytes por carácter; ASCII ocupa 1 byte, «ñ» 2 bytes.
- **IEEE 754 (simple):** 1 bit de signo, 8 de exponente (sesgo 127), 23 de mantisa. 0,1 no es exacto en binario, por eso 0,1 + 0,2 ≠ 0,3; los reales se comparan con tolerancia.

## Jerarquía de memoria y caché
- **Localidad:** temporal (se reusa lo reciente) y espacial (se usan vecinos). Una caché trae **líneas** completas.
- **Dirección = etiqueta | índice | desplazamiento.** Desplazamiento = log₂ L; índice = log₂ S; etiqueta = el resto.
- **S = C / (L·A).** Ejemplo: 32 KiB, L = 64 B, A = 8 → S = 64.
- **Correspondencia:** directa (A=1, simple, con conflictos), asociativa por conjuntos (A=2,4,8…) y totalmente asociativa (un solo conjunto, costosa).
- **Reemplazo:** LRU (la usada hace más tiempo), FIFO (la primera que entró), aleatorio.
- **T_medio = Tc + (1−h)·Tm.** Los fallos dominan: pasar de h=95 % a 99 % triplica la velocidad media (6 ns → 2 ns).
- **Matriz en C:** se guarda por filas, así que recorrerla por filas aprovecha cada línea y por columnas salta N·4 B en cada acceso (mucho más lento; en la demo, 0,05 s frente a 0,24 s).
