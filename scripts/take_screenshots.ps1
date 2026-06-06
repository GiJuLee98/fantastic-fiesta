[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$FileName,

    [Parameter(Mandatory=$false)]
    [string]$DirectoryPath = "."
)

try {
    # Directory path check and creation
    if (-not (Test-Path -Path $DirectoryPath)) {
        $null = New-Item -ItemType Directory -Path $DirectoryPath -Force
    }
    
    # Resolve directory to absolute path
    $resolvedDir = (Resolve-Path -Path $DirectoryPath).Path

    # Load required assemblies
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    # Get all screens
    $screens = [System.Windows.Forms.Screen]::AllScreens
    $successList = [System.Collections.Generic.List[string]]::new()

    for ($i = 0; $i -lt $screens.Count; $i++) {
        $screen = $screens[$i]
        $bounds = $screen.Bounds
        
        # Create bitmap and graphics objects
        $bitmap = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        
        try {
            $graphics.CopyFromScreen($bounds.X, $bounds.Y, 0, 0, $bounds.Size)
            
            # Construct output file name
            $outputFile = Join-Path -Path $resolvedDir -ChildPath "$($FileName)_$i.png"
            $bitmap.Save($outputFile, [System.Drawing.Imaging.ImageFormat]::Png)
            
            # Absolute path and device name format
            $fullPath = (Get-Item -Path $outputFile).FullName
            $successList.Add("$fullPath : $($screen.DeviceName)")
        }
        finally {
            if ($graphics -ne $null) { $graphics.Dispose() }
            if ($bitmap -ne $null) { $bitmap.Dispose() }
        }
    }

    # Success output
    Write-Output "Result: Success"
    foreach ($item in $successList) {
        Write-Output $item
    }
}
catch {
    # Failure output
    Write-Output "Result: Failure"
    Write-Error $_.Exception.Message
    exit 1
}
