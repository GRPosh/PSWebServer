    <#
    .Synopsis
       Adds an endpoint to handler DELETE requests.
    .DESCRIPTION
       Long description
    .EXAMPLE
       Add-DeleteHandler -Path "/Process/{id}" -Script { Stop-Process $Parameters.Id } 
    .EXAMPLE
       Delete "/Process/{id}" { Stop-Process $Parameters.Id } 
    #>
    function Add-DeleteHandler {
        param(
            [string]$Path, 
            [ScriptBlock]$Script,
            [String[]]$AuthorizedGroups)
    
        [ScriptBlock]$Script = [scriptblock]::Create('param($parameters)' + $Script.ToString())
    
        [PSCustomObject]@{
            Path = (Convert-PathParameters -Path $Path)
            Method = "Delete"
            Script = $Script
            AuthorizedGroups = $AuthorizedGroups
        }
    }
    