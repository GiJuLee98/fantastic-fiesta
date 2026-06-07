param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("list", "create", "update", "delete")]
    [string]$action,

    [Parameter(Mandatory=$false)]
    [string]$skill_id,

    # create parameters
    [Parameter(Mandatory=$false)]
    [string]$skill_name,
    [Parameter(Mandatory=$false)]
    [string]$description,
    [Parameter(Mandatory=$false)]
    [string]$tools_json,
    [Parameter(Mandatory=$false)]
    [string]$dialog_summary,

    # update parameters
    [Parameter(Mandatory=$false)]
    [string]$update_targets,
    [Parameter(Mandatory=$false)]
    [string]$file_contents
)

# Set UTF-8 Output Encoding
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$skillsPath = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot "../.."))

switch ($action) {
    "list" {
        try {
            if (-not (Test-Path $skillsPath)) {
                $response = @{
                    status = "Success"
                    skills = @()
                }
                Write-Output (ConvertTo-Json $response -Depth 10 -Compress)
                break
            }
            
            $subdirs = Get-ChildItem -Path $skillsPath -Directory
            $list = @()
            foreach ($dir in $subdirs) {
                $sid = $dir.Name
                $skillMdPath = Join-Path $dir.FullName "SKILL.md"
                $summary = ""
                if (Test-Path $skillMdPath) {
                    $content = Get-Content -Path $skillMdPath -Encoding utf8 -Raw
                    if ($content -match "- \*\*Description\*\*:\s*(.*)") {
                        $summary = $Matches[1].Trim()
                    } else {
                        $summary = $content.Substring(0, [Math]::Min(200, $content.Length))
                    }
                }
                $list += [PSCustomObject]@{
                    skill_id = $sid
                    summary = $summary
                }
            }
            $response = @{
                status = "Success"
                skills = $list
            }
            Write-Output (ConvertTo-Json $response -Depth 10 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error listing skills: $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "create" {
        try {
            if ([string]::IsNullOrWhiteSpace($skill_id) -or [string]::IsNullOrWhiteSpace($skill_name) -or [string]::IsNullOrWhiteSpace($description) -or [string]::IsNullOrWhiteSpace($dialog_summary)) {
                throw "Missing required parameters for create: skill_id, skill_name, description, dialog_summary."
            }

            # Naming convention validation
            if ($skill_id -notmatch "^[a-z0-9\-]+$") {
                $err = @{
                    status = "Failed"
                    log = "Error: skill_id '$skill_id' does not match lowercase-and-hyphen naming convention."
                }
                Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
                exit 1
            }

            $targetDir = Join-Path $skillsPath $skill_id
            if (Test-Path $targetDir) {
                $err = @{
                    status = "Failed"
                    log = "Error: Skill folder for '$skill_id' already exists."
                }
                Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
                exit 1
            }

            # Create directories
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            New-Item -ItemType Directory -Path (Join-Path $targetDir "scripts") -Force | Out-Null

            # Tools definition
            $toolsText = ""
            if (-not [string]::IsNullOrWhiteSpace($tools_json)) {
                $toolsText = $tools_json
            } else {
                $toolsText = "  - run_script:`r`n    - Description: 스킬 내의 스크립트를 실행합니다.`r`n    - Parameters:`r`n      - param1 (string, optional): 매개변수 예시`r`n    - Returns:`r`n      - status (string): 성공 여부`r`n      - log (string): 실행 로그"
            }

            # Create SKILL.md
            $skillMdContent = @"
# $skill_name Skill

- **Name**: $skill_name
- **Description**: $description
- **Instructions**:
  - 이 스킬은 $skill_name 작업을 위해 사용됩니다.
- **Tools**:
$toolsText
"@
            [System.IO.File]::WriteAllText((Join-Path $targetDir "SKILL.md"), $skillMdContent, [System.Text.Encoding]::UTF8)

            # Create config.json
            $configObj = [Ordered]@{
                skill_id = $skill_id
                name = $skill_name
                description = $description
                permissions = @("filesystem", "execute_scripts")
                runtime = @{
                    language = "PowerShell"
                    execution_policy = "Bypass"
                }
                entry_point = "scripts/run.ps1"
            }
            $configContent = ConvertTo-Json $configObj -Depth 5
            [System.IO.File]::WriteAllText((Join-Path $targetDir "config.json"), $configContent, [System.Text.Encoding]::UTF8)

            # Create scripts/run.ps1
            $runPs1Content = @"
param (
    [string]`$param1
)

Write-Host "Running script for $skill_name with param: `$param1"
Write-Output "Success"
"@
            [System.IO.File]::WriteAllText((Join-Path $targetDir "scripts/run.ps1"), $runPs1Content, [System.Text.Encoding]::UTF8)

            # Create HISTORY.md
            $dateStr = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $historyContent = @"
# $skill_name History

## [$dateStr] - Created new skill
- **작업 내용**: 신규 스킬 추가
- **사용자 요구사항**: $dialog_summary
- **변경 사항 요약**:
  - 기본 폴더 및 파일 구조 생성
  - SKILL.md, config.json, scripts/run.ps1 초기 템플릿 생성
"@
            [System.IO.File]::WriteAllText((Join-Path $targetDir "HISTORY.md"), $historyContent, [System.Text.Encoding]::UTF8)

            # Update root config.json
            $rootConfigPath = [System.IO.Path]::GetFullPath((Join-Path $skillsPath "../config.json"))
            if (Test-Path $rootConfigPath) {
                $rootConfig = Get-Content -Path $rootConfigPath -Encoding utf8 -Raw | ConvertFrom-Json
            } else {
                $rootConfig = [PSCustomObject]@{ enabled_skills = @() }
            }

            $enabledSkills = @()
            if ($rootConfig.enabled_skills) {
                if ($rootConfig.enabled_skills -is [Array]) {
                    $enabledSkills = $rootConfig.enabled_skills
                } else {
                    $enabledSkills = @($rootConfig.enabled_skills)
                }
            }
            if ($enabledSkills -notcontains $skill_id) {
                $enabledSkills += $skill_id
            }
            $rootConfig.enabled_skills = $enabledSkills
            $rootConfigJson = ConvertTo-Json $rootConfig -Depth 10
            [System.IO.File]::WriteAllText($rootConfigPath, $rootConfigJson, [System.Text.Encoding]::UTF8)

            $res = @{
                status = "Success"
                log = "Successfully created new skill '$skill_id'."
            }
            Write-Output (ConvertTo-Json $res -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error creating skill '$skill_id': $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "update" {
        try {
            if ([string]::IsNullOrWhiteSpace($skill_id) -or [string]::IsNullOrWhiteSpace($dialog_summary) -or [string]::IsNullOrWhiteSpace($update_targets)) {
                throw "Missing required parameters for update: skill_id, update_targets, dialog_summary."
            }

            $targetDir = Join-Path $skillsPath $skill_id
            if (-not (Test-Path $targetDir)) {
                $err = @{
                    status = "Failed"
                    log = "Error: Skill '$skill_id' does not exist."
                }
                Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
                exit 1
            }

            $backups = @()
            if (-not [string]::IsNullOrWhiteSpace($file_contents)) {
                $filesToUpdate = ConvertFrom-Json $file_contents
                
                # Verify / Backup step
                foreach ($prop in $filesToUpdate.psobject.Properties) {
                    $relPath = $prop.Name
                    $filePath = [System.IO.Path]::GetFullPath((Join-Path $targetDir $relPath))
                    
                    if (-not $filePath.StartsWith($targetDir)) {
                        throw "Path traversal attempt: $relPath"
                    }
                    
                    if (Test-Path $filePath) {
                        $backupPath = "$filePath.bak"
                        Copy-Item -Path $filePath -Destination $backupPath -Force | Out-Null
                        $backups += @{ original = $filePath; backup = $backupPath }
                    }
                }
                
                # Apply changes
                try {
                    foreach ($prop in $filesToUpdate.psobject.Properties) {
                        $relPath = $prop.Name
                        $newContent = $prop.Value
                        $filePath = [System.IO.Path]::GetFullPath((Join-Path $targetDir $relPath))
                        
                        $parentDir = Split-Path -Path $filePath -Parent
                        if (-not (Test-Path $parentDir)) {
                            New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
                        }
                        
                        [System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.Encoding]::UTF8)
                    }
                } catch {
                    # Rollback
                    foreach ($bak in $backups) {
                        if (Test-Path $bak.backup) {
                            Copy-Item -Path $bak.backup -Destination $bak.original -Force | Out-Null
                            Remove-Item -Path $bak.backup -Force | Out-Null
                        }
                    }
                    throw $_
                }

                # Clean up backups
                foreach ($bak in $backups) {
                    if (Test-Path $bak.backup) {
                        Remove-Item -Path $bak.backup -Force | Out-Null
                    }
                }
            }

            # Update HISTORY.md (prepend under header)
            $configPath = Join-Path $targetDir "config.json"
            $skillName = $skill_id
            if (Test-Path $configPath) {
                $cfg = Get-Content -Path $configPath -Encoding utf8 -Raw | ConvertFrom-Json
                if ($cfg.name) {
                    $skillName = $cfg.name
                }
            }

            $historyPath = Join-Path $targetDir "HISTORY.md"
            $existingContent = ""
            if (Test-Path $historyPath) {
                $existingContent = Get-Content -Path $historyPath -Encoding utf8 -Raw
            }

            $header = "# $skillName History"
            $bodyWithoutHeader = ""
            if ($existingContent -match "(?s)^#\s+.*?\s+History\r?\n(.*)") {
                $bodyWithoutHeader = $Matches[1].Trim()
            } elseif ($existingContent -ne "") {
                $bodyWithoutHeader = $existingContent.Trim()
            }

            $dateStr = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $newEntry = @"
## [$dateStr] - Updated skill
- **작업 내용**: 스킬 업데이트 ($update_targets)
- **사용자 요구사항**: $dialog_summary
- **변경 사항 요약**: 
  - 파일 업데이트 적용
"@

            $updatedHistory = @"
$header

$newEntry

$bodyWithoutHeader
"@
            [System.IO.File]::WriteAllText($historyPath, $updatedHistory.Trim(), [System.Text.Encoding]::UTF8)

            $res = @{
                status = "Success"
                log = "Successfully updated skill '$skill_id'."
            }
            Write-Output (ConvertTo-Json $res -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error updating skill '$skill_id': $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }

    "delete" {
        try {
            if ([string]::IsNullOrWhiteSpace($skill_id)) {
                throw "Missing required parameter: skill_id."
            }

            $targetDir = Join-Path $skillsPath $skill_id
            if (Test-Path $targetDir) {
                Remove-Item -Path $targetDir -Recurse -Force | Out-Null
            }

            # Update root config.json
            $rootConfigPath = [System.IO.Path]::GetFullPath((Join-Path $skillsPath "../config.json"))
            if (Test-Path $rootConfigPath) {
                $rootConfig = Get-Content -Path $rootConfigPath -Encoding utf8 -Raw | ConvertFrom-Json
                if ($null -ne $rootConfig.enabled_skills) {
                    $enabledSkills = @()
                    if ($rootConfig.enabled_skills -is [Array]) {
                        $enabledSkills = $rootConfig.enabled_skills
                    } else {
                        $enabledSkills = @($rootConfig.enabled_skills)
                    }
                    
                    $newEnabledSkills = @()
                    foreach ($s in $enabledSkills) {
                        if ($s -ne $skill_id) {
                            $newEnabledSkills += $s
                        }
                    }
                    $rootConfig.enabled_skills = $newEnabledSkills
                    $rootConfigJson = ConvertTo-Json $rootConfig -Depth 10
                    [System.IO.File]::WriteAllText($rootConfigPath, $rootConfigJson, [System.Text.Encoding]::UTF8)
                }
            }

            $res = @{
                status = "Success"
                log = "Successfully deleted skill '$skill_id' and updated configuration."
            }
            Write-Output (ConvertTo-Json $res -Depth 5 -Compress)
        } catch {
            $err = @{
                status = "Failed"
                log = "Error deleting skill '$skill_id': $_"
            }
            Write-Output (ConvertTo-Json $err -Depth 5 -Compress)
            exit 1
        }
    }
}
