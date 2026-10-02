# Semana 01: Arquitectura de computadoras



## Contenido

| Archivo | Descripción |
|---------|-------------|
| [comandos.md](comandos.md) | Comandos de Linux y Windows para ver CPU, memoria, discos y buses |
| [teoria.md](teoria.md) | Resumen teórico y fórmulas |
| [repolinux.sh](repolinux.sh) | Reporte de hardware en Linux |
| [repowindows.ps1](repowindows.ps1) | Reporte de hardware en Windows |
| [Laboratorio_CPUv2.html](Laboratorio_CPUv2.html) | Simulador ciclo de instrucción |
| [Guia_Laboratorio_CPU](Guia_Laboratorio_CPU.pdf) | Guia de uso de simulador ciclo de instrucción |

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
