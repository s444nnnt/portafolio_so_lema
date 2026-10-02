# Semana 01 · Arquitectura de computadoras

Temas 1.1 – 1.3: bloques fundamentales, funcionamiento (ciclo de instrucción, interrupciones, E/S) y métricas de rendimiento.

## Contenido

| Archivo | Descripción |
|---------|-------------|
| [comandos.md](comandos.md) | Comandos de Linux y Windows para ver CPU, memoria, discos y buses |
| [teoria.md](teoria.md) | Resumen teórico y fórmulas |
| [inventario.sh](inventario.sh) | Reporte de hardware en Linux |
| [inventario.ps1](inventario.ps1) | Reporte de hardware en Windows |
| [calc_rendimiento.py](calc_rendimiento.py) | Calculadora de CPI, tiempo de CPU, MIPS, Amdahl y AMAT |

## Cómo ejecutar

**Linux**
```bash
chmod +x inventario.sh
./inventario.sh
cat inventario_$(hostname).txt
```

**Windows (PowerShell)**
```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\inventario.ps1
Get-Content "inventario_$env:COMPUTERNAME.txt"
```

**Calculadora (Python 3)**
```bash
python3 calc_rendimiento.py
```

## Salida esperada

El reporte incluye: equipo, fecha y SO; CPU (modelo, núcleos, hilos, frecuencia); cachés; RAM total; discos; y como extra las interfaces de red con su IP.
