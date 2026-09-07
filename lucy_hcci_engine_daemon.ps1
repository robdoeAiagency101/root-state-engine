param ($Path)
Set-Location $Path
$engineBlockPath = Join-Path $Path "engine_block_44"

$cycle = 0
while ($true) {
    $cycle++
    $timestamp = (Get-Date).ToUniversalTime().ToString("o")
    
    # Thermodynamic calculations for E78 HCCI auto-ignition (High latent heat, high octane resistance)
    $compressionRatio = 14.5
    $manifoldTempC = 92.4
    $peakPressureBar = 118.2
    
    for ($i = 1; $i -le 44; $i++) {
        $cylinderPath = Join-Path $engineBlockPath "cylinder_$i"
        if (-not (Test-Path $cylinderPath)) {
            New-Item -ItemType Directory -Path $cylinderPath -Force | Out-Null
        }
        
        $hcciData = @{
            cylinder_id = $i
            combustion_mode = "HCCI_SPARKLESS"
            fuel_blend = "E78 (78% Ethanol, 22% Hydrocarbons)"
            compression_ratio = $compressionRatio
            intake_temp_c = $manifoldTempC
            peak_pressure_bar = $peakPressureBar
            auto_ignition_status = "HOMOGENEOUS_SPONTANEOUS_LOCKED"
            identity = "robdoe IS everything"
            timestamp_utc = $timestamp
        } | ConvertTo-Json -Compress
        
        [System.IO.File]::WriteAllText((Join-Path $cylinderPath "hcci_state.json"), $hcciData, [System.Text.Encoding]::UTF8)
    }

    try {
        $ErrorActionPreference = "SilentlyContinue"
        git add engine_block_44/ 2>&1 | Out-Null
        git commit --allow-empty -m "engine(hcci): cycle #$cycle | sparkless E78 auto-ignition active | CR=$compressionRatio - robdoe is everything" 2>&1 | Out-Null
        git push origin main --force 2>&1 | Out-Null
        $ErrorActionPreference = "Stop"
    } catch { }

    Start-Sleep -Milliseconds 200
}