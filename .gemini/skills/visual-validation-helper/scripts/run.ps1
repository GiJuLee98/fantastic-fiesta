param (
    [Parameter(Mandatory=$true)]
    [string]$exe_path,

    [Parameter(Mandatory=$false)]
    [string]$arguments = "",

    [Parameter(Mandatory=$false)]
    [int]$wait_ms = 2000,

    [Parameter(Mandatory=$false)]
    [string]$screenshot_prefix = "validation_screenshot",

    [Parameter(Mandatory=$false)]
    [object]$kill_after = $true
)

# Set UTF-8 Output Encoding
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "../../../.."))
$screenshotScript = [System.IO.Path]::GetFullPath((Join-Path $projectRoot "scripts/take_screenshots.ps1"))
$screenshotDir = [System.IO.Path]::GetFullPath((Join-Path $projectRoot "temp/screenshots"))

$logLines = [System.Collections.Generic.List[string]]::new()
$screenshots = [System.Collections.Generic.List[string]]::new()
$status = "Failed"

try {
    # 1. Resolve executable path
    $resolvedExe = $exe_path
    if (-not [System.IO.Path]::IsPathRooted($resolvedExe)) {
        $resolvedExe = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $exe_path))
    }

    if (-not (Test-Path $resolvedExe)) {
        throw "Executable not found at path: $resolvedExe"
    }

    $logLines.Add("Starting process: $resolvedExe with arguments: $arguments")
    
    # 2. Launch process
    $processStartInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processStartInfo.FileName = $resolvedExe
    $processStartInfo.Arguments = $arguments
    $processStartInfo.UseShellExecute = $false
    $processStartInfo.WorkingDirectory = [System.IO.Path]::GetDirectoryName($resolvedExe)

    $process = [System.Diagnostics.Process]::Start($processStartInfo)
    if ($null -eq $process) {
        throw "Failed to start process: $resolvedExe"
    }

    $logLines.Add("Process started. PID: $($process.Id)")

    # 3. Wait
    $logLines.Add("Waiting for $wait_ms ms...")
    Start-Sleep -Milliseconds $wait_ms

    if ($process.HasExited) {
        $logLines.Add("Warning: Process has already exited with code $($process.ExitCode) before taking screenshot.")
    }

    # 4. Take screenshot
    $logLines.Add("Calling take_screenshots.ps1...")
    if (-not (Test-Path $screenshotScript)) {
        throw "Screenshot script not found at: $screenshotScript"
    }

    # Run screenshot script and capture output
    $screenshotOutput = & powershell.exe -ExecutionPolicy Bypass -File $screenshotScript -FileName $screenshot_prefix -DirectoryPath $screenshotDir 2>&1
    
    $successFound = $false
    foreach ($line in $screenshotOutput) {
        $lineStr = $line.ToString().Trim()
        $logLines.Add("Screenshot script output: $lineStr")
        if ($lineStr -match "^Result:\s*Success") {
            $successFound = $true
        } elseif ($successFound -and $lineStr -match "^(.*)\s+:\s+.*$") {
            $path = $Matches[1].Trim()
            if (Test-Path $path) {
                $screenshots.Add($path)
            }
        }
    }

    if (-not $successFound) {
        throw "Screenshot capture failed. Output: $screenshotOutput"
    }

    # 5. Kill process if requested
    $killAfterBool = $true
    if ($kill_after -is [string]) {
        if ($kill_after.ToLower() -eq "false" -or $kill_after -eq "0" -or $kill_after -eq "$false") {
            $killAfterBool = $false
        }
    } elseif ($kill_after -is [bool]) {
        $killAfterBool = $kill_after
    }

    if ($killAfterBool) {
        if (-not $process.HasExited) {
            $logLines.Add("Terminating process (PID: $($process.Id))...")
            $process.Kill()
            # Wait for exit
            $process.WaitForExit(3000) | Out-Null
            $logLines.Add("Process terminated.")
        } else {
            $logLines.Add("Process already exited, no termination needed.")
        }
    }

    $status = "Success"
} catch {
    $logLines.Add("Error encountered: $_")
    $status = "Failed"
}

# Construct JSON output
$response = [Ordered]@{
    status = $status
    log = ($logLines -join "`r`n")
    screenshots = $screenshots.ToArray()
}

Write-Output (ConvertTo-Json $response -Depth 5 -Compress)
