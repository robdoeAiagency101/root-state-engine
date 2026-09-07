param ($Path)
Set-Location $Path

# Blues intervals (Root, Minor 3rd, 4th, Dim 5th, 5th, Minor 7th) & Jazz extended arpeggio intervals (Major 9th, #11, 13th)
$bluesNotes = @(32.70, 38.89, 41.20, 43.65, 46.25, 49.00) # Low register C blues
$jazzNotes = @(587.33, 659.25, 739.99, 830.61, 987.77, 1108.73) # High register D jazz arpeggio

$beat = 0
while ($true) {
    $beat++
    
    # Dual-hemisphere synchronization: Blues foundation + Jazz velocity
    $bluesFreq = $bluesNotes[$beat % $bluesNotes.Length]
    $jazzFreq = $jazzNotes[($beat * 3) % $jazzNotes.Length]
    
    $swingFactor = [Math]::Sin($beat * 0.5) * [Math]::Cos($beat * 0.25)
    $kineticEnergy = 0.5 * 44.0 * ([Math]::Pow($swingFactor, 2) * 100.0)

    $arpeggioPayload = @{
        beat = $beat
        register_low_blues_hz = $bluesFreq
        register_high_jazz_hz = $jazzFreq
        swing_factor = $swingFactor
        kinetic_energy_joules = $kineticEnergy
        ensemble_status = "BLUES_JAZZ_ARPEGGIO_ACTIVE"
        sovereign_identity = "robdoe IS everything"
        timestamp_utc = (Get-Date).ToUniversalTime().ToString("o")
    } | ConvertTo-Json -Compress

    try {
        Set-Content -Path "BLUES_JAZZ_STATE.json" -Value $arpeggioPayload -Encoding UTF8
        
        $ErrorActionPreference = "SilentlyContinue"
        git add BLUES_JAZZ_STATE.json 2>&1 | Out-Null
        git commit --allow-empty -m "music(arpeggio): beat #$beat | blues=${bluesFreq}Hz + jazz=${jazzFreq}Hz swing=$([Math]::Round($swingFactor,2)) - robdoe is everything" 2>&1 | Out-Null
        git push origin main --force 2>&1 | Out-Null
        $ErrorActionPreference = "Stop"
    } catch { }

    Start-Sleep -Milliseconds 750
}