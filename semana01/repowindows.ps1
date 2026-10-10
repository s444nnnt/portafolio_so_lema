# repowindows.ps1 - Sistemas Operativos - Semana 1
# Genera un inventario de hardware y lo guarda en inventario_<equipo>.txt
# (en la misma carpeta del script) y tambien lo muestra en pantalla.
#
# Uso (PowerShell):
#   Set-ExecutionPolicy -Scope Process Bypass
#   .\repowindows.ps1
#
# Nota: el texto esta escrito sin tildes a proposito, para que PowerShell 5.1
# no muestre caracteres raros.

$equipo = $env:COMPUTERNAME
$carpeta = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$salida = Join-Path $carpeta ("inventario_{0}.txt" -f $equipo)

$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$os  = Get-CimInstance Win32_OperatingSystem

$reporte = & {
    "===== INVENTARIO DE HARDWARE (Windows) ====="
    ""
    "== Equipo, fecha y sistema operativo"
    "Equipo : $equipo"
    "Fecha  : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    "SO     : $($os.Caption) (version $($os.Version))"

    ""
    "== CPU"
    "Modelo   : $($cpu.Name.Trim())"
    "Nucleos  : $($cpu.NumberOfCores)"
    "Hilos    : $($cpu.NumberOfLogicalProcessors) procesadores logicos"
    "Frecuencia maxima (MHz): $($cpu.MaxClockSpeed)"
    "Frecuencia actual (MHz): $($cpu.CurrentClockSpeed)"

    ""
    "== Cache"
    # Win32_CacheMemory: Level 3 = L1, 4 = L2, 5 = L3 (tamano en KB)
    $caches = Get-CimInstance Win32_CacheMemory -ErrorAction SilentlyContinue
    if ($caches) {
        foreach ($c in ($caches | Sort-Object Level, Purpose)) {
            $nivel = switch ($c.Level) { 3 { "L1" } 4 { "L2" } 5 { "L3" } default { "Nivel $($c.Level)" } }
            "{0} ({1}): {2} KB" -f $nivel, $c.Purpose, $c.InstalledSize
        }
    }
    else {
        "L1 : no disponible en este equipo (por ejemplo, maquina virtual)"
        "L2 : $($cpu.L2CacheSize) KB"
        "L3 : $($cpu.L3CacheSize) KB"
    }

    ""
    "== Memoria RAM"
    "Total : {0:N1} GB" -f ($os.TotalVisibleMemorySize / 1MB)

    ""
    "== Discos (nombre, tipo, tamano)"
    Get-PhysicalDisk |
        Select-Object FriendlyName, MediaType, @{ Name = 'Tamano_GB'; Expression = { [math]::Round($_.Size / 1GB, 1) } } |
        Format-Table -AutoSize | Out-String -Width 200

    ""
    "== EXTRA: interfaces de red y direccion IP"
    Get-NetIPAddress -AddressFamily IPv4 |
        Select-Object InterfaceAlias, IPAddress |
        Format-Table -AutoSize | Out-String -Width 200
}

$reporte | Out-File -FilePath $salida -Encoding utf8
$reporte

""
"Reporte generado: $salida"
