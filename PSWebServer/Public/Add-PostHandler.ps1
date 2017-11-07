    <#
    .Synopsis
       Adds an endpoint to handler POST requests.
    .DESCRIPTION
       Long description
    .EXAMPLE
       Add-PostHandler -Path "/Process" -Script { Start-Process $Name } 
    .EXAMPLE
       Post"/Process" { Start-Process $Name } 
    #>
    function Add-PostHandler {
        param(
            [string]$Path, 
            [ScriptBlock]$Script,
            [String[]]$AuthorizedGroups)
    
        [ScriptBlock]$Script = [scriptblock]::Create('param($parameters)' + $Script.ToString())
    
        [PSCustomObject]@{
            Path = (Convert-PathParameters -Path $Path)
            Method = "Post"
            Script = $Script
            AuthorizedGroups = $AuthorizedGroups
        }
    }
    