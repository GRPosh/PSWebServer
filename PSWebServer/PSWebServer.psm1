$paths = @(
    "Private",
    "Public"
)

foreach ($path in $paths) {
    "$(Split-Path -Path $MyInvocation.MyCommand.Path)\$path\*.ps1" | 
        Resolve-Path | 
            ForEach-Object { 
	            . $_.ProviderPath 
            }
}

New-Alias -Name Get -Value Add-GetHandler
New-Alias -Name Put -Value Add-PutHandler
New-Alias -Name Post -Value Add-PostHandler
New-Alias -Name Delete -Value Add-DeleteHandler
