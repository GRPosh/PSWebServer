function Invoke-PSWebServerRoute {
    [CmdletBinding()]
    param(
        [scriptblock]$Route,
        [System.Net.HttpListenerRequest]$Request,
        [PSCustomObject]$Parameters,
        [System.Security.Principal.IPrincipal]$CurrentUser
    )
    [PSCustomObject]$Query = [PSCustomObject]$Request.QueryString

    switch ($Request.HttpMethod) {

        "GET" {
            $Result = & $Route $Parameters
            return [string]$Result
        }

        "PUT" {
            $Body = Get-RequestBody -ContentType $Request.ContentType -ContentEncoding $Request.ContentEncoding -Body $Request.InputStream
            $Result = & $Route $Parameters
            return [string]$Result
        }

        "POST" {
            $Body = Get-RequestBody -ContentType $Request.ContentType -ContentEncoding $Request.ContentEncoding -Body $Request.InputStream
            $Result = & $Route $Parameters
            return [string]$Result
        }

    }
    
}
