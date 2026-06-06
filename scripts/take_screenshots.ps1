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

    # DPI Awareness setup (P/Invoke to SetProcessDpiAwarenessContext or SetProcessDPIAware)
    # DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 = -4
    $loaded = $false
    try {
        $null = [WinAPI.DpiUtil]
        $loaded = $true
    } catch {
        $loaded = $false
    }

    if (-not $loaded) {
        $dpiCode = @"
        using System;
        using System.Runtime.InteropServices;

        namespace WinAPI
        {
            public static class DpiUtil
            {
                [DllImport("user32.dll", SetLastError = true)]
                public static extern bool SetProcessDpiAwarenessContext(IntPtr value);

                [DllImport("user32.dll")]
                public static extern bool SetProcessDPIAware();

                public static bool SetDpiAware()
                {
                    try
                    {
                        // Attempt to set Per Monitor Aware V2 context (-4)
                        if (SetProcessDpiAwarenessContext((IntPtr)(-4)))
                        {
                            return true;
                        }
                    }
                    catch {}
                    
                    try
                    {
                        // Attempt to set Per Monitor Aware context (-3)
                        if (SetProcessDpiAwarenessContext((IntPtr)(-3)))
                        {
                            return true;
                        }
                    }
                    catch {}

                    try
                    {
                        return SetProcessDPIAware();
                    }
                    catch
                    {
                        return false;
                    }
                }
            }
        }
"@
        Add-Type -TypeDefinition $dpiCode
    }

    # Load required assemblies
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    # Call DPI awareness function
    $null = [WinAPI.DpiUtil]::SetDpiAware()

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
