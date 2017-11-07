    <#
    .Synopsis
       Adds an endpoint to handler GET requests.
    .DESCRIPTION
       Long description
    .EXAMPLE
       Add-GetHandler -Path "/Process" -Script { Get-Process | ConvertTo-Json } 
    .EXAMPLE
       Get "/Process" { Get-Process | ConvertTo-Json } 
    #>
    function Add-GetHandler {
        param(
            [string]$Path, 
            [ScriptBlock]$Script,
            [String[]]$AuthorizedGroups)
    
        [ScriptBlock]$Script = [scriptblock]::Create('param($parameters)' + $Script.ToString())
    
        [PSCustomObject]@{
            Path = (Convert-PathParameters -Path $Path)
            Method = "Get"
            Script = $Script
            AuthorizedGroups = $AuthorizedGroups
        }
    }