function Stop-PSWebServer {
    param(
        [psobject]$PSWebServer = $Global:PSWebServer
    )

    $Job = Start-Job -ScriptBlock {
        param($url)
        Start-Sleep -Seconds 1
        #The job will not exit until the httplistener listen() method is closed by calling the URL
        Invoke-RestMethod $url
    } -ArgumentList $PSWebServer.url

    $PSWebServer.ServerJob | Stop-Job
    $PSWebServer.EngineEvent | Stop-Job
    
    $Job | Remove-Job -Force
}
