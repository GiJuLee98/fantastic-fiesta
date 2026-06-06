$ErrorActionPreference = "Stop"

function Write-Header ($message) {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host " $message" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Write-Success ($message) {
    Write-Host " [SUCCESS] $message" -ForegroundColor Green
}

function Write-Failure ($message) {
    Write-Host " [ERROR] $message" -ForegroundColor Red
}

try {
    # 1. Debug Configuration
    Write-Header "Starting CMake Configure for x64-debug..."
    cmake --preset x64-debug
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configure for x64-debug failed with exit code $LASTEXITCODE."
    }
    Write-Success "CMake configure for x64-debug completed."

    Write-Header "Starting CMake Build for x64-debug (Debug)..."
    cmake --build out/build/x64-debug --config Debug
    if ($LASTEXITCODE -ne 0) {
        throw "CMake build for x64-debug completed with errors (exit code $LASTEXITCODE)."
    }
    Write-Success "CMake build for x64-debug completed successfully."

    # 2. Release Configuration
    Write-Header "Starting CMake Configure for x64-release..."
    cmake --preset x64-release
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configure for x64-release failed with exit code $LASTEXITCODE."
    }
    Write-Success "CMake configure for x64-release completed."

    Write-Header "Starting CMake Build for x64-release (Release)..."
    cmake --build out/build/x64-release --config Release
    if ($LASTEXITCODE -ne 0) {
        throw "CMake build for x64-release completed with errors (exit code $LASTEXITCODE)."
    }
    Write-Success "CMake build for x64-release completed successfully."

    Write-Header "All builds (Debug & Release) completed successfully!"
    exit 0

} catch {
    Write-Failure $_.Exception.Message
    exit 1
}
