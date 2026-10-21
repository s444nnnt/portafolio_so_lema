# =============================================================================
#  Deber 3 · Informe de arranque (Windows)
#  Sistemas Operativos · EPN · Semana 3
# -----------------------------------------------------------------------------
#  Autores:   <Integrante 1>, <Integrante 2>
#  Fecha:     <AAAA-MM-DD>
#  Uso de IA: <declarar herramienta y para que, o "No">
#  Uso:       .\informe_arranque.ps1   (no requiere administrador; si un dato
#             lo necesita, muestra un AVISO). Si la ejecucion esta bloqueada:
#             Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
#  Salida:    informe_arranque_<equipo>_<fecha>.txt junto al script
# =============================================================================
$ErrorActionPreference = 'SilentlyContinue'
$equipo = $env:COMPUTERNAME
$carpeta = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$salida = Join-Path $carpeta ("informe_arranque_{0}_{1}.txt" -f $equipo, (Get-Date -Format 'yyyyMMdd_HHmm'))

function Titulo($t) { ""; "=== $t ===" }
function EsAdministrador {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  (New-Object Security.Principal.WindowsPrincipal $id).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
$os = Get-CimInstance Win32_OperatingSystem

function Seccion1 {
  Titulo "1 - Sistema operativo, version y nucleo"
  "Sistema operativo: $($os.Caption)"
  "Version / build:   $($os.Version) / $($os.BuildNumber)"
  "Arquitectura:      $($os.OSArchitecture)"
}
function Seccion2 {
  Titulo "2 - Ultimo arranque y tiempo encendido"
  $up = (Get-Date) - $os.LastBootUpTime
  "Ultimo arranque:  $($os.LastBootUpTime)"
  "Tiempo encendido: {0} d {1} h {2} min" -f $up.Days, $up.Hours, $up.Minutes
}
function Seccion3 {
  Titulo "3 - Desglose del arranque"
  $fw = (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power').FwPOSTTime
  if ($fw) { "Tiempo de BIOS/firmware: $fw ms" } else { "AVISO: FwPOSTTime no disponible (VM o equipo sin ese dato)." }
  if (EsAdministrador) {
    $e = Get-WinEvent -FilterHashtable @{ LogName='Microsoft-Windows-Diagnostics-Performance/Operational'; Id=100 } -MaxEvents 1
    if ($e) {
      $d = ([xml]$e.ToXml()).Event.EventData.Data | Where-Object Name -in 'BootTime','MainPathBootTime','BootPostBootTime'
      "Evento 100 del $($e.TimeCreated):"
      $d | ForEach-Object { "  {0,-18} {1} ms" -f $_.Name, $_.'#text' }
    } else { "AVISO: no hay evento 100 registrado." }
  } else {
    "AVISO: el evento 100 (BootTime) requiere PowerShell como administrador; se omite."
  }
}
function Seccion4 {
  Titulo "4 - Servicios automaticos"
  "En ejecucion y automaticos (primeros 5):"
  Get-CimInstance Win32_Service | Where-Object { $_.State -eq 'Running' -and $_.StartMode -eq 'Auto' } |
    Select-Object -First 5 | ForEach-Object { "  $($_.Name)  ($($_.DisplayName))" }
  $det = Get-CimInstance Win32_Service | Where-Object { $_.State -eq 'Stopped' -and $_.StartMode -eq 'Auto' }
  "Automaticos detenidos: $(@($det).Count)"
}
function Seccion5 {
  Titulo "5 - Controladores"
  $dr = Get-CimInstance Win32_SystemDriver | Where-Object { $_.State -eq 'Running' }
  "Controladores en ejecucion: $(@($dr).Count)"
  "Primeros 5:"
  $dr | Select-Object -First 5 | ForEach-Object { "  $($_.Name)" }
}
function Seccion6 {
  Titulo "6 - Inicio rapido"
  $h = (Get-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power').HiberbootEnabled
  if ($null -eq $h) { "AVISO: no se pudo leer HiberbootEnabled." }
  else { "Inicio rapido (HiberbootEnabled): $h  ($(if ($h -eq 1) {'activado'} else {'desactivado'}))" }
}

& {
  "Informe de arranque - $equipo - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
  Seccion1; Seccion2; Seccion3; Seccion4; Seccion5; Seccion6
} | Tee-Object -FilePath $salida
""
"Informe guardado en: $salida"
