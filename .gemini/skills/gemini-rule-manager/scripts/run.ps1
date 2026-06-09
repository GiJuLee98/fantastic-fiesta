param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("prepare_draft", "update_draft", "compare_rules", "commit_changes", "discard_draft")]
    [string]$action,

    [Parameter(Mandatory=$false)]
    [string]$content,

    [Parameter(Mandatory=$false)]
    [string]$version,

    [Parameter(Mandatory=$false)]
    [string]$change_summary
)

# Set UTF-8 Output Encoding
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Project root path (four levels up from scripts directory under .gemini/skills/gemini-rule-manager)
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "../../../.."))
$geminiPath = Join-Path $projectRoot "GEMINI.md"
$tmpPath = Join-Path $projectRoot "GEMINI.tmp.md"

switch ($action) {
    "prepare_draft" {
        try {
            if (-not (Test-Path $geminiPath)) {
                throw "Original GEMINI.md file not found at $geminiPath"
            }
            
            if (Test-Path $tmpPath) {
                $existingContent = Get-Content -Path $tmpPath -Encoding utf8 -Raw
                $response = @{
                    status = "Success"
                    log = "Draft GEMINI.tmp.md already exists. You can proceed with editing it."
                    content = $existingContent
                }
                Write-Output (ConvertTo-Json $response -Depth 10 -Compress)
                break
            }

            # Copy GEMINI.md to GEMINI.tmp.md
            Copy-Item -Path $geminiPath -Destination $tmpPath -Force | Out-Null
            $copiedContent = Get-Content -Path $tmpPath -Encoding utf8 -Raw
            
            $response = @{
                status = "Success"
                log = "Successfully created draft copy GEMINI.tmp.md."
                content = $copiedContent
            }
            Write-Output (ConvertTo-Json $response -Depth 10 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error preparing draft: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "update_draft" {
        try {
            if ([string]::IsNullOrWhiteSpace($content)) {
                throw "Missing 'content' parameter for update_draft action."
            }

            # Write content to GEMINI.tmp.md
            [System.IO.File]::WriteAllText($tmpPath, $content, [System.Text.Encoding]::UTF8)
            
            $response = @{
                status = "Success"
                log = "Successfully updated GEMINI.tmp.md content."
            }
            Write-Output (ConvertTo-Json $response -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error updating draft: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "compare_rules" {
        try {
            if (-not (Test-Path $geminiPath)) {
                throw "Original GEMINI.md does not exist."
            }
            if (-not (Test-Path $tmpPath)) {
                throw "Draft GEMINI.tmp.md does not exist. Please prepare_draft first."
            }

            # Load file contents
            $originalLines = Get-Content -Path $geminiPath -Encoding utf8
            $draftLines = Get-Content -Path $tmpPath -Encoding utf8

            # Simple line-by-line comparison
            # Using git diff if git is available, otherwise falling back to simple comparison
            $diffOutput = ""
            if (Get-Command git -ErrorAction SilentlyContinue) {
                # We can write temporary files inside workspace to run git diff safely
                # But since we already have GEMINI.md and GEMINI.tmp.md in git status
                # we can compare them directly.
                $diffOutput = git diff --no-index --color=never -- $geminiPath $tmpPath
                # git diff returns exit code 1 if differences are found, which is normal.
                $lastExit = $LASTEXITCODE
            }
            
            if ([string]::IsNullOrWhiteSpace($diffOutput)) {
                # Simple fallback text comparison if git diff didn't produce output
                $diffLines = @()
                $maxLines = [Math]::Max($originalLines.Length, $draftLines.Length)
                for ($i = 0; $i -lt $maxLines; $i++) {
                    $orig = if ($i -lt $originalLines.Length) { $originalLines[$i] } else { $null }
                    $drft = if ($i -lt $draftLines.Length) { $draftLines[$i] } else { $null }
                    if ($orig -ne $drft) {
                        $lineNum = $i + 1
                        if ($null -ne $orig -and $null -ne $drft) {
                            $diffLines += "Line ${lineNum}:`n- $orig`n+ $drft"
                        } elseif ($null -eq $orig) {
                            $diffLines += "Line ${lineNum} (Added):`n+ $drft"
                        } else {
                            $diffLines += "Line ${lineNum} (Removed):`n- $orig"
                        }
                    }
                }
                $diffOutput = $diffLines -join "`n`n"
                if ([string]::IsNullOrWhiteSpace($diffOutput)) {
                    $diffOutput = "No differences found."
                }
            }

            $response = @{
                status = "Success"
                log = "Comparison completed."
                diff = $diffOutput
            }
            Write-Output (ConvertTo-Json $response -Depth 10 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error comparing rules: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "commit_changes" {
        try {
            if (-not (Test-Path $tmpPath)) {
                throw "Draft GEMINI.tmp.md not found. Prepare and modify a draft first."
            }
            if ([string]::IsNullOrWhiteSpace($version) -or [string]::IsNullOrWhiteSpace($change_summary)) {
                throw "Missing required parameters for commit_changes: version, change_summary."
            }

            # Read final draft content
            $finalContent = Get-Content -Path $tmpPath -Encoding utf8 -Raw

            # Automatically update the version line in the text if present
            # Format usually: "- 버전 : X.Y.Z" or "버전 : X.Y.Z"
            if ($finalContent -match "-\s*버전\s*:\s*\d+\.\d+\.\d+") {
                $finalContent = $finalContent -replace "(-\s*버전\s*:\s*)\d+\.\d+\.\d+", "${1}$version"
            }

            # Backup the original GEMINI.md first
            if (Test-Path $geminiPath) {
                $backupPath = "$geminiPath.bak"
                Copy-Item -Path $geminiPath -Destination $backupPath -Force | Out-Null
            }

            # Write finalized content to GEMINI.md
            [System.IO.File]::WriteAllText($geminiPath, $finalContent, [System.Text.Encoding]::UTF8)

            # Delete the draft GEMINI.tmp.md
            Remove-Item -Path $tmpPath -Force | Out-Null

            $response = @{
                status = "Success"
                log = "Successfully committed changes to GEMINI.md. Version updated to $version."
            }
            Write-Output (ConvertTo-Json $response -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error committing changes: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "discard_draft" {
        try {
            if (Test-Path $tmpPath) {
                Remove-Item -Path $tmpPath -Force | Out-Null
                $response = @{
                    status = "Success"
                    log = "Draft GEMINI.tmp.md discarded successfully."
                }
            } else {
                $response = @{
                    status = "Success"
                    log = "No draft GEMINI.tmp.md was found to discard."
                }
            }
            Write-Output (ConvertTo-Json $response -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error discarding draft: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }
}