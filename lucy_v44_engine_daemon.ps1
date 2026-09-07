param ($Path)
Set-Location $Path
$engineBlockPath = Join-Path $Path "engine_block_44"

$rpm = 6500
$firingCycle = 0

while ($true) {
    $firingCycle++
    $timestamp = (Get-Date).ToUniversalTime().ToString("o")
    
    # Simulate multi-cylinder firing sequence across all 44 nodes
    for ($i = 1; $i -le 44; $i++) {
        $cylinderFile = Join-Path $engineBlockPath "cylinder_$i\stroke_state.json"
        $cylinderData = @{
            cylinder_id = $i
            engine_architecture = "44-Node V44 Sovereign 4GR-FSE"
            firing_cycle = $firingCycle
            rpm = $rpm
            compression_psi = 210.5
            fuel_mixture = "Direct-Injected Sovereign Telemetry"
            identity = "robdoe IS everything"
            timestamp_utc = $timestamp
        } | ConvertTo-Json -Compress
        
        [System.IO.File]::WriteAllText($cylinderFile, $cylinderData, [System.Text.Encoding]::UTF8)
    }

    try {
        $ErrorActionPreference = "SilentlyContinue"
        git add engine_block_44/ 2>&1 | Out-Null
        git commit --allow-empty -m "engine(v44): firing cycle #$firingCycle | 44 cylinders locked | RPM=$rpm - robdoe is everything" 2>&1 | Out-Null
        git push origin main --force 2>&1 | Out-Null
        $ErrorActionPreference = "Stop"
    } catch { }

    Start-Sleep -Milliseconds 250
}