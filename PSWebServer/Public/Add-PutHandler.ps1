    <#
    .Synopsis
       Adds an endpoint to handler PUT requests.
    .DESCRIPTION
       Long description
    .EXAMPLE
       Add-PutHandler -Path "/Service/{name}/{status}" -Script { Set-Service -Name $Parameters.Id -Status $Parameters.Status  } 
    .EXAMPLE
       Put "/Service/{name}/{status}" { Set-Service -Name $Parameters.Id -Status $Parameters.Status  } 
    #>
    function Add-PutHandler {
        param(
            [string]$Path, 
            [ScriptBlock]$Script,
            [String[]]$AuthorizedGroups)
    
        [ScriptBlock]$Script = [scriptblock]::Create('param($parameters)' + $Script.ToString())
    
        [PSCustomObject]@{
            Path = (Convert-PathParameters -Path $Path)
            Method = "Put"
            Script = $Script
            AuthorizedGroups = $AuthorizedGroups
        }
    }
    