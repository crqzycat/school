@echo off
setlocal
chcp 65001 >nul
title GNS3 KI-Assistent

rem Diese Datei darf an beliebiger Stelle liegen.
set "GNS3_AGENT_DIR=C:\Users\crqzycat\gns3-ki"
set "GNS3_LAUNCHER_FILE=%~f0"
if not defined OLLAMA_MODEL set "OLLAMA_MODEL=qwen3:8b"
if not defined OLLAMA_URL set "OLLAMA_URL=http://127.0.0.1:11434"

if not exist "%GNS3_AGENT_DIR%\gns3_assistent.py" (
    echo [FEHLER] Python-Datei nicht gefunden:
    echo "%GNS3_AGENT_DIR%\gns3_assistent.py"
    pause
    exit /b 1
)
if not exist "%GNS3_AGENT_DIR%\.venv\Scripts\python.exe" (
    echo [FEHLER] Die Python-Umgebung .venv fehlt in:
    echo "%GNS3_AGENT_DIR%"
    pause
    exit /b 1
)

pushd "%GNS3_AGENT_DIR%"
if errorlevel 1 (
    echo [FEHLER] Projektordner kann nicht geoeffnet werden.
    pause
    exit /b 1
)

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$source = [IO.File]::ReadAllText($env:GNS3_LAUNCHER_FILE); $parts = $source -split '(?m)^# POWERSHELL\r?$', 2; if ($parts.Count -ne 2) { throw 'Startdatei ist unvollstaendig.' }; & ([scriptblock]::Create($parts[1]))"
if errorlevel 1 (
    echo.
    echo Start abgebrochen. Fehlermeldung steht oben.
    popd
    pause
    exit /b 1
)

echo.
echo Starte den GNS3-Assistenten ...
echo.
"%GNS3_AGENT_DIR%\.venv\Scripts\python.exe" "%GNS3_AGENT_DIR%\gns3_assistent.py"
set "GNS3_EXIT=%ERRORLEVEL%"
popd
echo.
if not "%GNS3_EXIT%"=="0" echo Der Assistent wurde mit Fehlercode %GNS3_EXIT% beendet.
pause
exit /b %GNS3_EXIT%

# POWERSHELL
$ErrorActionPreference = 'Stop'
try {
    $base = $env:OLLAMA_URL.TrimEnd('/')
    $model = $env:OLLAMA_MODEL

    function Test-Ollama {
        try {
            $null = Invoke-RestMethod -Uri "$base/api/version" -TimeoutSec 3
            return $true
        } catch {
            return $false
        }
    }

    Write-Host 'Pruefe Ollama ...'
    if (-not (Test-Ollama)) {
        $serverUri = [Uri]$base
        if ($serverUri.Host -notin @('localhost', '127.0.0.1', '::1')) {
            throw "Ollama unter $base ist nicht erreichbar. Automatischer Start ist nur lokal moeglich."
        }
        $command = Get-Command ollama.exe -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
        $executable = $null
        if ($command) { $executable = $command.Source }
        if (-not $executable) {
            $candidates = @(
                (Join-Path $env:LOCALAPPDATA 'Programs\Ollama\ollama.exe'),
                (Join-Path $env:ProgramFiles 'Ollama\ollama.exe')
            )
            $executable = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
        }
        if (-not $executable) {
            throw 'ollama.exe nicht gefunden. Ollama installieren oder dessen Ordner zum PATH hinzufuegen.'
        }
        # Kindprozess laeuft nach dem Schliessen dieses Fensters weiter.
        $env:OLLAMA_HOST = $serverUri.Authority
        Write-Host 'Starte Ollama im Hintergrund ...'
        Start-Process -FilePath $executable -ArgumentList 'serve' -WindowStyle Hidden | Out-Null
        $deadline = [DateTime]::UtcNow.AddSeconds(60)
        while (-not (Test-Ollama)) {
            if ([DateTime]::UtcNow -ge $deadline) {
                throw 'Ollama ist nach 60 Sekunden nicht erreichbar.'
            }
            Start-Sleep -Milliseconds 500
        }
    } else {
        Write-Host 'Ollama laeuft bereits.'
    }

    $installed = Invoke-RestMethod -Uri "$base/api/tags" -TimeoutSec 10
    $entry = @($installed.models | Where-Object { $_.name -eq $model -or $_.model -eq $model -or $_.name -eq "${model}:latest" })
    if ($entry.Count -eq 0) {
        throw "Modell '$model' ist nicht installiert. Einmal in PowerShell ausfuehren: ollama pull $model"
    }
    $canonical = $entry[0].name
    $running = Invoke-RestMethod -Uri "$base/api/ps" -TimeoutSec 10
    $loaded = @($running.models | Where-Object { $_.name -eq $canonical -or $_.model -eq $canonical })
    if ($loaded.Count -eq 0) {
        Write-Host "Lade Modell $canonical im Hintergrund (kann beim ersten Mal dauern) ..."
        $body = @{
            model = $canonical
            prompt = ''
            stream = $false
            think = $false
            keep_alive = '30m'
            options = @{ num_ctx = 16384 }
        } | ConvertTo-Json -Depth 4
        $null = Invoke-RestMethod -Uri "$base/api/generate" -Method Post -ContentType 'application/json' -Body $body -TimeoutSec 180
        $running = Invoke-RestMethod -Uri "$base/api/ps" -TimeoutSec 10
        $loaded = @($running.models | Where-Object { $_.name -eq $canonical -or $_.model -eq $canonical })
        if ($loaded.Count -eq 0) {
            throw 'Ollama hat das Modell nach dem Laden nicht als laufend gemeldet.'
        }
    } else {
        Write-Host "Modell $canonical ist bereits geladen."
    }
    Write-Host 'Ollama und Modell sind bereit.'
    exit 0
} catch {
    Write-Host ''
    Write-Host ('[FEHLER] ' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
