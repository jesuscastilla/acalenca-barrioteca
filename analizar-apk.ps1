$androidHome = Join-Path $env:LOCALAPPDATA "Android\Sdk"
$aapt = Join-Path $androidHome "build-tools\30.0.3\aapt.exe"

$apkFiles = Get-ChildItem "g:\GITHUB\barrioteca-android-app\*.apk"
$apk = $apkFiles[0].FullName

Write-Host "Analizando: $apk"
Write-Host "---"

$output = & $aapt dump badging $apk 2>&1
$output | ForEach-Object {
    if ($_ -match "package:|sdkVersion|targetSdk|application-label|versionCode|launchable|native-code|uses-feature") {
        Write-Host $_
    }
}

Write-Host "---"
if ($LASTEXITCODE -eq 0) {
    Write-Host "APK valida!"
} else {
    Write-Host "Error: $LASTEXITCODE"
}