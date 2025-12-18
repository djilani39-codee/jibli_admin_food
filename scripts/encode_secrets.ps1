<#
Usage:
  .\encode_secrets.ps1 -Path C:\path\to\AuthKey.p8 -Out key.base64.txt
This will output base64 to stdout, save to file if -Out provided, and copy to clipboard.
#>
param(
    [Parameter(Mandatory=$true)][string]$Path,
    [string]$Out
)
if (-not (Test-Path $Path)) {
    Write-Error "File not found: $Path"
    exit 1
}
try {
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $b64 = [System.Convert]::ToBase64String($bytes)
    if ($Out) {
        Set-Content -Path $Out -Value $b64 -Encoding ASCII
        Write-Output "Base64 written to $Out"
    }
    # Copy to clipboard if available
    try {
        $b64 | Set-Clipboard
        Write-Output "Base64 copied to clipboard"
    } catch {
        Write-Output "Unable to copy to clipboard: $_"
    }
    Write-Output $b64
} catch {
    Write-Error "Failed to encode file: $_"
    exit 1
}