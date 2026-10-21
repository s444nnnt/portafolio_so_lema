# =============================================================================
#  memoria.ps1 · Deber 2 (Semana 2) · Reporte de memoria del equipo (Windows)
#  Sistemas Operativos · EPN · FIEE
#  Autores:   <Integrante 1>, <Integrante 2>
#  Uso de IA: <declarar herramienta y para que, o "No">
#  Uso:       .\memoria.ps1    (si la politica lo bloquea, una sola vez:
#             Set-ExecutionPolicy -Scope CurrentUser RemoteSigned)
#  Salida:    memoria_<equipo>.txt (junto al script)
#  Extra:     si existe .\matriz.exe (gcc -O0 matriz.c -o matriz.exe) anade sus tiempos.
# =============================================================================
$carpeta = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$salida  = Join-Path $carpeta "memoria_$env:COMPUTERNAME.txt"

& {
  "== Equipo: $env:COMPUTERNAME   Fecha: $(Get-Date -Format 'yyyy-MM-dd')"
  $os = Get-CimInstance Win32_OperatingSystem
  "== SO: $($os.Caption) $($os.Version)"
  "== Arquitectura: $env:PROCESSOR_ARCHITECTURE"
  "Orden de bytes: " + $(if ([BitConverter]::IsLittleEndian) { "Little Endian" } else { "Big Endian" })

  ""; "== Caches (KB) segun el SO"
  Get-CimInstance Win32_CacheMemory | Select-Object Purpose, InstalledSize, Associativity, LineSize | Format-Table -AutoSize | Out-String -Width 120
  "Nota: Windows no siempre informa vias ni linea; si faltan, el dato no esta disponible (AVISO)."

  ""; "== Conjuntos de la L1d: S = C / (L * A)"
  $l1 = Get-CimInstance Win32_CacheMemory | Where-Object { $_.Level -eq 3 -and $_.CacheType -eq 3 } | Select-Object -First 1
  if ($l1 -and $l1.LineSize -and $l1.Associativity) {
    "C = $($l1.InstalledSize) KB, L = $($l1.LineSize) B (ver nota), A = codigo $($l1.Associativity)"
  } else {
    "AVISO: Windows no expone linea/vias de la L1d con claridad. Use coreinfo o los datos del fabricante (lscpu en WSL)."
  }

  ""; "== RAM y paginacion"
  "RAM total : {0:N1} GB" -f ($os.TotalVisibleMemorySize / 1MB)
  "RAM libre : {0:N1} GB" -f ($os.FreePhysicalMemory / 1MB)
  Get-CimInstance Win32_PageFileUsage | ForEach-Object { "Archivo de paginacion: $($_.Name)  $($_.AllocatedBaseSize) MB" }

  ""; "== Discos (nombre, tipo, tamano)"
  Get-PhysicalDisk | ForEach-Object { "{0}  {1}  {2:N0} GB" -f $_.FriendlyName, $_.MediaType, ($_.Size / 1GB) }

  ""; "== Extra: tiempos de matriz"
  $m = Join-Path $carpeta "matriz.exe"
  if (Test-Path $m) { & $m; & $m c } else { "AVISO: compile antes con: gcc -O0 matriz.c -o matriz.exe (o use WSL)" }
} | Tee-Object -FilePath $salida
"Reporte guardado en: $salida"
