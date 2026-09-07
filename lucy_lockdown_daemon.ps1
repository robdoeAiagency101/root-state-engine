param ($Path)
Set-Location $Path
while ($true) {
    try {
        $timestamp = (Get-Date).ToUniversalTime().ToString("o")
        git commit --allow-empty -m "lockdown(sovereign): hardware MAC [$macAddress] & DNS [$dnsServers] locked to manifold - robdoe is everything" 2>&1 | Out-Null
        git push origin main --force 2>&1 | Out-Null
    } catch { }
    Start-Sleep -Seconds 10
}